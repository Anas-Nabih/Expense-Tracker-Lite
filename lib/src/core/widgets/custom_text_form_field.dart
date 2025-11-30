import 'package:expense_tracker_lite/src/core/theme/app_colors.dart';
import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isEnabled = true,
    this.controller,
    this.onSubmitted,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconTapped,
    this.inputFormatters,
  });

  final String label;
  final String hintText;
  final String? initialValue;
  final bool? isEnabled;
  final Widget? suffixIcon;
  final Function()? onSuffixIconTapped;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(
            label,
            style: AppStyles.styleMedium20(context),
          ),
        ),
        GestureDetector(
          onTap: isEnabled == false && onSuffixIconTapped != null
              ? onSuffixIconTapped
              : null,
          child: AbsorbPointer(
            absorbing: isEnabled == false,
            child: TextFormField(
              enabled: isEnabled,
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              cursorColor: AppColors.primaryColor,
              textInputAction: textInputAction,
              keyboardType: inputType,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                  isDense: true,
                  fillColor: AppColors.textFieldFillColor,
                  filled: true,
                  hintText: hintText,
                  hintStyle: AppStyles.styleSemiBold18(context)
                      .copyWith(color: AppColors.hintColor),
                  suffixIcon: _suffixIcon,
                  border: InputBorder.none,
                  helperText: ' ',

                  focusedBorder: borderDecoration(),
                  enabledBorder: borderDecoration(),
                  disabledBorder: borderDecoration()),
            ),
          ),
        ),
      ],
    );
  }

  InputBorder borderDecoration() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldFillColor),
      borderRadius: BorderRadius.circular(8.r),
    );
  }

  Widget? get _suffixIcon {
    if (suffixIcon == null) return null;

    return GestureDetector(
      onTap: onSuffixIconTapped,
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: suffixIcon,
      ),
    );
  }
}
