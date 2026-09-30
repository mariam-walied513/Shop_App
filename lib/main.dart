import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/profile/presentation/views/profile_view.dart';
import 'cubits/orders_cubit.dart';
import 'cubits/auth_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'core/cache/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Init Cache
  await CacheHelper.init();

  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrdersCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => AuthCubit()..login()),   // ✅ Login
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Arial',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF3655),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.white,
          ),
        ),
        home: const ProfileView(),
      ),
    );
  }
}