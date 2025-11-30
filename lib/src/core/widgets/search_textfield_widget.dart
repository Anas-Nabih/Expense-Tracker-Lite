// import 'package:flutter/material.dart';
// import 'package:touring_user/gen/assets.gen.dart';
// import 'package:touring_user/src/src/core/widgets/text_fields/text_field.dart';
//
//
// class SearchTextFieldWidget extends StatelessWidget {
//   const SearchTextFieldWidget({
//     super.key,
//     this.hint,
//     this.isEnabled = true,
//     this.onChanged,
//     this.onTap,
//     this.trailing,
//     this.controller,
//   });
//   final String? hint;
//   final bool isEnabled;
//   final Function(String)? onChanged;
//   final Function()? onTap;
//   final Widget? trailing;
//   final TextEditingController? controller;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: TextFieldWidget(
//         controller: controller,
//         leading: Assets.images.icSearch.svg(),
//         hint: hint,
//         radius: 30,
//         enabled: isEnabled,
//         onChanged: onChanged,
//         trailingIcon: trailing,
//       ),
//     );
//   }
// }
