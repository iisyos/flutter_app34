import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class translator_model with ChangeNotifier{

  var front="en";
  var back="ja";

  translator_model(){
    get_front();
    get_back();
  }


  void setup_front(item){
    front=item;
    set_front(item);
    notifyListeners();
  }

  void get_front() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    front = prefs.getString('front1')??"en";
    notifyListeners();
  }

  void set_front(item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('front1', item);
  }




  void setup_back(item){
    back=item;
    set_back(item);
    notifyListeners();
  }

  void get_back() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    back = prefs.getString('back2')??"ja";
    notifyListeners();
  }

  void set_back(item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('back2', item);
  }


}