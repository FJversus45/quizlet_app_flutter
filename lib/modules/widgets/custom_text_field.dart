import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText, prefixText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final FocusNode? focusNode;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle, prefixStyle;
  final TextStyle? errorStyle;
  final TextStyle? style;
  final String? suffixText;
  final InputDecoration? decoration;
  final AutovalidateMode? autoValidateMode;
  final TextCapitalization? textCapitalization;
  final bool withBorder, withBottomInset;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor, borderColor;
  final TextAlign textAlign;
  final int? minLines;
  final int? maxLines;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final double? borderRadius;

  const CustomTextField({
    super.key,
    this.contentPadding,
    this.labelText,
    this.prefixText,
    this.initialValue,
    this.style,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.controller,
    this.labelStyle,
    this.hintStyle,
    this.prefixStyle,
    this.errorStyle,
    this.suffixText,
    this.decoration,
    this.autoValidateMode,
    this.maxLength,
    this.enabled = true,
    this.obscureText = false,
    this.textCapitalization,
    this.withBorder = true,
    this.withBottomInset = true,
    this.fillColor,
    this.borderColor,
    this.textAlign = TextAlign.left,
    this.textInputAction = TextInputAction.done,
    this.minLines,
    this.maxLines,
    this.onSubmitted,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final underlinedInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      borderSide: !withBorder
          ? BorderSide.none
          : BorderSide(color: borderColor ?? Color(0xFFF1F0F0), width: 1),
    );

    final underlinedInputErrorBorder = underlinedInputBorder.copyWith(
      borderSide: underlinedInputBorder.borderSide.copyWith(color: Colors.red),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style:
                labelStyle ??
                GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
          ),
          Gap(8),
        ],
        TextFormField(
          onTap: onTap,
          controller: controller,
          textAlign: textAlign,
          onSaved: (input) => onSaved?.call((input ?? "").trim()),
          autovalidateMode: autoValidateMode,
          obscureText: obscureText,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          initialValue: initialValue,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          enabled: enabled,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          validator: validator,
          textAlignVertical: TextAlignVertical.center,
          // textAlign: TextAlign.center,
          onFieldSubmitted: onSubmitted,
          style:
              style ??
              GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black,
              ),

          cursorColor: Colors.green,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          decoration:
              decoration ??
              InputDecoration(
                filled: true,
                fillColor: fillColor ?? Color(0xFFFCFCFC),
                suffixText: suffixText,
                prefixText: prefixText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                suffixIconColor: Colors.black,
                hintText: hintText,
                errorText: errorText,
                errorStyle:
                    errorStyle ??
                    GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ).copyWith(fontStyle: FontStyle.italic),
                prefixStyle:
                    prefixStyle ??
                    GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                labelStyle: labelStyle,
                hintStyle:
                    hintStyle ??
                    GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey,
                    ),

                contentPadding:
                    contentPadding ??
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                border: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 5),
                        borderSide: BorderSide(
                          width: 1.2,
                          color: borderColor ?? Color(0xFFF1F0F0),
                        ),
                      )
                    : underlinedInputBorder,
                enabledBorder: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 5),
                        borderSide: BorderSide(
                          width: 1.2,
                          color: borderColor ?? Color(0xFFF1F0F0),
                        ),
                      )
                    : underlinedInputBorder,
                focusedBorder: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 5),
                        borderSide: BorderSide(
                          width: 1.2,
                          color: borderColor ?? Color(0xFFF1F0F0),
                        ),
                      )
                    : underlinedInputBorder,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                focusedErrorBorder: underlinedInputErrorBorder,
                disabledBorder: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 5),
                        borderSide: BorderSide(
                          width: 1.2,
                          color: borderColor ?? Color(0xFFF1F0F0),
                        ),
                      )
                    : underlinedInputBorder,
              ),
        ),
        if (withBottomInset) Gap(8),
      ],
    );
  }
}
