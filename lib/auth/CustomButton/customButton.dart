import 'package:evently/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  double? width;
  double? height;
  void Function() onTap;
   CustomButton({super.key
     , required this.title,
     this.width,
     this.height,
     required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width * 0.4,
        height: height ?? MediaQuery.sizeOf(context).height * 0.07,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? AppColors.primaryLight : AppColors.primaryDark,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Center(child: Text(title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.strokeLight
          ),
        )),
      ),
    );
  }
}
