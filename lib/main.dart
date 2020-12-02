import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app34/ad_manager.dart';
import 'package:flutter_app34/models/Texts_model.dart';
import "package:flutter_app34/models/ad_counter.dart";
import 'package:flutter_app34/models/cards_model.dart';
import 'package:flutter_app34/models/others_model.dart';
import "package:flutter_app34/models/translator_model.dart";
import 'package:flutter_app34/screen/flagged_card.dart';
import 'package:flutter_app34/screen/screen.dart';
import "package:flutter_app34/screen/settings_screen.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'ad_manager.dart';
import 'card_plus_dialog.dart';
void main()=>(runApp(MyApp()));


class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MaterialApp(
            // onGenerateTitle: (BuildContext context) => Localized.of(context).title1,
            localizationsDelegates: [
              const SampleLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('ja', ''),
            ],
            theme: ThemeData(
                primaryColor: Color(0XFFf4ecf4)
            ),
        home:Mypage()),
          providers: [
            ChangeNotifierProvider<Others>(
              create: (context)=>Others(),
            ),
            ChangeNotifierProvider<CardsModel>(
              create: (context)=>CardsModel(),
            ),ChangeNotifierProvider<TextsModel>(
              create: (context)=>TextsModel(),
            ),
            ChangeNotifierProvider<ad_counter>(
              create: (context)=>ad_counter(),
            ),
            ChangeNotifierProvider<translator_model>(
                create: (context)=>translator_model())
          ],
      );
  }

}


class Mypage extends StatefulWidget {
  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  StreamSubscription _intentDataStreamSubscription;
  String _sharedText;
  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription ??= ReceiveSharingIntent.getTextStream().listen(
      _receiveSharedText,
      onError: (err) {
        print('getTextStream error: $err');
      },
    );
    Future<void> Function(T) onLaunchedByIntent<T>(Future<bool> Function(T) f) {
      return (T v) async {
        if (v != null) {
          final isLaunchedByIntent = await f(v) ?? false;
          print('isLaunchedByIntent: $isLaunchedByIntent');

          if (Platform.isAndroid && isLaunchedByIntent) {
            return SystemNavigator.pop();
          }
        }
      };
    }
    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then(onLaunchedByIntent(_receiveSharedText));
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  Future<bool> _receiveSharedText(String text) async {
    if (text.startsWith('twitterkit')) return false;
    await showDialog(context: context,builder: (BuildContext context) =>plusdialog(text:text));
  }


  @override
  Widget build(BuildContext context) {
    var model=Provider.of<TextsModel>(context);
    Size size=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0XFFececf4),
      // floatingActionButton: plus_button(),
      body:FutureBuilder<void>(
        future:_initAdMob(),
        builder:(BuildContext context, AsyncSnapshot<void> snapshot){
          List<Widget> children = <Widget>[

          ];
          if (snapshot.hasData){
            children.add(homebody());
            children.add(settings_screen());
          }
          return PageView(physics:new NeverScrollableScrollPhysics(),
        controller:model.myPage ,
        children: children,
        allowImplicitScrolling: false,);}),

      bottomNavigationBar:BottomAppBar1(size: size),
      floatingActionButton: Container(
          height: size.height*0.15,
          width: size.width*0.18,
          child:FloatingActionButton(
            onPressed: () {

              showDialog(context: context,builder: (BuildContext context) =>plusdialog());
            },
            child:Icon(Icons.add,size: 50,),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  Future<void> _initAdMob() {
    // TODO: Initialize AdMob SDK
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }
}

class BottomAppBar1 extends StatelessWidget {
  const BottomAppBar1({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    var model=Provider.of<TextsModel>(context);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Container(
                height:size.height*0.1,
                child:Stack(
                    children:[Positioned(top:size.height*0.053,right: size.width*0.01,child: Text("home",style:model.page_color?null: TextStyle(color: Colors.black.withOpacity(0.3)),),),
                      Container(child: IconButton(icon:Icon(Icons.home,color: model.page_color?null:Colors.black.withOpacity(0.3),),onPressed: (){
                        model.myPage.jumpToPage(0);
                        model.tap_home();
                      },),)]))
            ,
            Container(
              width: size.width*0.1,
        height: size.height*0.1,
      ),
            Container(
                height:size.height*0.1,
                child:Stack(
                    children:[Positioned(top:size.height*0.053,right: 2,child: Text("setting",style:model.page_color?TextStyle(color: Colors.black.withOpacity(0.3)):null),),
                      Container(child: IconButton(icon:Icon(Icons.settings,color:model.page_color?Colors.black.withOpacity(0.3):null),onPressed: (){
                        model.myPage.jumpToPage(1);
                        model.tap_settings();
                      }),)])),

          ]),);

  }
}





class homebody extends StatefulWidget {
  @override
  _homebodyState createState() => _homebodyState();
}

class _homebodyState extends State<homebody> {

  BannerAd _bannerAd;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SingleChildScrollView(

        child: Column(
          children: [
            Container(height: size.height*0.01,),


            Container(
              height: size.height*0.03,
            ),
            Container(height:25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text("Flagged",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 33.0,
                          fontWeight: FontWeight.bold,
                        // fontFamily: "Calibre-Semibold",
                        // letterSpacing: 1.0,
                      )),
                ],
              ),
            ),
            Container(
              height: size.height*0.02,
            ),

            Row(
              children: [Container(height: 200,width: size.width*0.07,),
                Container(height: 200, width: size.width*0.93,child:Flagg_CardWidget(size:size,position: 0)
                ),
              ],
            ),
            Container(
              height: size.height*0.05,
            ),
         
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text("Cards",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold
                        // fontFamily: "Calibre-Semibold",
                        // letterSpacing: 1.0,
                      )),
                ],
              ),
            ),
            Container(
              height: size.height*0.02,
            ),
            Container(
              height: size.height*0.26,
              child: PageView(
              controller: PageController(viewportFraction: 0.8,initialPage: 2),
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
                  children:[
                    CardWidget(size: size,position: 4,),
                    CardWidget(size: size,position: 5,),
                    CardWidget(size: size,position: 0),
                    CardWidget(size: size,position: 1),
                    CardWidget(size: size,position: 2),
              ]
          ),
        ),
          ],

          // bodywidget()
        )
    );}

}

class Flagg_CardWidget extends StatelessWidget {
  const Flagg_CardWidget({
    Key key,
    @required this.size,
    this.position,
  }) : super(key: key);

  final Size size;
  final position;
  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.title.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.normal,
    );
    var model=Provider.of<TextsModel>(context);
    return
      Stack(children:[

        GestureDetector(
            onTap:(){ Navigator.push(context,
                //     PageRouteBuilder(
                //   pageBuilder: (context, animation1, animation2) => CardView(position: position),
                // ))

                MaterialPageRoute(builder: (context) => Flagg_CardView(position:position)));

            context.read<Others>().on_shuffle();
            },
            child:Hero(
              tag:"card",
              child:Scaffold(
                backgroundColor: Color(0XFFececf4),
                body: Stack(children:[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: size.width*0.8,
                    height: size.height*0.25,
                    // child:Container(
                    //   child: Center(child: Text(
                    //      "Flagged",style: style)),
                    // ),
                    decoration: BoxDecoration(
                        color: position%3==0?Colors.white:position%3==1?Colors.blue:Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(36))
                    ),

                  ),
                  Positioned(
                    top: 15,right: 30,child: Icon(Icons.flag,color: Color(0XFF646464)),
                  ),
                  Positioned(
                      top: size.height*0.025,left: size.width*0.065,
                      child: Container(
                        width: size.height*0.04,
                        height: size.width*0.05,
                        decoration: BoxDecoration(
                          color: Color(0XFFf4ecf4),

                          shape: BoxShape.circle,

                        ),
                      )) ,
                ]),
              ),
            )),
      ]);


  }
}


class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    @required this.size,
    this.position,
  }) : super(key: key);

  final Size size;
  final position;
  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.title.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.normal,
    );
    var model=Provider.of<TextsModel>(context);
    return
          Stack(children:[

            GestureDetector(
            onTap:(){ Navigator.push(context,
            //     PageRouteBuilder(
            //   pageBuilder: (context, animation1, animation2) => CardView(position: position),
            // ))

                MaterialPageRoute(builder: (context) => CardView(position:position)));
            context.read<Others>().on_shuffle();
            },
              child:Hero(
                tag:"card"+position.toString(),
              child:Scaffold(
                backgroundColor: Color(0XFFececf4),
                body: Stack(children:[
                  Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: size.width*0.8,
            height: size.height*0.25,
            child:Container(
                child: Center(child: Text(
                    position%3==0?model.white_title.replaceAll(" ", "\n"):position%3==1?model.blue_title.replaceAll(" ", "\n"):model.red_title.replaceAll(" ", "\n"),style: style)),

            ),
            decoration: BoxDecoration(

                  color: position==4?Colors.orange:position==5?Colors.purpleAccent:position==0?Colors.white:position==1?Colors.blue:Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(36))
            ),

          ),
                  Positioned(
                      top: size.height*0.025,left: size.width*0.065,
                    child: Container(
                      width: size.height*0.04,
                      height: size.width*0.05,
                      decoration: BoxDecoration(
                        color: Color(0XFFf4ecf4),

                        shape: BoxShape.circle,

                      ),
                    )) ,
                  Positioned(
                  right:size.width*0.02,top: size.height*0.09,
                  child:RaisedButton(
                    child: Icon(Icons.edit,size: 23,),
                    color: position==4?Colors.orange:position==5?Colors.purpleAccent:position==0?Colors.white:position==1?Colors.blue:Colors.red,
                    elevation: 0,
                    shape: CircleBorder(
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>ChangeTitle(position: position,)
                      );
                    },
                  ),)
                ]),
              ),
              )),
    ]);


  }
}

class ChangeTitle extends StatelessWidget {
  const ChangeTitle({
    Key key,this.position
  }) : super(key: key);
  final position;

  @override
  Widget build(BuildContext context) {
    var model=Provider.of<TextsModel>(context);
    final titleTextEditingController = TextEditingController();
    return SimpleDialog(
        contentPadding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: titleTextEditingController,
            decoration: InputDecoration(
                hintText: "New Title"
            ),
          ),
          FlatButton(
            child: Text('Apply'),
            color: Colors.blue,
            onPressed: () {
              if(position==0){
                model.setup_white(titleTextEditingController.text);
              }
              else if(position==1){
                model.setup_blue(titleTextEditingController.text);
              }
              else if(position==2){
                model.setup_red(titleTextEditingController.text);
              }
              Navigator.pop(context);
            },
          ),
        ]


    );
  }
}


