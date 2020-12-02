import 'package:flutter/material.dart';
import 'package:flutter_app34/models/ad_counter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app34/ad_manager.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_app34/screen/settings_screen.dart";
import 'package:auto_size_text/auto_size_text.dart';

class Ad_screen extends StatefulWidget {
  @override
  _Ad_screenState createState() => _Ad_screenState();
}

class _Ad_screenState extends State<Ad_screen> {
  var counter=0;

  void setup_ad_counter(){
    counter+=1;
    set_ad_counter();
    // print(counter.toString());
  }

  void get_ad_counter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    counter = prefs.getInt('counter')??0;
    setState(() {
      counter=counter;
    });
  }

  void set_ad_counter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
  }
  bool _isRewardedAdReady;
  @override
  void initState() {
    get_ad_counter();

    _isRewardedAdReady = false;
    RewardedVideoAd.instance.listener = _onRewardedAdEvent;
    _loadRewardedAd();
  }

  // TODO: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedVideoAd.instance.load(
      targetingInfo: MobileAdTargetingInfo(),
      adUnitId: AdManager.rewardedAdUnitId,
    );
  }

  // TODO: Implement _onRewardedAdEvent()
  void _onRewardedAdEvent(RewardedVideoAdEvent event,
      {String rewardType, int rewardAmount}) {
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        setState(() {
          _isRewardedAdReady = true;
        });
        break;
      case RewardedVideoAdEvent.closed:
        setState(() {
          _isRewardedAdReady = false;
        });
        _loadRewardedAd();
        break;
      case RewardedVideoAdEvent.failedToLoad:
        setState(() {
          _isRewardedAdReady = false;
        });
        print('Failed to load a rewarded ad');
        break;
      case RewardedVideoAdEvent.rewarded:
        setup_ad_counter();
        break;
      default:
      // do nothing
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var model=Provider.of<ad_counter>(context);
    return Scaffold(
      backgroundColor:Color(0XFFececf4),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
    ),body:Column(
      children: [
        Container(height: size.height*0.05,),

        Container(
          alignment:Alignment.center ,
          child: Icon(Icons.tv,size: 200,),)
        ,
        Container(height: size.height*0.05,)
        ,Container(
          alignment: Alignment.center,
          child:Container(
              width: size.width*0.9,
              child: AutoSizeText(Localized.of(context).text4,maxLines: 1,style: TextStyle(fontSize: 18),))
        ),
        Container(height: size.height*0.05,),
        Container(
          child: RaisedButton(
            child: Text(Localized.of(context).text5),
            onPressed: (){
              // Navigator.pop(context);
              RewardedVideoAd.instance.show();
            },

          ),
        ),
        Container(height: size.height*0.05,),
        counter>=3?Container(
          child: RaisedButton(
            child: Text(Localized.of(context).text6),
            onPressed: (){
              context.read<ad_counter>().setup_ad_trigger();
            },

          ),
        ):Container(
          child: Text(
            counter.toString()+" / 3",style:
            TextStyle(fontSize: 30),
          ),
        )
      ],
    )


    );
  }
  @override
  void dispose() {

    // TODO: Remove Rewarded Ad event listener
    RewardedVideoAd.instance.listener = null;


    super.dispose();
  }
}
