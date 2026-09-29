import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_new_app/core/utils/app_assets.dart';
import 'package:my_new_app/core/utils/app_colors.dart';
import 'package:my_new_app/features/auth/presentation/views/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
   void initState() {
     super.initState();
     Future.delayed(Duration(seconds: 3)).then((v){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
     });
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppSvgs.logo,
                width: 124.9.w,
                height: 100.h),
                SizedBox(width: 12.w),
        
                const Text('Stylish',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,),
        
                  )
        
            ],
            )
        
        ),
      )
      
     );
   }
}