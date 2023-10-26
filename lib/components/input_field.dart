import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final String validatingMessage;
  final bool shouldValidate;
  final Icon? prefixIcon;
  final bool disabled;
  final TextInputType inputType;
  const CustomInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.shouldValidate = true,
    this.prefixIcon,
    this.validatingMessage = "Please fill this field",
    this.disabled = true,
    this.inputType = TextInputType.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        enabled: disabled,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          prefixIcon: prefixIcon,
        ),
        keyboardType: inputType,
        controller: controller,
        obscureText: isPassword,
        validator: shouldValidate
            ? (val) => val != null
                ? val.isEmpty
                    ? validatingMessage
                    : null
                : null
            : null,
      ),
    );
  }
}
