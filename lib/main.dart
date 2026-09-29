import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_new_app/core/cache/cache_helper.dart';
import 'package:my_new_app/features/auth/presentation/views/splash_screen.dart';
import 'package:my_new_app/features/auth/presentation/views/onboarding_screen.dart';
import 'package:my_new_app/features/auth/presentation/views/start_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return ScreenUtilInit(
      designSize: Size(375,812),
      builder:(_,child) => MaterialApp(
        debugShowCheckedModeBanner: false,
       theme: ThemeData(
          fontFamily: 'Lexend_Deca'
        ),
        home:SplashScreen ()
      )
    );
  }
}