// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:touring_user/gen/assets.gen.dart';
// import 'package:touring_user/src/src/core/service_locator/dependency_injection.dart';
// import 'package:touring_user/src/src/core/ui_utils/validations.dart';
// import 'package:touring_user/src/src/core/widgets/custom_svg.dart';
// import 'package:touring_user/src/src/core/widgets/text_fields/text_field.dart';
//
// class PhoneTextField extends StatelessWidget {
//   const PhoneTextField({
//     super.key,
//     this.hint,
//     this.onChanged,
//   });
//
//   final String? hint;
//   final ValueChanged<String>? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: TextFieldWidget(
//         validator: sl<Validations>().validateMobile,
//         hint: hint ?? "phone_number",
//         onChanged: onChanged,
//         leading: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Assets.images.icArabic.image(
//               width: 22.r,
//               height: 22.r,
//             ),
//             Padding(
//               padding: const EdgeInsetsDirectional.only(start: 10),
//               child: CustomSvg(
//                 path: Assets.images.icArrowDown.path,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
