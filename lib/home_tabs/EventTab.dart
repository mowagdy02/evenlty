import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/Event.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/user.dart';
import 'package:evently/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventTab extends StatelessWidget {
  final Event event;
  EventTab({super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    var fireBaseProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Container(
      padding: EdgeInsets.all(10),
      width: width,
      height: height * 0.25,
      decoration: BoxDecoration(
        border: BoxBorder.all(width: 2, color: Theme.of(context).brightness == Brightness.light ?
        AppColors.disableLight:AppColors.strokeDark,),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.eventImage),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light ?
              AppColors.strokeLight :
                  AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(10),
              border: BoxBorder.all(color:Theme.of(context).brightness == Brightness.light ?
              AppColors.disableLight:AppColors.strokeDark, width: 1),
            ),
            child: Text(
              DateFormat('d MMM').format(event.eventDate),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light ?
              AppColors.strokeLight :
              AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(10),
              border: BoxBorder.all(color:Theme.of(context).brightness == Brightness.light ?
    AppColors.disableLight:AppColors.strokeDark, width: 1),
            ),
            child: Row(
              children: [
                Text(
                  event.eventTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacer(),
                IconButton(onPressed: () {
                  fireBaseProvider.updateIsFavourite(event,userProvider.currentUser!.id);

                }, icon: event.isFavourite ? Icon(Icons.favorite,color:
                Theme.of(context).brightness == Brightness.light ?
                AppColors.primaryLight:AppColors.primaryDark)
                :Icon(Icons.favorite_border_outlined,color:Theme.of(context).brightness == Brightness.light ?
                AppColors.primaryLight:AppColors.primaryDark)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
