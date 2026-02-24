// import 'package:fire/core/widgets/scaffold_wrapper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _imageOffsetAnimation;
//   late Animation<Offset> _textOffsetAnimation;
//   late Animation<double> _sideImageOpacityAnimation;
//   late Animation<Offset> _bottomImageOffsetAnimation;
//   late Animation<double> _bottomImageOpacityAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//
//     // Scale down the center image from 1.0 to 0.5 over the first 1 second
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.0, 0.33, curve: Curves.easeInOut),
//       ),
//     );
//
//     // Move center image upward by 100 pixels over the first 1 second
//     _imageOffsetAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: Offset(0, -100),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.0, 0.33, curve: Curves.easeInOut),
//       ),
//     );
//
//     // Move text upward by 100 pixels over the first 1 second
//     _textOffsetAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: Offset(0, -100),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.0, 0.33, curve: Curves.easeInOut),
//       ),
//     );
//
//     // Fade in the side image after 1 second, over the next 1 second
//     _sideImageOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.33, 0.66, curve: Curves.easeIn),
//       ),
//     );
//
//     // Slide up and fade in the bottom image slowly from off-screen below over the last 1 second
//     _bottomImageOffsetAnimation = Tween<Offset>(
//       begin: const Offset(0, 5.0), // Start far below (adjust multiplier if needed for screen size)
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.66, 1.0, curve: Curves.easeOut),
//       ),
//     );
//
//     _bottomImageOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.66, 1.0, curve: Curves.easeOut),
//       ),
//     );
//
//     // Start the animation
//     _controller.forward();
//
//     // Optional: Navigate to next screen after animation completes
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Side image that appears horizontally next to the center image
//                 FadeTransition(
//                   opacity: _sideImageOpacityAnimation,
//                   child: SvgPicture.asset('assets/splash_icons/bnb-icon.svg',height: 100,width: 100,),
//                 ),
//                 const SizedBox(width: 20), // Spacing between side image and center image
//                 // Center image with scale and offset animation
//                 SlideTransition(
//                   position: _imageOffsetAnimation,
//                   child: ScaleTransition(
//                     scale: _scaleAnimation,
//                     child: SvgPicture.asset(
//                       'assets/splash_icons/b-icon.svg', // Replace with your center image asset
//                       width: 200,
//                       height: 200,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             // Text that moves upward
//             SlideTransition(
//               position: _textOffsetAnimation,
//               child: Text(
//                 'We manage the loan process from start to finish',
//                 style: TextStyle(fontSize: 16,color: Colors.lightBlue,fontWeight: FontWeight.w600),
//               ),
//             ),
//             const SizedBox(height: 20), // Small space between text and bottom image
//             // Reserve space for the bottom image to prevent layout shifts
//             SizedBox(
//               height: 200, // Adjust based on your bottom image's expected height
//               child: SlideTransition(
//                 position: _bottomImageOffsetAnimation,
//                 child: FadeTransition(
//                   opacity: _bottomImageOpacityAnimation,
//                   child: Image.asset(
//                     'assets/splash_icons/bottom-img.png', // Replace with your bottom image asset
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:fire/core/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _bottomImageController;

  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _iconOpacityAnimation;
  late Animation<Offset> _bottomImageSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Main controller for center image and text
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Controller for bottom image
    _bottomImageController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Scale down animation (from 1.0 to 0.6)
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.7,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    // Slide up animation
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.3), // Move up
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    // Icon fade in animation (appears after scale and slide)
    _iconOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    // Bottom image slide up animation
    _bottomImageSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: const Offset(0, 0.3),
    ).animate(
      CurvedAnimation(
        parent: _bottomImageController,
        curve: Curves.easeOut,
      ),
    );

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    await _mainController.forward();
    await _bottomImageController.forward();

    // Navigate to next screen after animations complete
    // await Future.delayed(const Duration(milliseconds: 500));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  void dispose() {
    _mainController.dispose();
    _bottomImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content (center image and text)
          Center(
            child: AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                return SlideTransition(
                  position: _slideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Center image with scale animation
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: SvgPicture.asset(
                          'assets/splash_icons/b-icon.svg',
                          height: 70,
                          width: 70,
                        ),
                      ),
                      4.horizontalSpace,
                      // Horizontal icon that appears after scaling
                      FadeTransition(
                        opacity: _iconOpacityAnimation,
                        child: SvgPicture.asset('assets/splash_icons/bnb-icon.svg',width: 32,height: 32,),
                      ),
                    ],
                  ),
                );
              },
            ),
          ).pXScreenDefault,

          // Text below center image
          Center(
            child: AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                return SlideTransition(
                  position: _slideAnimation,
                  child: const Text(
                    'We manage the loan process from start to finish',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                    textAlign: TextAlign.center,
                  ).pT(MediaQuery.of(context).size.height * 0.4),
                );
              },
            ),
          ).pXScreenDefault,

          // Bottom image that slides up
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _bottomImageSlideAnimation,
                child: Image.asset('assets/splash_icons/bottom-img.png',width:screenWidth,)
            ),
          )
        ],
      ),
    );
  }
}