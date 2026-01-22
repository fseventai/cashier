import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/shared/widgets/management/dashboard/dashboard_chart_card.dart';
import 'package:cashier/shared/widgets/management/dashboard/dashboard_stat_card.dart';
import 'package:hugeicons/hugeicons.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section: Chart + Total Sales
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Monthly Sales Chart
              const Expanded(flex: 3, child: DashboardChartCard()),
              const SizedBox(width: 24),
              // Total Sales Summary Card
              Expanded(
                flex: 1,
                child: DashboardStatCard(
                  height: 320,
                  title: 'Total Sales',
                  crossAxisAlignment: CrossAxisAlignment.start,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '0',
                          style: AppTextStyles.h1.copyWith(
                            fontSize: 60,
                            letterSpacing: -2,
                            color: isDark ? Colors.white : AppColors.slate800,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top performing month:',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isDark
                                  ? AppColors.slate400
                                  : AppColors.slate500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '---',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.slate200
                                  : AppColors.slate700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '0.00',
                            style: AppTextStyles.h2.copyWith(
                              fontSize: 30,
                              color: isDark ? Colors.white : AppColors.slate800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Periodic Reports Header
          Row(
            children: [
              Text(
                'Periodic Reports',
                style: AppTextStyles.h3.copyWith(
                  color: isDark ? AppColors.slate200 : AppColors.slate700,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.slate800 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? AppColors.slate600
                        : AppColors.surfaceBorder,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      '22/12/2025 - 22/12/2025',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark ? AppColors.slate300 : AppColors.slate500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedCalendar03,
                      color: AppColors.emerald600,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Middle Grid (3 cols)
          Row(
            children: [
              Expanded(
                child: DashboardStatCard(
                  height: 250,
                  title: 'Top Products',
                  child: Center(
                    child: Text(
                      'No data to display',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: DashboardStatCard(
                  height: 250,
                  title: 'Hourly Sales',
                  child: Center(
                    child: Text(
                      'No data to display',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: DashboardStatCard(
                  height: 250,
                  title: 'Total Sales (Amount)',
                  child: Center(
                    child: Text(
                      '0',
                      style: AppTextStyles.h1.copyWith(
                        fontSize: 80,
                        height: 1,
                        letterSpacing: -4,
                        color: isDark ? Colors.white : AppColors.slate800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Bottom Grid (2 cols)
          Row(
            children: [
              Expanded(
                child: DashboardStatCard(
                  height: 250,
                  title: 'Top Product Groups',
                  subtitle: 'Top selling product groups in selected period',
                  child: Center(
                    child: Text(
                      'No data to display',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: DashboardStatCard(
                  height: 250,
                  title: 'Top Customers',
                  subtitle: 'Lead customers in selected period (top 5)',
                  child: Stack(
                    children: [
                      // Decoration lines replicating the design
                      Positioned(
                        left: 16,
                        bottom: 16,
                        child: Container(
                          width: 1,
                          height: 60,
                          color: isDark
                              ? AppColors.slate700
                              : AppColors.slate100,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 16,
                        right: 16,
                        child: Container(
                          height: 1,
                          color: isDark
                              ? AppColors.slate700
                              : AppColors.slate100,
                        ),
                      ),
                      Center(
                        child: Text(
                          'No data to display',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
