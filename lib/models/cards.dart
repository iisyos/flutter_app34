
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:translator/translator.dart';




class para{
  var text;
  var entext;
  var isdone=false;
  para(this.text,this.entext);
  final translator = GoogleTranslator();


  transf (x)async{


    var translation = await translator
        .translate(x, from: 'en', to: 'ja');

    return translation;

  }
  get a=>transf(text);

}


class Cards extends ChangeNotifier {
  List cards=[];
  var c=0;
  List en_cards=[];

  void add_card(para card){
    cards.add(card);
    c++;
    notifyListeners();

  }

  void tf(index)async{
    cards[index].isdone=!cards[index].isdone;

    var translation = await translator
        .translate(cards[index].text, from: 'en', to: 'ja');

    cards[index].entext=translation.toString();
    c++;
    notifyListeners();
  }

  void rem (index){
    c++;
    cards.removeAt(index);
    notifyListeners();
  }

  final translator = GoogleTranslator();

void trans (index)async{
  c++;

  var translation = await translator
      .translate(cards[index].text, from: 'en', to: 'ja');

  cards[index].entext=translation.toString();
  notifyListeners();
}


}