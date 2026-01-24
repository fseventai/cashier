import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: 1000,
        height: 600,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Side: Login Form
            Expanded(
              flex: 12,
              child: Padding(
                padding: const EdgeInsets.all(64.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login Kasir',
                      style: AppTextStyles.display.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.charcoal900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Selamat datang kembali! Silakan masuk ke akun Anda.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textMuted,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Username Input
                    _buildLabel('Username / ID Kasir'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _usernameController,
                      hint: 'Masukkan ID Kasir Anda',
                      prefixIcon: HugeIcons.strokeRoundedUser,
                    ),
                    const SizedBox(height: 24),

                    // Password Input
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabel('Password'),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Lupa Password?',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.emerald600,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _passwordController,
                      hint: 'Masukkan Kata Sandi',
                      prefixIcon: HugeIcons.strokeRoundedLockPassword,
                      obscureText: _obscurePassword,
                      suffix: IconButton(
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: HugeIcon(
                          icon: _obscurePassword
                              ? HugeIcons.strokeRoundedView
                              : HugeIcons.strokeRoundedViewOffSlash,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.emerald500,
                          elevation: 8,
                          shadowColor: AppColors.emerald500.withValues(
                            alpha: 0.3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'MASUK KE POS',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Footer Hint
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const HugeIcon(
                            icon: HugeIcons.strokeRoundedLockPassword,
                            color: AppColors.textMuted,
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Sistem Keamanan Terenkripsi',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textMuted,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Right Side: Illustration/Image
            Expanded(
              flex: 15,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Decorative Background
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.emerald50,
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuC7WHRc-_2oyJCdX6Bf4ORjFEXEK9iuhRAy1IuIlHcrKvV9Is39zo_8xtKTz3VjQRiTfPcXD88YgpkTt46ql9Z4iMd2yTGl2NmalhAk_fLQddtyjyI5YhVJ2OhRkmp79WA5BT4cz-qLz4PZTHlQ5ngqaRltI41R39LYh3XXyI_-bgU0Yry2oJUHzIbZmApaoEOIZkbk-nkbzw4NTi3JQDzCAOTlme2cDQ_uIFNQVqPImbPgPUrGgLUKguoy5Pn77CwhmnloPBRFRT8",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Overlay Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.emerald500.withValues(alpha: 0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Floating Info Card
                  Center(
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.emerald100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const HugeIcon(
                              icon: HugeIcons.strokeRoundedMoney03,
                              color: AppColors.emerald600,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Efisiensi Transaksi',
                            style: AppTextStyles.h3.copyWith(
                              color: AppColors.charcoal900,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Kelola stok dan penjualan koperasi dengan lebih cepat dan akurat di setiap shift Anda.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textMain,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.bodyMedium.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.charcoal900,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required List<List<dynamic>> prefixIcon,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: AppTextStyles.bodyLarge,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.slate400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HugeIcon(
              icon: prefixIcon,
              color: AppColors.slate400,
              size: 20,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
