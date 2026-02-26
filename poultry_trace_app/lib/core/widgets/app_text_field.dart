import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/theme/colors.dart';

/// Reusable text field widget with consistent styling
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText && !_isPasswordVisible,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      autofocus: widget.autofocus,
      textCapitalization: widget.textCapitalization,
      textAlign: widget.textAlign,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppColors.textSecondary)
            : null,
        suffixIcon: _buildSuffixIcon(),
        filled: true,
        fillColor: widget.enabled ? AppColors.surface : AppColors.surfaceVariant,
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textSecondary,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      );
    }

    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixTap,
        child: widget.suffixIcon,
      );
    }

    return null;
  }
}

/// Number input text field
class AppNumberField extends StatelessWidget {
  const AppNumberField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.validator,
    this.onChanged,
    this.allowDecimal = false,
    this.allowNegative = false,
    this.prefixIcon,
    this.suffix,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool allowDecimal;
  final bool allowNegative;
  final IconData? prefixIcon;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      errorText: errorText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: TextInputType.numberWithOptions(
        decimal: allowDecimal,
        signed: allowNegative,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(allowDecimal 
            ? (allowNegative ? r'^-?\d*\.?\d*' : r'^\d*\.?\d*')
            : (allowNegative ? r'^-?\d*' : r'^\d*')),
        ),
      ],
      prefixIcon: prefixIcon,
      suffixIcon: suffix != null
          ? Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                suffix!,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            )
          : null,
    );
  }
}
