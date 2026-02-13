class Event {
  static const String collectionname = "Events";
  String id;
  String eventName;
  String eventImage;
  String eventTitle;
  String eventDescription;
  String eventTime;
  DateTime eventDate;
  bool isFavourite;
  Event({
    this.id = '',
    required this.eventName,
    required this.eventImage,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventTime,
    required this.eventDate,
    this.isFavourite = false

  });

Event.fromFireStore(Map<String,dynamic> data):this(
  id: data["id"],
  eventName: data["eventName"],
  eventImage: data["eventImage"],
  eventTitle: data["eventTitle"],
  eventDescription: data["eventDescription"],
  eventDate: DateTime.fromMillisecondsSinceEpoch(data["eventDate"]),
  eventTime: data["eventTime"],
  isFavourite: data["isFavourite"],
);

Map<String,dynamic> toFireStore() {
  return {
    "id": id,
    "eventName": eventName,
    "eventImage": eventImage,
    "eventTitle": eventTitle,
    "eventDescription": eventDescription,
    "eventTime": eventTime,
    "eventDate": eventDate.millisecondsSinceEpoch,
    "isFavourite": isFavourite,
  };
}
}