import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app34/models/cards_model.dart';
import 'package:flutter_app34/models/others_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app34/entity/entity.dart';
import 'package:flutter_app34/models/others_model.dart';
class setting_all_card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model=Provider.of<CardsModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon:Icon(context.select((Others value) => value.tab_triger)?Icons.add:Icons.remove),
            onPressed: (){
              context.read<Others>().on_tab_trigger();
            },
          )
        ],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor:Color(0XFFececf4) ,
      body: ListView.builder(itemBuilder: (context,index){
          return a_setting_card(model: model.allTodoList[index],index:index);

        },
          itemCount:model.allTodoList.length),);
  }
}

class a_setting_card extends StatelessWidget {
  const a_setting_card({
    Key key,
    @required this.model,
    this.index
  }) : super(key: key);

  final Cards model;
  final index;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var item=model;
    var s=Provider.of<CardsModel>(context);
    return Column(

      children: [
        Container(height: 10,),
        Container(
          height: size.height*0.14,
          width: size.width*0.97,
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
          child: Stack(
                children: [
                  Positioned(top: -10,left: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        child:context.select((Others value) =>value.tab_triger)?null: IconButton(
                          icon:Icon(Icons.delete,color: Color(0XFF646464).withOpacity(0.8)),iconSize: 27,

                          onPressed: (){
                            context.read<CardsModel>().remove(item);

                          },
                        ),
                      ),
                      Container(width: 80,),
                      Container(
                          height: 20,
                          width:20,
                          child:(
                              context.select((Others value) =>value.tab_triger)?null:RaisedButton(
                                elevation: 0,
                                color: item.orange?Colors.orangeAccent:Colors.white,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: item.orange?Colors.orangeAccent:Colors.orangeAccent.withOpacity(0.8),
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                onPressed: () {
                                  s.on_orange(item);
                                  ;},
                              ))),
                      Container(width: 16,),
                      Container(
                          height: 20,
                          width:20,
                          child:(
                              context.select((Others value) =>value.tab_triger)?null:RaisedButton(
                                elevation: 0,
                                color: item.purple?Colors.purpleAccent:Colors.white,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: item.purple?Colors.purpleAccent:Colors.purpleAccent.withOpacity(0.8),
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                onPressed: () {
                                  s.on_purple(item);
                                  ;},
                              ))),Container(width: 16,),
                      Container(
                          height: 20,
                          width:20,
                          child:(
                              context.select((Others value) =>value.tab_triger)?null:RaisedButton(
                                elevation: 0,
                                color: item.blue?Colors.blueAccent:Colors.white,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: item.blue?Colors.blueAccent:Colors.blueAccent.withOpacity(0.8),
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                onPressed: () {
                                  s.on_blue(item);
                                  ;},
                              ))),
                      Container(height: 0,width: 16,),
                      Container(
                          height: 20,
                          width: 20,
                          child:(
                              context.select((Others value) =>value.tab_triger)?null: RaisedButton(
                                elevation: 0,
                                color:item.red? Colors.redAccent:Colors.white,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: item.red?Colors.redAccent:Colors.redAccent.withOpacity(0.8),
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                onPressed: () {
                                  s.on_red(item);
                                },
                              ))),
                      Container(
                        child: context.select((Others value) =>value.tab_triger)?null:IconButton(
                          icon:item.flagg?
                          Icon(Icons.flag, ):
                          Icon(Icons.outlined_flag,color: Color(0XFF646464))
                          ,
                          iconSize: 23,color: item.flagg? Colors.red:null,
                          onPressed: (){
                            s.on_flagg(item);
                          },),
                      ),
                    ],
                  ),

                  ),
                  Positioned(
                    top: size.height*0.046,
                  right: size.width*0.05,
                  child:Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    alignment:Alignment.topCenter ,
                    child: AutoSizeText(model.card_name,maxLines: 2,style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold
                    ),),
                  ) ,),
                  Positioned(
                    top: size.height*0.05,
                    left: size.width*0.05,
                    child:Container(
                      width: 150,
                      alignment:Alignment.center ,
                      child: AutoSizeText(model.en_card_name,maxLines: 1,style: TextStyle(
                          fontSize: 25,fontWeight: FontWeight.bold
                      ),),
                    ) ,),
                  Positioned(
                    top: size.height*0.05,
                    left: size.width*0.45,
                    child: Icon(Icons.compare_arrows,size: 28,color:Color(0XFF646464) ,),
                  )
                ],
              ),


        ),
        Container(height: 3,)
      ],
    );
  }
}
