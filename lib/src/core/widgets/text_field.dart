// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../extensions/build_context.dart';
// import '../../theme/colors/colors.dart';
// import '../../theme/font_styles/font_styles.dart';
// import 'dart:ui' as ui;
// import 'dart:ui' as ui;
// class TextFieldWidget extends StatefulWidget {
//   const TextFieldWidget({
//     super.key,
//     this.onChanged,
//     this.maxLength,
//     this.hint,
//     this.leading,
//     this.validator,
//     this.enabled = true,
//     this.controller,
//     this.initialText,
//     this.expands = false,
//     this.height,
//     this.errorText,
//     this.trailingIcon,
//     this.keyboardType,
//     this.node,
//     this.label,
//     this.isPassword = false,
//     this.hintStyle,
//     this.color,
//     this.onSubmitted,
//     this.inputFormatters,
//     this.labelStyle,
//     this.autoFillHint,
//     this.maxLines,
//     this.prefixWidth,
//     this.isNumeric = false,
//     this.borderColor,
//     this.disableFontStyle,
//     this.overrideStyle = true,
//     this.textAlign,
//     this.textStyle,
//     this.radius,
//     this.onTapOutside,
//     this.contentPadding,
//     this.disableErrorText = true,
//   });
//   final String? hint;
//   final int? maxLength;
//   final Widget? leading;
//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String>? onSubmitted;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? Function(String?)? validator;
//   final bool enabled;
//   final int? maxLines;
//   final TextEditingController? controller;
//   final String? initialText;
//   final bool expands;
//   final double? height;
//   final String? errorText;
//   final Widget? trailingIcon;
//   final TextInputType? keyboardType;
//   final FocusNode? node;
//   final String? label;
//   final bool isPassword;
//   final TextStyle? hintStyle;
//   final Color? color;
//   final TextStyle? labelStyle;
//   final List<String>? autoFillHint;
//   final double? prefixWidth;
//   final bool isNumeric;
//   final Color? borderColor;
//   final TextStyle? disableFontStyle;
//   final bool overrideStyle;
//   final TextAlign? textAlign;
//   final TextStyle? textStyle;
//   final double? radius;
//   final VoidCallback? onTapOutside;
//   final EdgeInsetsGeometry? contentPadding;
//   final bool disableErrorText;
//
//   @override
//   State<TextFieldWidget> createState() => _TextFieldWidgetState();
// }
//
// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   late FocusNode defaultNode;
//   Color? labelColor = Colors.black;
//   @override
//   void initState() {
//     super.initState();
//     // defaultNode = widget.node ?? FocusNode();
//     // defaultNode.addListener(onFocusChange);
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.label != null)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: Text(
//               widget.label?.tr() ?? "",
//               style: widget.labelStyle ??
//                   FontStyles.instance.p12.copyWith(
//                     fontWeight: FontWeight.w400,
//                     // color: AppColors.text3,
//                   ),
//             ),
//           ),
//         SizedBox(
//           width: context.width,
//           height: widget.height,
//           child: TextFormField(
//             obscuringCharacter: "●",
//             onTapOutside: (v) {
//               if (widget.onTapOutside != null) {
//                 widget.onTapOutside!();
//               } else {
//                 FocusScope.of(context).unfocus();
//               }
//             },
//             cursorColor: AppColors.primary,
//             textAlign: widget.textAlign ?? TextAlign.start,
//             maxLength: widget.maxLength,
//             autofillHints: widget.autoFillHint,
//             key: widget.key,
//             onEditingComplete: () {
//               widget.node?.unfocus();
//               FocusScope.of(context).unfocus();
//             },
//             autofocus: false,
//             expands: widget.expands,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             onFieldSubmitted: widget.onSubmitted,
//             focusNode: widget.node,
//             keyboardType: widget.keyboardType ??
//                 (widget.expands
//                     ? TextInputType.multiline
//                     : widget.isNumeric
//                         ? TextInputType.number
//                         : TextInputType.text),
//             validator: widget.validator,
//             inputFormatters: widget.inputFormatters ??
//                 (widget.isNumeric
//                     ? [FilteringTextInputFormatter.digitsOnly]
//                     : null),
//             enabled: widget.enabled,
//             obscureText: widget.isPassword,
//             textAlignVertical: TextAlignVertical.top,
//             style: widget.textStyle ??
//                 FontStyles.instance.p16Medium.copyWith(
//                   fontSize: 14.sp,
//                 ),
//             controller: widget.controller,
//             initialValue: widget.initialText,
//             onChanged: widget.onChanged,
//             maxLines: widget.maxLines ?? (widget.expands ? null : 1),
//             decoration: InputDecoration(
//               counterText: "",
//               contentPadding: widget.contentPadding,
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               // fillColor: widget.color ?? AppColors.textFieldColor,
//               filled: widget.color != null,
//               prefixIconConstraints: BoxConstraints(
//                 maxWidth: widget.prefixWidth ?? 100,
//               ),
//               suffixIconConstraints: BoxConstraints(
//                 maxWidth: widget.prefixWidth ?? 100,
//               ),
//               prefixIcon: widget.leading != null
//                   ? Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 14),
//                       child: widget.leading,
//                     )
//                   : null,
//               suffixIcon: widget.trailingIcon != null
//                   ? Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 14),
//                       child: widget.trailingIcon,
//                     )
//                   : null,
//               hintText: tr(widget.hint ?? ""),
//               hintStyle: widget.hintStyle ??
//                   FontStyles.instance.hintStyle.copyWith(
//                     color: AppColors.tertiaryText,
//                     height: 2,
//                   ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.radius ?? 10),
//                 borderSide: BorderSide(
//                   color: widget.borderColor ?? AppColors.t4,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.radius ?? 10),
//                 borderSide: BorderSide(
//                   color: widget.borderColor ?? AppColors.primary,
//                 ),
//               ),
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.radius ?? 10),
//                 borderSide: const BorderSide(
//                     // color: widget.borderColor ?? AppColors.textFieldBorderColor,
//                     ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.radius ?? 10),
//                 borderSide: const BorderSide(
//                   color: Colors.redAccent,
//                   width: 1,
//                 ),
//               ),
//               errorStyle: TextStyle(
//                 color: Colors.red,
//                 fontWeight: FontWeight.w500,
//                 fontSize: widget.disableErrorText ? 10.sp : 0,
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.radius ?? 10),
//                 borderSide: BorderSide(
//                   color: AppColors.t4,
//                 ),
//               ),
//
//               hintMaxLines: 2,
//
//               alignLabelWithHint: true,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
