import 'package:fire/core/extension/widget_extension.dart';
import 'package:fire/feature/auth/presentation/pages/login_page.dart';
import 'package:fire/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../auth/presentation/pages/login_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            height: 50.sp,
            width: 50.sp,
            duration: Duration(milliseconds: 300), decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
            child: SvgPicture.asset('assets/images/dashboard_logo.svg'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('F I R E',style: TextStyle(
                color: Colors.orange,
                fontSize: 20
              ),),
            ],
          ).pB(50.sp),
          GestureDetector(
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginPage())),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Theme.of(context).primaryColor
              ),
              child: Center(
                child: Text('L O G I N',style: TextStyle(color: Colors.white),),
              ).padAll(12.sp),
            ).px(12.sp),
          ).pB(16.sp),
          GestureDetector(
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginScreen())),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Theme.of(context).primaryColor
              ),
              child: Center(
                child: Text('S I G N  U P',style: TextStyle(color: Colors.white),),
              ).padAll(12.sp),
            ).px(12.sp),
          ),
          
        ],
      ).pXScreenDefault,
    );
  }
}
