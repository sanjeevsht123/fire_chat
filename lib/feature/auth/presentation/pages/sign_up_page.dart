import 'package:fire/core/extension/widget_extension.dart';
import 'package:fire/core/widgets/custom_button.dart';
import 'package:fire/core/widgets/custom_dialog.dart';
import 'package:fire/core/widgets/custom_text_form_field.dart';
import 'package:fire/feature/auth/presentation/bloc/sign_up_cubit.dart';
import 'package:fire/feature/auth/presentation/bloc/sign_up_state.dart';
import 'package:fire/feature/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulHookWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emaliController = TextEditingController();
  final _passordController = TextEditingController();
  final ValueNotifier<bool> isObsecure = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'S I G N  U P',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _emaliController,
                      labelText: 'Email',
                      hintText: 'Please Enter your Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                          r'^[^@]+@[^@]+\.[^@]+',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ).pB(16.sp).pT(16.sp),
                    ValueListenableBuilder(
                      valueListenable: isObsecure,
                      builder: (context, _isObsecure, child) {
                        return CustomTextFormField(
                          controller: _passordController,
                          suffixIcon: InkWell(
                            onTap: () => isObsecure.value = !isObsecure.value,
                            child: Icon(
                              _isObsecure
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_outlined,
                            ),
                          ),
                          isObsecure: _isObsecure,
                          labelText: 'Password',
                          hintText: 'Please Enter your Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ).pB(16.sp).pT(16.sp);
                      },
                    ).pB(24.sp),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).pXScreenDefault,
      bottomNavigationBar: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: ()=>0.verticalSpace,
              loading: ()=>showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (errorMessage) {
                Navigator.of(context).pop();
                // Show error dialog
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    type: DialogType.error,
                    title: 'Sign Up Failed',
                    message: errorMessage ?? 'An error occurred. Please try again.',
                  ),
                );
              },
              success: (data){
            final response=data.user;
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => CustomDialog(
                type: DialogType.success,
                title: 'Account Created',
                message: 'Go to Login',
                onOkPressed: (){
                  Navigator.of(context).maybePop().then((_){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginPage()));
                  });
                },
              ),
            );              }
          );
        },
        child: CustomButton(
          onPressed: () {
            final _isFormValid = _formKey.currentState?.validate() ?? false;
            print('Is Valid:$_isFormValid');
            if (_isFormValid) {
              final email = _emaliController.text;
              final passwd = _passordController.text;
              context.read<SignUpCubit>().signUp(email: email, passwd: passwd);
            }
          },
          btnText: 'Sign up',
        ),
      ).pB(42.sp).pXScreenDefault,
    );
  }
}
