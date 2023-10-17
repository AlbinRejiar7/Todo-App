import 'package:hive_flutter/hive_flutter.dart';

class Database {
  final _db = Hive.box('myBox');

  List myTODOList = [];

  void demotodolist() async {
    myTODOList = [
      [
        'Name or title',
        'your task',
        'time',
        2,
      ]
    ];
  }

  void updatedatabase() async {
    _db.put('mylist', myTODOList);
  }

  void loadfromdatabase() async {
    myTODOList = _db.get('mylist');
  }

  void deleteallfromdatabase() async {
    _db.delete('mylist');
  }
}
