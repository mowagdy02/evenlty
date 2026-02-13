class User {
  static const String collectionName = "myUser";
  String id;
  String name;
  String email;
  User({
    required this.id,
    required this.name,
    required this.email
});
  User.fromFireStore(Map<String,dynamic> data):this(
    id:data["id"],
    name:data["name"],
    email:data["email"],
  );

  Map<String,dynamic> toFireStore(){
    return{
      "id":id,
      "name":name,
      "email":email
    };
  }
}