import 'package:flutter/material.dart';
import 'package:flutter_app34/main.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_app34/screen/setting/all_card.dart';
import "package:flutter_app34/screen/setting/ad_screen.dart";
import "package:flutter_app34/screen/setting/setting.dart";
import 'package:flutter_localizations/flutter_localizations.dart';

class settings_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0XFFececf4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: size.height*0.05,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Translator_setting()));
              },
              child: Container(
                height: size.height*0.25,
                decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(36))
        ),
                child: Stack(
                  children: [
                    Positioned(top: 12,left: 120,
                    child: Text(Localized.of(context).title1,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
                    Positioned(top:50 ,left: 20,
                    child:Icon(Icons.repeat,size: 70),),
                    Positioned(top:80,left: 125,
                    child: Text(Localized.of(context).text1,style: TextStyle(
                      color: Colors.black.withOpacity(0.8),fontSize: 15
                    ),),)

                  ],
                ),
              ),
            ),
            Container(height: size.height*0.03,),
            GestureDetector(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => setting_all_card()));
              },
              child: Container(
                height: size.height*0.25,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(36))
                ),
                child: Stack(
                  children: [
                    Positioned(top: 12,left: 140,
                      child: Text(Localized.of(context).title2,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
                    Positioned(top:50 ,left: 20,
                      child:Icon(Icons.style,size: 70),),
                    Positioned(top:80,left: 130,
                      child: Text(Localized.of(context).text2,style: TextStyle(
                          color: Colors.black.withOpacity(0.8),fontSize: 15
                      ),),)

                  ],
                ),
              ),
            ),
            Container(height: size.height*0.03,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Ad_screen()));
              },
              child: Container(
                height: size.height*0.25,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(36))
                ),
                child: Stack(
                  children: [
                    Positioned(top: 12,left: 140,
                      child: Text(Localized.of(context).title3,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
                    Positioned(top:50 ,left: 20,
                      child:Icon(Icons.tv,size: 70),),
                    Positioned(top:80,left: 130,
                      child: Text(Localized.of(context).text3,style: TextStyle(
                          color: Colors.black.withOpacity(0.8),fontSize: 15
                      ),),)

                  ],
                ),
              ),
            ),
          ],
        ),
      ),


    );
  }
}
class Localized {
  Localized(this.locale);

  final Locale locale;

  static Localized of(BuildContext context) {
    return Localizations.of<Localized>(context, Localized);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'de': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'es': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'fr': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'zh': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'ru': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'ko': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'hi': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'vi': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'th': {
      'title1': 'translation settings',
      "text1":"Set the language to translate automatically",
      'title2': 'Card List',
      "text2":"Check the created card",
      'title3': 'Advertising settings',
      "text3":"Set about the display of advertisements",

      "text4":"If you look at the ad three times, all the ads will disappear",
      "text5":"watch",
      "text6":"delete"
    },
    'ja': {
      'title1': '自動翻訳の設定',
      "text1":"自動翻訳する言語を設定します",
      'title2': 'カード一覧',
      "text2":"作成したカードを確認します",
      'title3': '広告の設定',
      "text3":"広告の表示について設定します",

      "text4":"広告を三回見るとすべての広告が消えます",
      "text5":"広告を見る",
      "text6":"広告を消す"
    },
  };

  String get title1 {
    return _localizedValues[locale.languageCode]['title1'];
  }
  String get text1 {
    return _localizedValues[locale.languageCode]['text1'];
  }
  String get title2 {
    return _localizedValues[locale.languageCode]['title2'];
  }
  String get text2 {
    return _localizedValues[locale.languageCode]['text2'];
  }
  String get title3 {
    return _localizedValues[locale.languageCode]['title3'];
  }
  String get text3 {
    return _localizedValues[locale.languageCode]['text3'];
  }
  String get text4 {
    return _localizedValues[locale.languageCode]['text4'];
  }
  String get text5 {
    return _localizedValues[locale.languageCode]['text5'];
  }
  String get text6 {
    return _localizedValues[locale.languageCode]['text6'];
  }

}
class SampleLocalizationsDelegate extends LocalizationsDelegate<Localized> {
  const SampleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>   ['ja', 'en', "de","es","fr","zh","ru","ko","hi","vi","th"].contains(locale.languageCode);

  @override
  Future<Localized> load(Locale locale) async => Localized(locale);


  @override
  bool shouldReload(SampleLocalizationsDelegate old) => false;
}
