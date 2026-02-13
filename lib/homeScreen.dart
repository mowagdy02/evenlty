import 'package:easy_localization/easy_localization.dart';
import 'package:evently/home_tabs/favourite_tab.dart';
import 'package:evently/home_tabs/home_tab.dart';
import 'package:evently/home_tabs/profile.dart';
import 'package:evently/providers/language.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; // profile is selected in your screenshot

  final pages =  [
    HomeTab(),
    FavouriteTab(),
    Profile(),
  ];
  AppLanguageProvider LanProvider  = AppLanguageProvider();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    LanProvider.appLocale;
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: pages[selectedIndex],
      floatingActionButton: Padding(
        padding:  EdgeInsets.all(10),
        child: FloatingActionButton(

          shape: CircleBorder(),
          backgroundColor: Theme.of(context).brightness == Brightness.light?  AppColors.primaryLight: AppColors.primaryDark,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addEvent);
          },
          child:  Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      /// Custom Bottom Navigation Bar
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.fromLTRB(16, 0, 16, 18),
        child: Container(
          height: 78,
          decoration: BoxDecoration(
             color:  Theme.of(context).brightness == Brightness.light
                  ? AppColors.inputLight
                  : AppColors.inputDark,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 18,
                offset:  Offset(0, 6),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(
                index: 0,
                icon: Icons.home_outlined,
                label: "home".tr(),
              ),
              _navItem(
                index: 1,
                icon: Icons.favorite_border,
                label: "favourite".tr(),
              ),
              _navItem(
                index: 2,
                icon: Icons.person,
                label: "profile".tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() => selectedIndex = index);
      },
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: isSelected ?  Color(0xff0A2E8D) : Colors.grey.shade400,
            ),
             SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color:
                isSelected ?  Color(0xff0A2E8D) : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
