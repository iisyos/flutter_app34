import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app34/models/translator_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app34/entity/entity.dart';
import 'package:flutter_app34/models/cards_model.dart';
import 'ad_manager.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_app34/ad_manager.dart';
import 'dart:math'as math;
import "package:flutter_app34/models/ad_counter.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Album {
  final String text;
  final String source;
  final String target;

  Album({this.text, this.source, this.target});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      text: json['text'],
      source: json['source'],
      target: json['target'],
    );
  }
}

class plusdialog extends StatelessWidget {
  const plusdialog({
    Key key,this.text
  }) : super(key: key);
  
  final text;

  @override
  Widget build(BuildContext context) {
     var model=Provider.of<ad_counter>(context);
    return model.ad_trigger?plusdialog_stful2(text:text):plusdialog_stful(text:text);}}


class plusdialog_stful extends StatefulWidget {
  const plusdialog_stful({this.text});
  final text;
  
  @override
  _plusdialog_stfulState createState() => _plusdialog_stfulState(text:text);
}

class _plusdialog_stfulState extends State<plusdialog_stful> {
  _plusdialog_stfulState({this.text});
  
  final text;
  var red=false;
  var blue=false;
  var purple=false;
  var orange=false;
  var flagg=false;
  var en_text="";
  var jap_text="";
  var e=true;
  var j=true;
  var num;
  var mo=ad_counter();

  var trans_trigger=false;

  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady;


  Future<Album> futureAlbum;

  Future<Album> fetchAlbum(String text,String front,String back) async {
    final response = await http.get('https://script.google.com/macros/s/AKfycbzEbhR8T-Ap1tQU0u5i8f2k5I9SJKNXIMQo2dfFfTHHdONRJOc/exec?text=' +text + '&source='+front+'&target='+back);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }}




  void _loadInterstitialAd() {
    _interstitialAd.load();
  }
  void dispose() {
    // TODO: Dispose InterstitialAd object
    _interstitialAd?.dispose();
    super.dispose();
  }

  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        num=math.Random().nextInt(6);
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        num=0;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        showDialog(context: context
            ,builder: (BuildContext context) =>plusdialog());
        break;
      default:
      // do nothing
    }
  }
  void initState() {
    
    if(text!=null)setState(() {
      en_text=text;
    });
    
    _isInterstitialAdReady = false;

    _interstitialAd = mo.ad_trigger?null:InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
    mo.ad_trigger?null:_loadInterstitialAd();
    var futureAlbum;
  }

  @override
  Widget build(BuildContext context) {
    var model=Provider.of<CardsModel>(context);
    var model1=Provider.of<ad_counter>(context);
    var model2=Provider.of<translator_model>(context);
    var size=MediaQuery.of(context).size;

    return SimpleDialog(
        contentPadding: EdgeInsets.all(30),
        children: <Widget>[


          Container(padding: EdgeInsets.only(left: size.width*0.01,bottom: size.height*0.01),),
          Container(
              height: size.height*0.15,
              decoration: BoxDecoration(color: Colors.white,
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(18))
              ),
              child:Container(margin:EdgeInsets.symmetric(horizontal: size.height*0.03,vertical: size.width*0.05),
                  child:TextFormField(
                    initialValue: en_text==""?null:en_text,
                    onChanged: (String s){
                      setState(() {
                        en_text=s;
                      });

                    },
                    decoration: InputDecoration(
                      hintText: "FRONT SIDE（ "+model2.front+" ）",
                      errorText: e ?  null:'Value Can\'t Be Empty',
                    ),
                  ))) ,

          Container(alignment: Alignment.center,height: size.height*0.05,
          child:en_text==""?null:IconButton(icon:Icon(Icons.repeat)
          ,onPressed: (){
            futureAlbum=fetchAlbum(en_text,model2.front,model2.back);
            setState(() {
              trans_trigger=true;
            });

            },
          )),

          Container(
            height: size.height*0.15,
            decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(18))
            ),
            child:trans_trigger?
            FutureBuilder<Album>(
              future: futureAlbum,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      jap_text=snapshot.data.text;
              return Container(
                  margin:EdgeInsets.symmetric(horizontal: size.height*0.03,vertical: size.width*0.05),
                  child:(TextFormField(
                    initialValue: snapshot.data.text,
                    onChanged: (String s){
                      setState(() {
                        jap_text=s;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "BACK SIDE（ "+model2.back+" ）",
                      errorText: j ?  null:'Value Can\'t Be Empty',
                    ),
                  )));}
               return CircularProgressIndicator();},
            )
                :
            Container(margin:EdgeInsets.symmetric(horizontal: size.height*0.03,vertical: size.width*0.05),
                child:(TextFormField(
                  initialValue: jap_text==""?null:jap_text,
                  onChanged: (String s){
                    setState(() {
                      jap_text=s;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "BACK SIDE（ "+model2.back+" ）",
                    errorText: j ?  null:'Value Can\'t Be Empty',
                  ),
                ))) ,),
          Row(
            children: [
              Container(width: size.width*0.07,),
              Container(
                  height: size.height*0.055,
                  width:size.width*0.055,
                  child:(
                      RaisedButton(
                        elevation: 0,
                        color: orange?Colors.orangeAccent:Colors.white,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: orange?Colors.orangeAccent:Colors.orangeAccent.withOpacity(0.8),
                            width: 2.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {setState(() {
                          orange=!orange;
                        });},
                      ))),
              Container(width: size.width*0.05,),
              Container(
                  height: size.height*0.055,
                  width:size.width*0.055,
                  child:(
                      RaisedButton(
                        elevation: 0,
                        color: purple?Colors.purpleAccent:Colors.white,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: purple?Colors.purpleAccent:Colors.purpleAccent.withOpacity(0.8),
                            width: 2.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {setState(() {
                          purple=!purple;
                        });},
                      ))),
              Container(width: size.width*0.05,),
              Container(
                  height: size.height*0.055,
                  width:size.width*0.055,
                  child:(
                      RaisedButton(
                        elevation: 0,
                        color: blue?Colors.blueAccent:Colors.white,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: blue?Colors.blueAccent:Colors.blueAccent.withOpacity(0.8),
                            width: 2.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {setState(() {
                          blue=!blue;
                        });},
                      ))),

              Container(width: size.width*0.05,),
              Container(
                  height: size.height*0.055,
                  width:size.width*0.055,
                  child:(
                      RaisedButton(
                        elevation: 0,
                        color:red? Colors.redAccent:Colors.white,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: red?Colors.redAccent:Colors.redAccent.withOpacity(0.8),
                            width: 2.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {setState(() {
                          red=!red;
                        });


                        },
                      ))),
              Container(width: size.width*0.03,),

              IconButton(icon: Icon(flagg?Icons.flag:Icons.outlined_flag),iconSize: 28,color: flagg? Colors.red:null,
                onPressed: (){
                  setState(() {
                    flagg=!flagg;
                  });
                },)
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [RaisedButton(child:Text("FINISH"),
              color: Colors.redAccent,
              onPressed:(){
                Navigator.pop(context);
              } ,
            ),
              RaisedButton(
                child: Text("CONTINUE"),
                color:Colors.greenAccent ,
                onPressed: () {

                  if(en_text==""){
                    setState(() {
                      e=false;
                    });
                  }else if(jap_text==""){
                    setState(() {
                      j=false;
                    });
                  }else{

                    model.add(Cards(card_name:jap_text,
                        en_card_name: en_text,red: red,blue: blue,flagg: flagg));
                    if(model1.ad_trigger==false) {
                      if(num>3){
                        _interstitialAd.show();
                      };
                    };
                    Navigator.pop(context);
                    showDialog(context: context
                        ,builder: (BuildContext context) =>plusdialog());
                  };
                },
              )],),
        ]

    );
  }

}

class plusdialog_stful2 extends StatefulWidget {
  const plusdialog_stful2({this.text});
  final text;
  
  @override
  _plusdialog_stfulState2 createState() => _plusdialog_stfulState2(text:text);
}

class _plusdialog_stfulState2 extends State<plusdialog_stful2> {
  _plusdialog_stfulState2({this.text});
  
  final text;
  var red=false;
  var blue=false;
  var orange=false;
  var purple=false;
  var flagg=false;
  var en_text="";
  var jap_text="";
  var e=true;
  var j=true;
  var num;


  var trans_trigger=false;

  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady;


  Future<Album> futureAlbum;

  Future<Album> fetchAlbum(String text,String front,String back) async {
    final response = await http.get('https://script.google.com/macros/s/AKfycbzEbhR8T-Ap1tQU0u5i8f2k5I9SJKNXIMQo2dfFfTHHdONRJOc/exec?text=' +text + '&source='+front+'&target='+back);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }}




  void initState() {
    if(text!=null)
setState(() {en_text=text;

});
    _isInterstitialAdReady = false;
    var futureAlbum;
  }

  @override
  Widget build(BuildContext context) {
    var model=Provider.of<CardsModel>(context);
    var model1=Provider.of<translator_model>(context);
    Size size=MediaQuery.of(context).size;
    return SimpleDialog(
        contentPadding: EdgeInsets.all(30),
        children: <Widget>[


          Container(padding: EdgeInsets.only(left: size.width*0.01,bottom: size.height*0.01),),
          Container(
              height: size.height*0.15,
              decoration: BoxDecoration(color: Colors.white,
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(18))
              ),
              child:Container(margin:EdgeInsets.symmetric(horizontal: size.height*0.03,vertical: size.width*0.05),
                  child:TextFormField(
                    initialValue: en_text==""?null:en_text,
                    onChanged: (String s){
                      setState(() {
                        en_text=s;
                      });

                    },
                    decoration: InputDecoration(
                      hintText: "FRONT SIDE（ "+model1.front+" ）",
                      errorText: e ?  null:'Value Can\'t Be Empty',
                    ),
                  ))) ,

          Container(alignment: Alignment.center,height: size.height*0.05,
              child:en_text==""?null:IconButton(icon:Icon(Icons.repeat)
                ,onPressed: (){
                  futureAlbum=fetchAlbum(en_text,model1.front,model1.back);
                  setState(() {
                    trans_trigger=true;
                  });

                },
              )),

          Container(
            height: size.height*0.15,
            decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(18))
            ),
            child:trans_trigger?
            FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  jap_text=snapshot.data.text;
                  return Container(
                      margin:EdgeInsets.symmetric(horizontal: size.height*0.03,vertical: size.width*0.05),
                      child:(TextFormField(
                        initialValue: snapshot.data.text,
                        onChanged: (String s){
                          setState(() {
                            jap_text=s;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "BACK SIDE（ "+model1.back+" ）",
                          errorText: j ?  null:'Value Can\'t Be Empty',
                        ),
                      )));}
                return CircularProgressIndicator();},
            )
                :
            Container(margin:EdgeInsets.symmetric(horizontal: size.height*0.03,vertical: size.width*0.05),
                child:(TextFormField(
                  initialValue: jap_text==""?null:jap_text,
                  onChanged: (String s){
                    setState(() {
                      jap_text=s;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "BACK SIDE（ "+model1.back+" ）",
                    errorText: j ?  null:'Value Can\'t Be Empty',
                  ),
                ))) ,),
          Row(
            children: [
              Container(width: size.width*0.07,),
              Container(
                  height: size.height*0.055,
                  width:size.width*0.055,
                  child:(
                      RaisedButton(
                        elevation: 0,
                        color: orange?Colors.orangeAccent:Colors.white,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: orange?Colors.orangeAccent:Colors.orangeAccent.withOpacity(0.8),
                            width: 2.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {setState(() {
                          orange=!orange;
                        });},
                      ))),
              Container(width: size.width*0.05,),
              Container(
                  height: size.height*0.055,
                  width:size.width*0.055,
                  child:(
                      RaisedButton(
                        elevation: 0,
                        color: purple?Colors.purpleAccent:Colors.white,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: purple?Colors.purpleAccent:Colors.purpleAccent.withOpacity(0.8),
                            width: 2.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {setState(() {
                          purple=!purple;
                        });},
                      ))),
              Container(width: size.width*0.05,),
              Container(
                  height: size.height*0.055,
                  width:size.width*0.055,
                  child:(
                      RaisedButton(
                        elevation: 0,
                        color: blue?Colors.blueAccent:Colors.white,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: blue?Colors.blueAccent:Colors.blueAccent.withOpacity(0.8),
                            width: 2.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {setState(() {
                          blue=!blue;
                        });},
                      ))),

              Container(width: size.width*0.05,),
              Container(
                  height: size.height*0.055,
                  width:size.width*0.055,
                  child:(
                      RaisedButton(
                        elevation: 0,
                        color:red? Colors.redAccent:Colors.white,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: red?Colors.redAccent:Colors.redAccent.withOpacity(0.8),
                            width: 2.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {setState(() {
                          red=!red;
                        });


                        },
                      ))),
              Container(width: size.width*0.03,),

              IconButton(icon: Icon(flagg?Icons.flag:Icons.outlined_flag),iconSize: 28,color: flagg? Colors.red:null,
                onPressed: (){
                  setState(() {
                    flagg=!flagg;
                  });
                },)
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [RaisedButton(child:Text("FINISH"),
              color: Colors.redAccent,
              onPressed:(){
                Navigator.pop(context);
              } ,
            ),
              RaisedButton(
                child: Text("CONTINUE"),
                color:Colors.greenAccent ,
                onPressed: () {

                  if(en_text==""){
                    setState(() {
                      e=false;
                    });
                  }else if(jap_text==""){
                    setState(() {
                      j=false;
                    });
                  }else{

                    model.add(Cards(card_name:jap_text,
                        en_card_name: en_text,red: red,blue: blue,flagg: flagg,orange: orange,purple: purple));
                    Navigator.pop(context);
                    showDialog(context: context
                        ,builder: (BuildContext context) =>plusdialog());
                  };
                },
              )],),
        ]

    );
  }

}