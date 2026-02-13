import 'package:evently/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  User? currentUser;
  void updateUser(User myUser){
    if(currentUser == myUser) return;
    currentUser = myUser;
    notifyListeners();
  }
}