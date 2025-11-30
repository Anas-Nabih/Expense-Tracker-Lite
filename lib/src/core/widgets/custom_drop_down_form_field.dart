import 'package:expense_tracker_lite/src/core/theme/app_colors.dart';
import 'package:expense_tracker_lite/src/core/theme/app_styles.dart';
import 'package:expense_tracker_lite/src/core/widgets/custom_svg.dart';
import 'package:expense_tracker_lite/src/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField(
      {super.key,
      this.hintText,
      required this.items,
      required this.onSelected,
      this.value,
      this.validator,
      this.label});

  final String? label;
  final String? value;
  final String? hintText;
  final List<String> items;
  final Function(String?) onSelected;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return label != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  label!,
                  style: AppStyles.styleMedium20(context),
                ),
              ),
              DropdownButtonFormField<String>(
                icon: CustomSvg(
                  path: Assets.images.icArrowIosDownward,
                  color: Colors.black87,
                ),
                value: value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.textFieldFillColor,
                  border: InputBorder.none,
                ),
                hint: Text("$hintText",
                    style: AppStyles.styleSemiBold18(context)
                        .copyWith(color: AppColors.hintColor)),
                dropdownColor: Colors.white,
                onChanged: onSelected,
                validator: validator,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          )
        : DropdownButtonFormField<String>(
            icon: CustomSvg(
              path: Assets.images.icArrowIosDownward,
              color: Colors.black87,
            ),
            value: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textFieldFillColor,
              contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0), // المهم

              border: borderDecoration(),
              disabledBorder: borderDecoration(),
              focusedBorder: borderDecoration(),
              enabledBorder: borderDecoration(),
            ),
            hint: Text("$hintText",
                style: AppStyles.styleSemiBold18(context)
                    .copyWith(color: AppColors.hintColor)),
            dropdownColor: Colors.white,
            onChanged: onSelected,
            validator: validator,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                style: AppStyles.styleRegular20(context),),
              );
            }).toList(),
          );
  }

  InputBorder borderDecoration() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
       borderRadius: BorderRadius.circular(8.r),
    );
  }
}
