import 'package:evently/utils/colors.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {

  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

   SettingsItem({
    super.key,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.inputLight
              : AppColors.inputDark,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset:  Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
             Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}
