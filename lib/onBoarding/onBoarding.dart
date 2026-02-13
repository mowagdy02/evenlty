import 'package:evently/utils/colors.dart';
import 'package:evently/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: AppColors.primaryLight,
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Discover events easily",
        ),
        PageViewModel(
          title: "Explore",
          body: "Find events near you",
        ),
        PageViewModel(
          title: "Book",
          body: "Reserve your seat instantly",
        ),
        PageViewModel(
          title: "Enjoy",
          body: "Have a great experience",
        ),
      ],

      onDone: () {
        // TODO: Navigate to home/login screen
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      },

      done: const Text("Done"),
      next: const Text("Next"),

    );
  }
}
