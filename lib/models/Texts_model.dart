import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class TextsModel with ChangeNotifier{


  var page_color=true;
  PageController myPage = PageController(initialPage: 0);
  var white_title="title";
  var blue_title="title";
  var red_title="title";

  var orange_title="title";
  var purple_title="title";


  void tap_home(){
    page_color=true;
    notifyListeners();
  }
  void tap_settings(){
    page_color=false;
    notifyListeners();
  }


  TextsModel(){
    get_white();
    get_blue();
    get_red();
    get_orange();
    get_purple();
    // if(red_title==null){
    //   setup_red("title");
    // };
    // if (white_title==null){
    //   setup_white("title");
    // };
    // if(blue_title==null){
    //   set_blue("title");
    // };

  }


  void setup_white(item){
    white_title=item;
    set_white();
    notifyListeners();

  }

  void get_white() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      white_title = prefs.getString('white_title')??"title";
      notifyListeners();
  }

  void set_white() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('white_title', white_title);
  }
  void setup_purple(item){
    purple_title=item;
    set_purple();
    notifyListeners();
  }

  void get_purple() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    purple_title = prefs.getString('purple_title')??"title";
    notifyListeners();
  }

  void set_purple() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('purple_title', purple_title);
  }
  void setup_orange(item){
    orange_title=item;
    set_orange();
    notifyListeners();
  }

  void get_orange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    orange_title = prefs.getString('orange_title')??"title";
    notifyListeners();
  }

  void set_orange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('orange_title', orange_title);
  }

  void setup_blue(item){
    blue_title=item;
    set_blue();
    notifyListeners();
  }

  void get_blue() async {
    SharedPreferences prefsblue = await SharedPreferences.getInstance();
    blue_title = prefsblue.getString('blue_title')??"title";
    notifyListeners();
  }

  void set_blue() async {
    SharedPreferences prefsblue = await SharedPreferences.getInstance();
    prefsblue.setString('blue_title', blue_title);
  }
  void setup_red(item){
    red_title=item;
    set_red();
    notifyListeners();
  }

  void get_red() async {
    SharedPreferences prefsred = await SharedPreferences.getInstance();
    red_title = prefsred.getString('red_title')??"title";
    notifyListeners();
  }

  void set_red() async {
    SharedPreferences prefsred = await SharedPreferences.getInstance();
    prefsred.setString('red_title', red_title);
  }


}