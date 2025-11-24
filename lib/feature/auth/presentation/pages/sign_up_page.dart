import 'package:fire/core/extension/widget_extension.dart';
import 'package:fire/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulHookWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emaliController=TextEditingController();
  final _passordController=TextEditingController();
  final ValueNotifier<bool>isObsecure=ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final _formKey=useMemoized(()=>GlobalKey<FormState>());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('S I G N  U P',style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
           Form(
             key: _formKey,
               child: SingleChildScrollView(
             child: Column(
               children: [
                 CustomTextFormField(
                   labelText: 'Email',
                     hintText: 'Please Enter your Email',
                     validator: (value){
                   if(value==null || value.isEmpty){
                     return 'Please enter your email';
                   }else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                     return 'Please enter a valid email address';
                   }
                   return null;
                 }).pB(16.sp).pT(16.sp),
                 ValueListenableBuilder(
                   valueListenable: isObsecure,
                   builder: (context, _isObsecure, child) {
                     return CustomTextFormField(
                       suffixIcon: InkWell(
                         onTap: ()=>isObsecure.value=!isObsecure.value,
                         child: Icon(_isObsecure?Icons.visibility_off_rounded:Icons.visibility_outlined),
                       ),
                         isObsecure: _isObsecure,
                         labelText: 'Password',
                         hintText: 'Please Enter your Email',
                         validator: (value){
                           if(value==null || value.isEmpty){
                             return 'Please enter your email';
                           }else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                             return 'Please enter a valid email address';
                           }
                           return null;
                         }).pB(16.sp).pT(16.sp);
                   }
                 ).pB(24.sp),

               ],
             ),
           ))
          ],
        ),
      ),
    );
  }
}
