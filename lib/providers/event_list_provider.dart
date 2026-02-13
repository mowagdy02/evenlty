import 'package:evently/models/Event.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:flutter/material.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filterList = [];
  int selectedIndex = 0;

  void getAllEventsFromFireStore(String uid) async {
    var querySnapShoot = await FirebaseUtils.getEventCollection(uid).get();
    eventList = querySnapShoot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList = eventList;
    filterList.sort((event1,event2){
      return event1.eventDate.compareTo(event2.eventDate);
    });
    notifyListeners();
  }
  void getFilterEventsFromFireStore(List<String> eventsNameList,String uid) async {
    var querySnapShoot = await FirebaseUtils.getEventCollection(uid).get();
    filterList = querySnapShoot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList.sort((event1,event2){
      return event1.eventDate.compareTo(event2.eventDate);
    });
    filterList = filterList.where((event) {
      return event.eventName == eventsNameList[selectedIndex];
    },).toList();

    notifyListeners();
  }
void changeSelectedIndex(int newSelectedIndex,List<String> eventsNameList,String uid){
 selectedIndex = newSelectedIndex;
 selectedIndex == 0 ? getAllEventsFromFireStore(uid):getFilterEventsFromFireStore(eventsNameList,uid);
}
  void updateIsFavourite(Event event,String uid) async {
    final index =
    eventList.indexWhere((event) => event.id == event.id);

    if (index == -1) return;

    // 1️⃣ update local source of truth
    eventList[index].isFavourite =
    !eventList[index].isFavourite;

    // 2️⃣ keep filterList in sync
    filterList = [...eventList];
    filterList.sort((a, b) => a.eventDate.compareTo(b.eventDate));

    notifyListeners();

    // 3️⃣ update Firestore
    await FirebaseUtils.getEventCollection(uid)
        .doc(event.id)
        .update({"isFavourite": eventList[index].isFavourite});
  }


}
