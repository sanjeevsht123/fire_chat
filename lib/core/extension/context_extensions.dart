// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nds_e_wallet_app/gen/assets.gen.dart';
// import 'package:nds_e_wallet_app/l10n/l10n.dart';
// import 'package:nds_e_wallet_app/src/app/app.dart';
// import 'package:nds_e_wallet_app/src/core/di/injection.dart';
// import 'package:nds_e_wallet_app/src/core/extensions/num_extensions.dart';
// import 'package:nds_e_wallet_app/src/core/extensions/text_style_extensions.dart';
// import 'package:nds_e_wallet_app/src/core/routes/app_router.dart';
// import 'package:nds_e_wallet_app/src/core/themes/themes.dart';
//
// extension ContextX on BuildContext {
//   ///width and height getter
//   double get width => MediaQuery.of(this).size.width;
//
//   double get height => MediaQuery.of(this).size.height;
//   double get keyboardPadding => MediaQuery.of(this).viewInsets.bottom;
//
//   ///paddings getter
//   EdgeInsets get padding => MediaQuery.of(this).padding;
//
//   EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
//
//   EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
//
//   void showSuccessSnackbar(
//       {required String title,
//       required String message,
//       double? padding,
//       int? seconds}) {
//     final _context = getIt<AppRouter>().navigatorKey.currentContext ?? this;
//
//     OverlayState? overlayState = Overlay.of(this);
//     OverlayEntry? overlayEntry;
//
//     overlayEntry = OverlayEntry(builder: (context) {
//       return Positioned(
//         top: _context.padding.top + (padding ?? 40),
//         width: _context.width,
//         child: Material(
//           color: AppColors.transparent,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor,
//               borderRadius: 17.rounded,
//             ),
//             margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
//             padding:
//                 const EdgeInsets.only(left: 18, top: 15, right: 12, bottom: 12),
//             width: double.infinity,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style:
//                         AppStyles.text14PxMedium.whiteColor.lineHeight(16.59)),
//                 const SizedBox(height: 6),
//                 Text(
//                   message,
//                   style: AppStyles.text14PxRegular
//                       .lineHeight(16.59)
//                       .copyWith(color: AppColors.whiteColor.withOpacity(0.7)),
//                   // overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//
//     overlayState.insert(overlayEntry);
//     Future.delayed(Duration(seconds: (seconds ?? 4))).then((value) {
//       overlayEntry?.remove();
//     });
//   }
//
//   void showSwitchSnackbar({
//     required String title,
//     required String message,
//   }) {
//     final _context = getIt<AppRouter>().navigatorKey.currentContext ?? this;
//
//     OverlayState? overlayState = Overlay.of(_context);
//     OverlayEntry? overlayEntry;
//
//     overlayEntry = OverlayEntry(builder: (context) {
//       return Positioned(
//         top: _context.padding.top + 40,
//         width: _context.width,
//         child: Material(
//           color: AppColors.transparent,
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     left: BorderSide(width: 2.w, color: AppColors.primaryColor),
//                   ),
//                   color: Colors.white,
//                   // borderRadius: 10.rounded,
//                 ),
//                 margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
//                 padding: const EdgeInsets.only(
//                     left: 18, top: 15, right: 12, bottom: 12),
//                 width: double.infinity,
//                 child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(title,
//                                 style: AppStyles.text14PxMedium.primary
//                                     .lineHeight(16.59)),
//                             const SizedBox(height: 6),
//                             Text(message,
//                                 style: AppStyles.text14PxRegular.greyColor
//                                     .lineHeight(16.59)),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           overlayEntry?.remove();
//                         },
//                         child: Assets.icons.crossIcon
//                             .svg(color: AppColors.blackColor),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 22, right: 20),
//                 child: LinearProgressIndicator(),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//
//     overlayState.insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 5)).then((value) {
//       overlayEntry?.remove();
//     });
//   }
//
//   void noInternet()
//       {
//         scaffoldKey.currentState
//             ?.removeCurrentSnackBar();
//         Future.delayed(const Duration(milliseconds: 300),(){
//           scaffoldKey.currentState?.showSnackBar(
//             SnackBar(
//               content: SizedBox(
//                 height: 32,
//                 child: Row(
//                   mainAxisAlignment:
//                   MainAxisAlignment.center,
//                   crossAxisAlignment:
//                   CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.wifi,
//                       color: AppColors.whiteColor,
//                       size: 20.sp,
//                     ),
//                     8.horizontalSpace,
//                     Center(
//                       child: Text(
//                         l10n.noInternetConnection,
//                         style: AppStyles
//                             .text12PxMedium
//                             .whiteColor,
//                         maxLines: 2,
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               duration: const Duration(days: 1),
//               backgroundColor: AppColors.lightRedColor,
//               behavior: SnackBarBehavior.floating,
//               dismissDirection: DismissDirection.none,
//             ),
//           );
//         });
//        }
//
//   void showErrorSnackBar({
//     required String title,
//     required String message,
//     String? buttonText,
//     VoidCallback? onButtonTap,
//   }) {
//     final _context = getIt<AppRouter>().navigatorKey.currentContext ?? this;
//
//     OverlayState? overlayState = Overlay.of(_context);
//     OverlayEntry overlayEntry;
//
//     overlayEntry = OverlayEntry(builder: (context) {
//       return Positioned(
//         top: _context.padding.top + 40,
//         width: _context.width,
//         child: Material(
//           color: AppColors.transparent,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.errorInputBorderColor,
//               borderRadius: 17.rounded,
//             ),
//             margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
//             padding:
//                 const EdgeInsets.only(left: 18, top: 15, right: 12, bottom: 12),
//             width: double.infinity,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style:
//                         AppStyles.text14PxMedium.whiteColor.lineHeight(16.59)),
//                 const SizedBox(height: 6),
//                 Text(
//                   message,
//                   style: AppStyles.text14PxRegular
//                       .lineHeight(16.59)
//                       .copyWith(color: AppColors.whiteColor.withOpacity(0.7)),
//                   // overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//     overlayState.insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 4)).then((value) {
//       overlayEntry.remove();
//     });
//   }
//
//   void removeFocus() {
//     if (FocusScope.of(this).hasFocus || FocusScope.of(this).hasPrimaryFocus) {
//       FocusScope.of(this).unfocus();
//     }
//   }
// }
