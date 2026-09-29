import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_new_app/core/utils/app_assets.dart';
import 'package:my_new_app/core/utils/app_colors.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Profile Picture
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFFFFE5EC),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: const Color(0xFF1E88E5),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Full Name Input
            TextField(
              decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),     
                  child: SvgPicture.asset(
                    AppSvgs.profile,
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                hintText: 'Full Name',
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Phone Input
            TextField(
              decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0), 
                  child: SvgPicture.asset(
                    AppSvgs.phone,
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                hintText: 'Phone',
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}