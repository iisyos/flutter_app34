import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
class Others extends ChangeNotifier{
  var text;
  var trigger1=false;
  var tab_triger=false;
  var shufflea=false;

  void true_shuffle(){
    shufflea=true;
    notifyListeners();
  }

  void on_shuffle(){
    shufflea=false;
    notifyListeners();
  }

  void on_tab_trigger(){
    tab_triger=!tab_triger;
    notifyListeners();
  }

  final translator = GoogleTranslator();

  void shuffle1_trigger(){
    trigger1=!trigger1;
    notifyListeners();
  }

  void o_translator(i){
    o_translator1(i);
    notifyListeners();
  }


  void o_translator1(t) async {
    var translation = await translator
        .translate(t, from: 'en', to: 'ja');
    text=translation;
    notifyListeners();
  }

}