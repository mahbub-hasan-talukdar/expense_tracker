import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: _boxDecoration(theme),
        child: _textfield(theme),
      ),
    );
  }

  _boxDecoration(ThemeData theme) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      boxShadow: [
        _boxShadow(theme),
      ],
    );
  }

  _boxShadow(ThemeData theme) {
    return BoxShadow(
      color: theme.colorScheme.primary.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 4,
      offset: const Offset(0, 4),
    );
  }

  _textfield(ThemeData theme) {
    return TextField(
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: _decoration(theme),
    );
  }

  _decoration(ThemeData theme) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: theme.colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
    );
  }
  
  
}
