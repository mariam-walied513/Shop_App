import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/checkout_screen.dart';
import 'cubits/orders_cubit.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersCubit(),
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
        home: const CheckoutScreen(),
      ),
    );
  }
}