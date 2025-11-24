import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.isObsecure,
    required this.validator,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String? labelText;
  final bool? isObsecure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObsecure ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
