import 'package:flutter/material.dart';
import 'package:cashier/shared/components/apps/command_toolbar_button.dart';
import 'package:cashier/shared/components/apps/custom_vertical_divider.dart';
import 'package:hugeicons/hugeicons.dart';

class SalesHistoryToolbar extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onToggleAllUsers;
  final VoidCallback? onCustomer;
  final VoidCallback? onPrint;
  final VoidCallback? onPdf;
  final VoidCallback? onReceipt;
  final VoidCallback? onSendEmail;
  final VoidCallback? onRefund;
  final VoidCallback? onDelete;

  const SalesHistoryToolbar({
    super.key,
    this.onRefresh,
    this.onToggleAllUsers,
    this.onCustomer,
    this.onPrint,
    this.onPdf,
    this.onReceipt,
    this.onSendEmail,
    this.onRefund,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CommandToolbarButton(
                    icon: HugeIcons.strokeRoundedRefresh,
                    label: 'Segarkan',
                    onTap: onRefresh ?? () {},
                    isDark: isDark,
                  ),
                  const CustomVerticalDivider(),
                  CommandToolbarButton(
                    icon: HugeIcons.strokeRoundedToggleOn,
                    label: 'Semua pengguna',
                    onTap: onToggleAllUsers ?? () {},
                    isDark: isDark,
                    width: 90,
                  ),
                  CommandToolbarButton(
                    icon: HugeIcons.strokeRoundedUser,
                    label: 'Pelanggan',
                    onTap: onCustomer ?? () {},
                    isDark: isDark,
                  ),
                  const CustomVerticalDivider(),
                  CommandToolbarButton(
                    icon: HugeIcons.strokeRoundedPrinter,
                    label: 'Mencetak',
                    onTap: onPrint ?? () {},
                    isDark: isDark,
                  ),
                  CommandToolbarButton(
                    icon: HugeIcons.strokeRoundedPdf02,
                    label: 'PDF',
                    onTap: onPdf ?? () {},
                    isDark: isDark,
                  ),
                  CommandToolbarButton(
                    icon: HugeIcons.strokeRoundedInvoice03,
                    label: 'Resi',
                    onTap: onReceipt ?? () {},
                    isDark: isDark,
                  ),
                  const CustomVerticalDivider(),
                  CommandToolbarButton(
                    icon: HugeIcons.strokeRoundedMail01,
                    label: 'Kirim email',
                    onTap: onSendEmail ?? () {},
                    isDark: isDark,
                  ),
                  CommandToolbarButton(
                    icon: HugeIcons.strokeRoundedReturnRequest,
                    label: 'Refund',
                    onTap: onRefund ?? () {},
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedDelete02,
            label: 'Menghapus',
            onTap: onDelete ?? () {},
            isDark: isDark,
            hoverColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
