import 'package:fire/core/extension/widget_extension.dart';
import 'package:fire/core/widgets/custom_button.dart';
import 'package:fire/core/widgets/custom_dialog.dart';
import 'package:fire/feature/auth/presentation/bloc/sign_up_cubit.dart';
import 'package:fire/feature/auth/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool> isObscuredText=ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  16.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: isObscuredText,
                    builder: (context, isObscured, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  child: Icon(isObscured?Icons.visibility_off_rounded:Icons.visibility_outlined),
                                  onTap: () {
                                    isObscuredText.value=!isObscuredText.value;
                                  },
                                ),
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              obscureText: isObscured,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ],
              ),
            ).pT(16.sp),
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
                  title: 'Login Failed',
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
                  title: 'Login Successful',
                  message: 'Welcome, ${response?.displayName ?? 'User'}!',
                ),
              );              }
          );
        },
        child: Builder(
          builder: (context) {
            return CustomButton(
              onPressed: (){
                final isFormValid = formKey.currentState?.validate() ?? false;
                if (isFormValid) {
                  final email = _emailController.text;
                  final passwd = _passwordController.text;
                  context.read<SignUpCubit>().signUp(
                    email: email,
                    passwd: passwd,
                  );
                }
              },
              btnText: 'Login',
            );
            // return GestureDetector(
            //   onTap: () {
            //     final isFormValid = formKey.currentState?.validate() ?? false;
            //     if (isFormValid) {
            //       final email = _emailController.text;
            //       final passwd = _passwordController.text;
            //       context.read<SignUpCubit>().signUp(
            //         email: email,
            //         passwd: passwd,
            //       );
            //     }
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Theme.of(context).colorScheme.primary,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     width: double.infinity,
            //     height: 50.h,
            //     child: Center(
            //       child: Text(
            //         'Login',
            //         style: TextStyle(color: Colors.white, fontSize: 12.sp),
            //       ),
            //     ),
            //   ).pB(42.sp).pXScreenDefault,
            // );
          },
        ),
      ),
    );
  }
}
