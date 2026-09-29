import 'package:flutter/material.dart';
import 'package:my_new_app/core/cache/cache_helper.dart';
import 'package:my_new_app/core/cache/cache_keys.dart';
import 'package:my_new_app/core/helper/my_navigator.dart';
import 'package:my_new_app/core/utils/app_colors.dart';
import 'package:my_new_app/features/auth/presentation/views/login_screen.dart';
import 'package:my_new_app/features/profile/presentation/views/edit_profile.dart';
import 'package:my_new_app/features/profile/presentation/views/setting_screen.dart';



class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName =
        CacheHelper.getValue(key: 'userName')?.toString() ?? 'Mariam Walied';

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.black,
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
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Text(
              userName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 30),

            _buildProfileTile(
              icon: Icons.person_outline,
              title: 'My Profile',
              onTap: () {
                MyNavigator.goTo(
                  context,
                  toPage: const EditProfileView(),
                  type: NavigatorType.push,
                );
              },
            ),
            _buildProfileTile(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {},
            ),
            _buildProfileTile(
              icon: Icons.favorite_border,
              title: 'My Favorites',
              onTap: () {},
            ),
            _buildProfileTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                MyNavigator.goTo(
                  context,
                  toPage: const SettingsView(),
                  type: NavigatorType.push,
                );
              },
            ),

            const Divider(height: 30),

            _buildProfileTile(
              icon: Icons.logout,
              title: 'Log Out',
              color: AppColors.black,
              showArrow: false,
              onTap: () async {
                await CacheHelper.removeValue(key: CacheKeys.accessToken);
                await CacheHelper.removeValue(key: CacheKeys.refreshToken);

                if (context.mounted) {
                  MyNavigator.goTo(
                    context,
                    toPage: const LoginScreen(),
                    type: NavigatorType.pushAndRemoveUntil,
                  );
                }
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
    Color color = AppColors.black,
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
          ? const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey)
          : null,
      onTap: onTap,
    );
  }
}