import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateModel with ChangeNotifier{

  var date;

  DateModel(){
    get_date();
  }

  void setup_date(item){
    date=item;
    set_date();
    notifyListeners();
  }

  void get_date() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    date = prefs.getString('date')??"title";
    notifyListeners();
  }

  void set_date() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('date', date);
  }
}