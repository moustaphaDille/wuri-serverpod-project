import 'package:flutter/material.dart';

import 'package:wuri_flutter/theme/app_theme.dart';

/// Un champ de formulaire avec son libellé au-dessus.
class LabeledField extends StatelessWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.autocorrect = true,
    this.hint,
    this.helper,
    this.textAlign = TextAlign.start,
    this.style,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool autocorrect;
  final String? hint;
  final String? helper;
  final TextAlign textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.muted,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          autocorrect: autocorrect,
          textAlign: textAlign,
          style: style,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helper,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}