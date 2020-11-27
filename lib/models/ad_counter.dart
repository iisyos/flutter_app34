import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ad_counter with ChangeNotifier{

  var ad_trigger=false;

  ad_counter(){
    get_ad_trigger();
  }


  void setup_ad_trigger(){
    ad_trigger=true;
    set_ad_trigger();
    notifyListeners();
    // print(counter.toString());
  }

  void get_ad_trigger() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ad_trigger = prefs.getBool('ad_trigger')??false;
    notifyListeners();
  }

  void set_ad_trigger() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('ad_trigger', ad_trigger);
  }

}