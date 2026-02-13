import 'package:evently/utils/colors.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final IconData icon;
  final String data;
  final bool isSelected;
  final VoidCallback onTap;

  const TabWidget({
    super.key,
    required this.icon,
    required this.data,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: BoxBorder.all(
            width: 2,
            color: Theme.of(context).brightness == Brightness.light? AppColors.disableLight : AppColors.primaryDark
          ),
          color: isSelected ? Theme.of(context).brightness == Brightness.light? AppColors.primaryLight : AppColors.primaryDark : Theme.of(context).brightness == Brightness.light? AppColors.inputLight : AppColors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
           Theme.of(context).brightness == Brightness.light? Icon(
             icon,
             color: isSelected ? AppColors.inputLight : AppColors.primaryLight,
             size: 30,
           ) : Icon(
             icon,
             color: isSelected ? AppColors.inputLight : AppColors.primaryDark,
             size: 30,
           ),
            const SizedBox(width: 5),
            Text(
              data,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.light? isSelected ?AppColors.inputLight :  AppColors.textMainLight: AppColors.inputLight,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
