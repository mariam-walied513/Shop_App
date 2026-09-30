import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../screens/my_orders_screen.dart';
import '../../../../screens/trending_products_screen.dart';
import '../../../../screens/product_details_screen.dart';
import '../../../../constants/colors.dart';
import '../../../../cubits/auth_cubit.dart';
import '../../../../cubits/auth_state.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../data/sample_products.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ اقرأ الاسم من الـ Cache (لو مش موجود → من الـ API)
    final cachedName =
        CacheHelper.getValue(key: 'userName')?.toString() ?? 'Guest';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFFFFE5EC),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: primaryPink,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ✅ الاسم من الـ Cache أو الـ AuthCubit
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                String name = cachedName;
                if (state is AuthLoaded) {
                  name = state.name;
                }

                return Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryPink,
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            _buildProfileTile(
              icon: Icons.person_outline,
              title: 'My Profile',
              onTap: () {},
            ),

            _buildProfileTile(
              icon: Icons.shopping_cart_outlined,
              title: 'Products',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsScreen(
                      product: womenProduct,
                    ),
                  ),
                );
              },
            ),

            _buildProfileTile(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyOrdersScreen(),
                  ),
                );
              },
            ),

            _buildProfileTile(
              icon: Icons.favorite_border,
              title: 'My Favorites',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TrendingProductsScreen(),
                  ),
                );
              },
            ),

            _buildProfileTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),

            const Divider(height: 30),

            _buildProfileTile(
              icon: Icons.logout,
              title: 'Log Out',
              showArrow: false,
              onTap: () {
                context.read<AuthCubit>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
    bool showArrow = true,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: showArrow
          ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
          : null,
      onTap: onTap,
    );
  }
}