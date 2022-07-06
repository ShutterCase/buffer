import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon? icon;
  final Widget? suffixicon;
  final FormFieldValidator<String?>? validator;
  const CustomTextField(
      {Key? key,
      required this.textEditingController,
      required this.textInputType,
      required this.hintText,
      this.icon,
      this.suffixicon,
      this.isPass = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: suffixicon,
        prefixIcon: icon,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
