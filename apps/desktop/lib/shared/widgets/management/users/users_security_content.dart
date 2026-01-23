import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/shared/widgets/management/users/user_table.dart';

class UsersSecurityContent extends StatefulWidget {
  const UsersSecurityContent({super.key});

  @override
  State<UsersSecurityContent> createState() => _UsersSecurityContentState();
}

class _UsersSecurityContentState extends State<UsersSecurityContent> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> users = [
      {
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'john.doe@example.com',
        'accessLevel': 'Admin',
        'isActive': true,
      },
      {
        'firstName': 'Jane',
        'lastName': 'Smith',
        'email': 'jane.smith@example.com',
        'accessLevel': 'User',
        'isActive': false,
      },
    ];

    return Column(
      children: [
        // Content
        Expanded(
          child: Container(
            color: isDark
                ? AppColors.surfaceAlt
                : AppColors.surface, // Background slightly off-white usually
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Empty state area (No additional users found)
                users.isEmpty
                    ? Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.surfaceBorder,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Opacity(
                            opacity: 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedGridOff,
                                  size: 48,
                                  color: isDark
                                      ? AppColors.slate500
                                      : AppColors.slate400,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No additional users found',
                                  style: AppTextStyles.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : UserTable(users: users),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
