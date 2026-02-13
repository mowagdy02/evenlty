import 'package:easy_localization/easy_localization.dart';
import 'package:evently/auth/CustomTextField/customTextField.dart';
import 'package:evently/home_tabs/EventTab.dart';
import 'package:evently/models/Event.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteTab extends StatefulWidget {
   FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  late var eventListProvider;

  @override
  void initState() {
    // List<Event> event = eventListProvider.filterList
    //     .where((e) => e.isFavourite)
    //     .toList();
    super.initState();
  }

   Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    List<Event> event = eventListProvider.filterList
        .where((e) => e.isFavourite)
        .toList();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: height * 0.07,bottom: 10),
        child: Column(
          spacing: height * 0.01,
          children: [
            CustomTextField(
              hintText: "search_for_event".tr(),
              suffixIcon:Icon(Icons.search,size: width * 0.09,color: Theme.of(context).brightness == Brightness.light ?AppColors.primaryLight:AppColors.primaryDark,),
              borderColor:Theme.of(context).brightness == Brightness.dark ? AppColors.strokeDark : AppColors.strokeLight, )
            ,Expanded(child: ListView.separated(itemBuilder:
                (context, index) {
              return EventTab(
               event: event[index],);
            }
                , separatorBuilder:(context, index) {
                  return SizedBox(height:10 ,);
                }, itemCount: event.length


            ))
          ],
        ),
      ),

    );
  }
}
