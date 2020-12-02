import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app34/entity/entity.dart';
import 'package:flutter_app34/models/Texts_model.dart';
import 'package:flutter_app34/models/cards_model.dart';
import 'package:flutter_app34/models/others_model.dart';
import 'package:flutter_app34/transformer/transformer.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class Flagg_CardView extends StatelessWidget {
  const Flagg_CardView({
    Key key,
    this.position,
  }) : super(key: key);
  final position;

  @override
  Widget build(BuildContext context) {
    var others = Provider.of<Others>(context);
    final TextStyle style =
    Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 45);
    var model = Provider.of<TextsModel>(context);
    var card_model = Provider.of<CardsModel>(context);
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        backgroundColor: Color(0XFFececf4),
        body: Column(
            children: [
              Container(height: size.height * 0.29),
              Container(
                  height: size.height * 0.47,
                  child: TransformerPageView(
                      onPageChanged: (page) {
                        page == 0 ? others.on_shuffle() : null;
                        page == 1 ? others.true_shuffle() : null;
                        page == 0 ? null : card_model.all_refresh(
                            others.trigger1 ? card_model.flaggList[card_model
                                .flaggList.length - page]
                                : card_model.shuffled_flaggList[card_model
                                .flaggList.length - page]);
                      },
                      transformer: DeepthPageTransformer(),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Hero(
                                  tag: "card",
                                  child: title_card(position: position,
                                      model: model, style: style, size: size)));
                        }
                        else {
                          return a_card(position: position, item:
                          others.trigger1 ? card_model.flaggList[card_model
                              .flaggList.length - index]
                              : card_model.shuffled_flaggList[card_model
                              .flaggList.length - index],
                              index: index);
                        }
                      },
                      itemCount: card_model.flaggList.length + 1
                  )),


              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Container(
                    child: RaisedButton(
                      child: Text("Home", style: TextStyle(fontSize: 16,
                          color: Colors.white, fontWeight: FontWeight.bold),),
                      color: Color(0XFF54c404),
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: others.shufflea ? null : RaisedButton(
                      child: Text("Shuffle", style: TextStyle(fontSize: 16,
                          color: Colors.white, fontWeight: FontWeight.bold),),
                      shape: StadiumBorder(),
                      onPressed: () {
                        others.shuffle1_trigger();
                        card_model.shuffle_list();
                      },
                    ),
                  ),

                ],
              ),

            ]));
  }
}

class title_card extends StatelessWidget {
  const title_card({
    Key key,
    @required this.position,
    @required this.model,
    @required this.style,
    @required this.size,
  }) : super(key: key);

  final position;
  final TextsModel model;
  final TextStyle style;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.only(top: 70),
        child: Stack(children: [
          Container(
            // child: Container(
            //   child: Center(child: Text("Flagged",style: style)),
            // ),

            margin: EdgeInsets.symmetric(horizontal: 10),
            width: size.width * 0.91,
            height: size.height * 0.31,
            decoration: BoxDecoration(
                color: Colors.white,
                // //         boxShadow:  [
                // //           BoxShadow(
                // //           offset: Offset(0, 10), blurRadius: 50,
                // //             color: (position%3==0?Colors.black:position%3==1?Colors.blue:Colors.red).withOpacity(0.23),
                // // ) ],
                //   color: position%3==0?Colors.white:position%3==1?Colors.blue:Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(36))
            ),


          ), Positioned(
            top: 15,
            right: 50,
            child: Icon(Icons.flag, color: Color(0XFF646464), size: 30,),
          ),
          Positioned(
              top: 20, left: 30,
              child: Container(
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: Color(0XFFf4ecf4),
                  shape: BoxShape.circle,

                ),
              )),


        ]),
      );
  }
}

class a_card extends StatelessWidget {
  const a_card({Key key, @required this.position, this.item, this.index})
      :super(key: key);
  final position;
  final Cards item;
  final index;

  //Cards instance,and depending on position
  //if position 0=>item=allTodolist,if 1 item=bluelist;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    var model = Provider.of<CardsModel>(context);
    return
      Column(children: [

        Container(height: size.height * 0.1,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: size.width * 0.09,
                  width: size.width * 0.09,
                  child: (
                      context.select((Others value) => value.tab_triger)
                          ? null
                          : RaisedButton(
                        elevation: 0,
                        color: item.orange ? Colors.orangeAccent : Color(
                            0XFFf4ecf4),
                        shape: CircleBorder(
                          side: BorderSide(
                            color: item.orange ? Colors.orangeAccent : Colors
                                .orangeAccent.withOpacity(0.8),
                            width: 3.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {
                          model.on_orange(item);
                        },
                      ))),
              Container(
                  height: size.width * 0.09,
                  width: size.width * 0.09,
                  child: (
                      context.select((Others value) => value.tab_triger)
                          ? null
                          : RaisedButton(
                        elevation: 0,
                        color: item.purple ? Colors.purpleAccent : Color(
                            0XFFf4ecf4),
                        shape: CircleBorder(
                          side: BorderSide(
                            color: item.purple ? Colors.purpleAccent : Colors
                                .purpleAccent.withOpacity(0.8),
                            width: 3.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {
                          model.on_purple(item);
                        },
                      ))),
              Container(
                  height: size.width * 0.09,
                  width: size.width * 0.09,
                  child: (
                      context.select((Others value) => value.tab_triger)
                          ? null
                          : RaisedButton(
                        elevation: 0,
                        color: item.blue ? Colors.blueAccent : Color(
                            0XFFf4ecf4),
                        shape: CircleBorder(
                          side: BorderSide(
                            color: item.blue ? Colors.blueAccent : Colors
                                .blueAccent.withOpacity(0.8),
                            width: 3.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {
                          model.on_blue(item);
                          ;
                        },
                      ))),


              Container(
                  height: size.width * 0.09,
                  width: size.width * 0.09,
                  child: (
                      context.select((Others value) => value.tab_triger)
                          ? null
                          : RaisedButton(
                        elevation: 0,
                        color: item.red ? Colors.redAccent : Color(0XFFf4ecf4),
                        shape: CircleBorder(
                          side: BorderSide(
                            color: item.red ? Colors.redAccent : Colors
                                .redAccent.withOpacity(0.8),
                            width: 3.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {
                          model.on_red(item);
                        },
                      ))),


              Container(
                child: context.select((Others value) => value.tab_triger)
                    ? null
                    : IconButton(
                  icon: item.flagg ?
                  Icon(Icons.flag,) :
                  Icon(Icons.outlined_flag, color: Color(0XFF646464))
                  ,
                  iconSize: 40, color: item.flagg ? Colors.red : null,
                  onPressed: () {
                    model.on_flagg(item);
                  },),
              ), IconButton(
                icon: Icon(context.select((Others value) => value.tab_triger)
                    ? Icons.add
                    : Icons.remove, color: Colors.black.withOpacity(0.4),),
                onPressed: () {
                  context.read<Others>().on_tab_trigger();
                },
              )
            ],
          ),
        ),
        card_text(position: position, item: item),
        Container(height: 4),
        Row(
            children: [
              Container(width: size.width * 0.02),
              Container(
                height: size.height * 0.05,
                child: context.select((Others value) => value.tab_triger)
                    ? null
                    : IconButton(
                  icon: Icon(
                      Icons.delete, color: Color(0XFF646464).withOpacity(0.8)),
                  iconSize: 27,

                  onPressed: () {
                    showDialog(context: context, builder: (_) =>
                        AlertDialog(
                          actions: <Widget>[
                            Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Text(
                                      "Sure?", style: TextStyle(fontSize: 30),),
                                    height: 50,),
                                  Container(
                                      padding: EdgeInsets.only(right: 65),
                                      child: Row(
                                        children: [
                                          Container(width: 10,),
                                          RaisedButton(
                                            child: Text("No"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          Container(width: 10,),
                                          RaisedButton(
                                            child: Text("Yes"),
                                            onPressed: () {
                                              context.read<CardsModel>().remove(
                                                  item);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      )),
                                ]
                            )
                          ],

                        )
                    );
                  },
                ),
              ),
              Container(width: size.width * 0.31,),
              Container(
                child: context.select((Others value) => value.tab_triger)
                    ? null
                    : Text(index.toString() + " / " +
                    context.select((CardsModel value) =>
                        value.flaggList.length.toString())
                    , style: TextStyle(fontSize: 20, color: Color(0XFF646464))),
              ),
            ]
        )
      ]);
  }
}

class card_text extends StatefulWidget {
  const card_text({Key key, @required this.position, this.item})
      :super(key: key);
  final position;
  final item;

  @override
  _card_textState createState() =>
      _card_textState(
          position: position, item: item

      );
}

class _card_textState extends State<card_text> {
  _card_textState({ @required this.position, this.item});

  @override
  final position;
  final Cards item;
  var refresh = false;

  Widget build(BuildContext context) {
    var model = Provider.of<CardsModel>(context);
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(
      onTap: () {
        model.f_refresh(item);
      },
      child: Stack(children: [
        Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Center(child: AutoSizeText(
              item.refresh ? item.card_name : item.en_card_name
              , style: TextStyle(fontSize: 55),
              maxLines: 1,
            ),),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: size.width * 0.91,
          height: size.height * 0.31,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(36))
          ),
        ),


        Positioned(
            top: 20, left: 30,
            child: Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: Color(0XFFf4ecf4),
                shape: BoxShape.circle,
              ),
            )),


      ]),
    );
  }
}