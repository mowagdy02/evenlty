import 'package:easy_localization/easy_localization.dart';
import 'package:evently/auth/CustomButton/customButton.dart';
import 'package:evently/auth/CustomTextField/customTextField.dart';
import 'package:evently/home_tabs/tabWidget.dart';
import 'package:evently/models/Event.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/theme.dart';
import 'package:evently/providers/user.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final List<Map<String, dynamic>> tabs = [
    {
      "icon": Icons.directions_bike,
      "title": "Sport",
    },
    {
      "icon": Icons.meeting_room,
      "title": "Meet",
    },
    {
      "icon": Icons.cake_outlined,
      "title": "Birthday",
    },
  ];

  List<String> imagesLight = [
    "assets/images/Sport-1.png",
    "assets/images/Meeting-1.png",
    "assets/images/Birthday-1.png"
  ];

  List<String> imagesDark = [
    "assets/images/Sport.png",
    "assets/images/Meeting.png",
    "assets/images/Birthday.png"
  ];

  String selectedEventName = "";
  String selectedEventImage = "";
  String selectedEventTitle = "";
  String selectedEventDescription = "";
  DateTime? selectedDate;
  String formatDate ='';
  TimeOfDay? selectedTime;
  String formatTime ='';

  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider ;
  late UserProvider userProvider ;

  /// ✅ NEW VARIABLES FOR EDIT (Nothing removed)
  Event? eventToEdit;
  bool isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Event && !isEdit) {
      eventToEdit = args;
      isEdit = true;

      selectedEventName = eventToEdit!.eventName;
      selectedEventImage = eventToEdit!.eventImage;
      selectedEventTitle = eventToEdit!.eventTitle;
      selectedEventDescription = eventToEdit!.eventDescription;
      selectedDate = eventToEdit!.eventDate;
      formatDate = DateFormat('MMM d, yyyy').format(selectedDate!);
      formatTime = eventToEdit!.eventTime;

      selectedIndex = tabs.indexWhere(
              (tab) => tab["title"] == selectedEventName);

      if(selectedIndex == -1){
        selectedIndex = 0;
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Event" : "add_event".tr(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).brightness == Brightness.light ?
              AppColors.textSecLight : AppColors.textMainDark
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.inputLight
                  : AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.textSecDark
                    : AppColors.primaryDark,
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.primaryLight
                  : AppColors.primaryDark,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                /// IMAGE (unchanged)
                Container(
                  width: width,
                  height: height * 0.25,
                  decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color:  Theme.of(context).brightness == Brightness.light ?
                        AppColors.textSecDark : AppColors.primaryLight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image:  Theme.of(context).brightness == Brightness.light ?
                          AssetImage(imagesLight[selectedIndex]) :
                          AssetImage(imagesDark[selectedIndex]),
                          fit: BoxFit.fill)
                  ),
                ),

                /// TABS (unchanged)
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
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedEventName =  tabs[index]["title"];

                            if(Theme.of(context).brightness == Brightness.light){
                              selectedEventImage = imagesLight[selectedIndex];
                            }
                            else{
                              selectedEventImage = imagesDark[selectedIndex];
                            }
                          });
                        },
                      );
                    },
                  ),
                ),

                /// TITLE FIELD (unchanged)
                CustomTextField(
                  borderColor: Theme.of(context).brightness == Brightness.light ?
                  AppColors.textSecDark : AppColors.primaryLight,
                  hintText: "event_title".tr(),
                  hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light ?
                      AppColors.textSecLight : AppColors.textMainDark
                  ),
                  initialValue: selectedEventTitle,
                  onChanged: (value) {
                    selectedEventTitle = value;
                  },
                  validator: (value) {
                    if(value == null || value.trim().isEmpty){
                      return "Enter valid value";
                    }
                    return null;
                  },
                ),

                /// DESCRIPTION FIELD (unchanged)
                CustomTextField(
                  borderColor: Theme.of(context).brightness == Brightness.light ?
                  AppColors.textSecDark : AppColors.primaryLight,
                  hintText: "event_description".tr(),
                  hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).brightness == Brightness.light ?
                    AppColors.textSecLight : AppColors.textMainDark,
                  ),
                  maxLines: 10,
                  initialValue: selectedEventDescription,
                  onChanged: (value) {
                    selectedEventDescription = value;
                  },
                  validator: (value) {
                    if(value == null || value.trim().isEmpty){
                      return "Enter valid value";
                    }
                    return null;
                  },
                ),

                /// DATE (unchanged)
                Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    Text("event_date".tr()),
                    Spacer(),
                    TextButton(
                      onPressed: chooseDate,
                      child: Text(
                        selectedDate == null ? "choose_date".tr() : formatDate,
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),

                /// TIME (unchanged)
                Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    Text("event_time".tr()),
                    Spacer(),
                    TextButton(
                      onPressed: chooseTime,
                      child: Text(
                        selectedTime == null ? "choose_time".tr() : formatTime,
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),

                /// BUTTON (ONLY LOGIC CHANGED)
                CustomButton(
                  title: isEdit ? "Update Event" : "add_event".tr(),
                  onTap: () {
                    isEdit ? updateEvent() : addEvent();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (chooseDate != null) {
      selectedDate = chooseDate;
      formatDate = DateFormat('MMM d, yyyy').format(chooseDate);
      setState(() {});
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if (chooseTime != null) {
      selectedTime = chooseTime;
      formatTime = selectedTime!.format(context);
      setState(() {});
    }
  }

  Future<void> addEvent() async {
    if (formKey.currentState?.validate() == true) {

      Event event = Event(
        eventName: selectedEventName,
        eventImage: selectedEventImage,
        eventTitle: selectedEventTitle,
        eventDescription: selectedEventDescription,
        eventTime: formatTime,
        eventDate: selectedDate!,
      );

      await FirebaseUtils.addEventToFirestore(
          event,userProvider.currentUser!.id);

      eventListProvider.getAllEventsFromFireStore(
          userProvider.currentUser!.id);

      Navigator.pop(context);
    }
  }

  /// ✅ UPDATE METHOD ADDED
  Future<void> updateEvent() async {
    if (formKey.currentState?.validate() == true) {

      Event updatedEvent = Event(
        id: eventToEdit!.id,
        eventName: selectedEventName,
        eventImage: selectedEventImage,
        eventTitle: selectedEventTitle,
        eventDescription: selectedEventDescription,
        eventTime: formatTime,
        eventDate: selectedDate!,
        isFavourite: eventToEdit!.isFavourite,
      );

      await FirebaseUtils.updateEventInFirestore(
          updatedEvent,
          userProvider.currentUser!.id);

      eventListProvider.getAllEventsFromFireStore(
          userProvider.currentUser!.id);

      Navigator.pushNamed(context, AppRoutes.homescreen);

    }
  }
}
