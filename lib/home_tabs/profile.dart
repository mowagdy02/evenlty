import 'package:easy_localization/easy_localization.dart';
import 'package:evently/home_tabs/settingsItem.dart';
import 'package:evently/providers/language.dart';
import 'package:evently/providers/theme.dart';
import 'package:evently/providers/user.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
   Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            children: [
               SizedBox(height: 20),
              Container(
                width: 88,
                height: 88,
                decoration:  BoxDecoration(
                  color: Color(0xff0A2E8D),
                  shape: BoxShape.circle,
                ),
                child:  Center(
                  child: Text(
                    "ROUTE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
               SizedBox(height: 14),
               Text(
                 userProvider.currentUser!.name,
                 style: Theme.of(context).textTheme.headlineLarge,
              ),
               SizedBox(height: 6),
              Text(
                userProvider.currentUser!.email,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              SizedBox(height: 30),
              SettingsItem(
                title: "dark_mode".tr(),   // ✅ FIXED
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.dark ? isDarkMode = true : isDarkMode = false,
                  activeThumbColor:  Color(0xff0A2E8D),
                  onChanged: (val) {
                    setState(() => isDarkMode = val);
                    if (isDarkMode == true){
                      appThemeProvider.changeTheme(ThemeMode.dark);
                    }
                    else{
                      appThemeProvider.changeTheme(ThemeMode.light);

                    }

                  },
                ),
              ),

              SizedBox(height: 14),
              SettingsItem(
                title: "language".tr(),    // ✅ FIXED
                trailing:  Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Color(0xff0A2E8D),
                ),
                onTap: () {
                  languageBottomSheet();
                },
              ),

              SizedBox(height: 14),
              SettingsItem(
                title: "logout".tr(),      // ✅ FIXED
                trailing: Container(
                  padding:  EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginScreen,

                      (route) => false,);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }



  void languageBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
             SizedBox(height: 18),

            _langButton(
              title: "Arabic",
              onTap: () {
                context.setLocale( Locale('ar'));
                context
                    .read<AppLanguageProvider>()
                    .changeLanguage( Locale('ar'));
                Navigator.pop(context);
              },
            ),

             SizedBox(height: 12),

            _langButton(
              title: "English",
              onTap: () {
                context.setLocale( Locale('en'));
                context
                    .read<AppLanguageProvider>()
                    .changeLanguage( Locale('en'));
                Navigator.pop(context);
              },
            ),
             SizedBox(height: 14),
          ],
        ),
      ),
    );
  }

  Widget _langButton({required String title, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:  Color(0xff0A2E8D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style:  TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
