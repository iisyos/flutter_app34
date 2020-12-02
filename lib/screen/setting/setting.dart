import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app34/models/translator_model.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app34/screen/settings_screen.dart';


class Translator_setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model=Provider.of<translator_model>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor:Color(0XFFececf4) ,
      body: change_translator(),
    );

}
}


class change_translator extends StatefulWidget {
  @override
  _change_translatorState createState() => _change_translatorState();
}

class _change_translatorState extends State<change_translator> {
  String front;
  String back;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    get_back();
    get_front();

  }
  void setup_front(){
    set_front();
  }

  void get_front() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      front = prefs.getString('front')??"en";
    });
  }

  void set_front() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('front', front);
  }




  void setup_back(){
    set_back();
  }

  void get_back() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      back = prefs.getString('back')??"ja";
    });
  }

  void set_back() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('back', back);
  }

  var transformer = {
    // Key:    Value
    'ja': 'Japanese',
    'en': 'English',
    'de': 'German',
    'es': 'Spanish',
    'fr': 'French ',
    'zh': 'Chiniese',
    'ru': 'Russian',
    'ko': 'Korean',
    'hi': 'Hindi',
    'vi': 'Vietnamese',
    'th': 'Thai',
  };
//  ['ja', 'en', "de","es","fr","zh","ru","ko","hi","vi","th"]

  @override
  Widget build(BuildContext context) {
    var model=Provider.of<translator_model>(context);
    Size size=MediaQuery.of(context).size;
    return Column(
        children: [Container(height: size.height*0.05,),
          Column(
            children: [Container(child: Text("source",style: TextStyle(fontSize: 20),),),
              Container(height: size.height*0.01,),
              Container(
                // margin: EdgeInsets.all(9),
                height: size.height*0.1,
                width: size.width*0.6,
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.2),
                        spreadRadius: 1.0,
                        blurRadius: 10.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:
                Stack(
                  children: [
                    Positioned(bottom:4,left:size.width*0.14 ,
                      child: DropdownButton<String>(
                        value: front,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (String newValue) {
                          setState(() {
                            front= newValue;
                          });
                        },
                        items: <String>['ja', 'en', "de","es","fr","zh","ru","ko","hi","vi","th"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(transformer[value],style: TextStyle(fontSize: 20),),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),Container(height: size.height*0.1,child: Center(child: Icon(Icons.repeat,size: 30,),),),
          Column(
            children: [
              Container(child: Text("target",style: TextStyle(fontSize: 20),),),
              Container(height: size.height*0.01,),
              Container(
                padding: EdgeInsets.all(9),
                height: size.height*0.1,
                width: size.width*0.6,

                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.2),
                        spreadRadius: 1.0,
                        blurRadius: 10.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:
                Stack(
                  children: [
                    Positioned(bottom:4,left:size.width*0.14 ,
                      child: DropdownButton<String>(
                        value: back,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (String newValue) {
                          setState(() {
                            back = newValue;
                          });
                        },
                        items: <String>['ja', 'en', "de","es","fr","zh","ru","ko","hi","vi","th"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(transformer[value],style: TextStyle(fontSize: 20),),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(height: 20,),
          Container(
            child: RaisedButton(
              child: Text("apply",style: TextStyle(color: Colors.white),),
              color: Colors.blueAccent,
              shape: StadiumBorder(),
              onPressed: () {
                model.setup_back(back);
                model.setup_front(front);
                setup_back();
                set_front();

                final snackBar = SnackBar(
                  content: Text('applied'),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
            ),
          ),
          Spacer(),
          Container(
            height: size.height*0.2,width: size.width*0.8,
            alignment: Alignment.center,decoration: BoxDecoration(
           color: Colors.white.withOpacity(0.3),border: Border.all()
          ),
            child: Column(
              children: [
                Container(child: Text("Note", style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,decoration: TextDecoration.underline,),),
                  alignment: Alignment.topLeft,padding: EdgeInsets.all(10),),
                Container(height: size.height*0.1,width: size.width*0.745,alignment: Alignment.center,
                child: Text(Localized.of(context).note),
                )
            
            
              ],
            ),

          ),
          Spacer(),

          ]

      );
  }
}
