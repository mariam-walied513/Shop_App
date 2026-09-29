import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_new_app/core/utils/app_assets.dart';
import 'package:my_new_app/core/utils/app_colors.dart';
import 'package:my_new_app/features/home/presentation/views/home_screen.dart';
import 'package:my_new_app/features/auth/data/repo/auth_repo.dart';

// Import Cubit & States
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';

// Import Helpers & Navigation
import 'package:my_new_app/core/helper/my_navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordSecure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthRepo()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Welcome Mariam!'),
                backgroundColor: Colors.green,
              ),
            );

            MyNavigator.goTo(
              context,
              toPage: const HomeView(),
              type: NavigatorType.pushAndRemoveUntil,
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<LoginCubit>(context);

          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset(AppSvgs.arrowLeft),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // Title: Welcome Back!
                    Text(
                      'Welcome\nBack!',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 36.h),

                    // Email Field
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 12.sp,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            AppSvgs.email,
                            width: 24,
                            height: 24,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF3F3F3),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: isPasswordSecure,
                      enableSuggestions: false,
                      autocorrect: false,
                      autofillHints: const [AutofillHints.password],
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            AppSvgs.lockClosed,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isPasswordSecure = !isPasswordSecure;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              isPasswordSecure ? AppSvgs.eye : AppSvgs.eye, 
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF3F3F3),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 36.h),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 0,
                        ),
                        onPressed: state is LoginLoadingState
                            ? null
                            : () {
                                cubit.login(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              },
                        child: state is LoginLoadingState
                            ? SizedBox(
                                height: 24.h,
                                width: 24.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}