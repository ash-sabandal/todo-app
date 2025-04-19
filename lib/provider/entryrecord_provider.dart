import 'package:flutter/material.dart';
import 'package:my_app/model/user_model.dart';

class EntryRecord with ChangeNotifier {
  final List<User> _entryList = [];
  List<User> get cart => _entryList;
 
  void addUser(User user) {
    _entryList.add(user);
    notifyListeners();
  }

  void removeAll() {
    _entryList.clear();
    notifyListeners();
  }


    User removeUser(int i) {
      User removed = _entryList.removeAt(i);
    notifyListeners();
    return removed;
  }
}

