import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/Event.dart';
import 'package:evently/models/user.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uid) {
    return getUserCollection().doc(uid)
        .collection("events")
        .withConverter<Event>(
      fromFirestore: (snapshot, _) =>
          Event.fromFireStore(snapshot.data()!),
      toFirestore: (event, _) => event.toFireStore(),
    );
  }
  static CollectionReference<User> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<User>(
      fromFirestore: (snapshot, _) =>
          User.fromFireStore(snapshot.data()!),
      toFirestore: (User, _) => User.toFireStore(),
    );
  }


  static Future<void> addUserToFirestore(User user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<User?> readUserFromFireStore(String uid)async{
    var querySnapShoot = await getUserCollection().doc(uid).get();
    return querySnapShoot.data();
  }


  static Future<Event?> readEventFromFireStore(
      String uid, String eventId) async {

    var docSnapshot = await getEventCollection(uid)
        .doc(eventId)
        .get();

    return docSnapshot.data();
  }


  static Future<void> updateEventInFirestore(
      Event event, String uid) async {

    await getEventCollection(uid)
        .doc(event.id)
        .set(event);
  }


  static Future<String> addEventToFirestore(Event event,String uid) async {
    var docRef = getEventCollection(uid).doc(); // create empty doc
    event.id = docRef.id;                   // assign ID to model
    await docRef.set(event);                //  ONLY ONE WRITE
    return docRef.id;
  }
}