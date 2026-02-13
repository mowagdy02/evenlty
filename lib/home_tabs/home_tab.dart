import 'package:easy_localization/easy_localization.dart';
import 'package:evently/home_tabs/EventTab.dart';
import 'package:evently/home_tabs/tabWidget.dart';
import 'package:evently/models/Event.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/language.dart';
import 'package:evently/providers/theme.dart';
import 'package:evently/providers/user.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
   HomeTab({super.key});


  @override
  State<HomeTab> createState() => _HomeTabState();
}
class _HomeTabState extends State<HomeTab> {


  final List<Map<String, dynamic>> tabs = [
    {
      "icon": Icons.dashboard_rounded, // All
      "title": "All",
    },
    {
      "icon": Icons.directions_bike, // Sport
      "title": "Sport",
    },
    {
      "icon": Icons.meeting_room, // Birthday
      "title": "Meet",
    },
    {
      "icon": Icons.cake_outlined, // Birthday
      "title": "Birthday",
    },
  ];
late EventListProvider eventListProvider ;
late UserProvider userProvider;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.getAllEventsFromFireStore(userProvider.currentUser!.id);
    },);
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    final langProvider = context.watch<AppLanguageProvider>();
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                appThemeProvider.changeTheme(
                  appThemeProvider.appTheme == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light,
                );
              },
              icon: Theme.of(context).brightness == Brightness.light
                  ? const Icon(Icons.wb_sunny_outlined)
                  : const Icon(Icons.sunny),
            ),
            IconButton(
              onPressed: () {
                final newLocale =
                langProvider.appLocale.languageCode == 'en'
                    ? const Locale('ar')
                    : const Locale('en');

                context.setLocale(newLocale);
                langProvider.changeLanguage(newLocale);
              },
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.primaryLight
                      : AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  langProvider.appLocale.languageCode.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.inputLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("welcome_back".tr(),
                  style: Theme.of(context).textTheme.bodyMedium),
              Text(userProvider.currentUser!.name, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: height * 0.05,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (_, __) => SizedBox(width: width * 0.02),
                itemBuilder: (context, index) {
                  return TabWidget(
                    icon: tabs[index]["icon"],
                    data: tabs[index]["title"],
                    isSelected: eventListProvider.selectedIndex == index,
                    onTap: () {
                      eventListProvider.changeSelectedIndex(
                        index,
                        tabs.map((tab) => tab['title'] as String).toList(),
                        userProvider.currentUser!.id
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(child: eventListProvider.eventList.isEmpty ? Text("No events Found",
            style: Theme.of(context).textTheme.titleMedium,
            ) : ListView.separated(itemBuilder:
                (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.eventDetails,
                        arguments: eventListProvider.filterList[index],
                      );
                    },
                    child: EventTab(
                      event: eventListProvider.filterList[index],
                    ),
                  );
                }
                , separatorBuilder:(context, index) {
                  return SizedBox(height: 10,);
                }, itemCount: eventListProvider.filterList.length


            ))
          ],
        ),
      ),
    );
  }

}

