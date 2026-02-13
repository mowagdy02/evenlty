import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Add_Event.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/signUp.dart';
import 'package:evently/home_tabs/event_details.dart';
import 'package:evently/home_tabs/home_tab.dart';
import 'package:evently/home_tabs/profile.dart';
import 'package:evently/main.dart';
import 'package:evently/onBoarding/onBoarding.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/language.dart';
import 'package:evently/providers/theme.dart';
import 'package:evently/providers/user.dart';
import 'package:evently/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'package:evently/homeScreen.dart';
import 'package:evently/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => EventListProvider(),),
          ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
          ChangeNotifierProvider(create: (context) => AppThemeProvider(),),
          ChangeNotifierProvider(create: (context) => UserProvider(),)

        ]
          ,child: MyApp()
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      initialRoute: AppRoutes.loginScreen,
      routes: {
        AppRoutes.homescreen: (context) => HomeScreen(),
        AppRoutes.loginScreen: (context) => LoginScreen(),
        AppRoutes.profile: (context) => Profile(),
        AppRoutes.onboarding: (context) => Onboarding(),
        AppRoutes.signup: (context) => Signup(),
        AppRoutes.homeTab:(context) => HomeTab(),
        AppRoutes.addEvent:(context) => AddEvent(),
        AppRoutes.eventDetails:(context) => EventDetails(),

      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: langProvider.appLocale,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: appThemeProvider.appTheme,
    );
  }
}
