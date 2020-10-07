
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cards.dart';
import 'dart:developer';
import 'package:translator/translator.dart';

class list_tile extends StatelessWidget {
  const list_tile({
    Key key,
    @required this.todo,this.index
  }) : super(key: key);
  final  todo;
  final index;
  @override
  Widget build(BuildContext context) {
    var c=context.select((Cards value) => value.c);
    return Card(
      child: ListTile(
        trailing: button2(todo: todo, index: index),
        leading: button1(todo: todo,index: index,),
        title: todo.isdone? Text(todo.entext):Text(todo.text),
      ),);
  }
}

class button2 extends StatelessWidget {
  const button2({
    Key key,
    @required this.todo,
    @required this.index,
  }) : super(key: key);

  final  todo;
  final  index;

  @override
  Widget build(BuildContext context) {
    var c=context.select((Cards value) => value.c);
    return FlatButton(child: Icon(Icons.loop,color:todo.isdone? Colors.red:null ),
      onPressed: (){
      log(todo.entext.toString());
      context.read<Cards>().tf(index);
      },

    );
  }
}





class button1 extends StatelessWidget {
  const button1({
    Key key,
    @required this.todo,this.index
  }) : super(key: key);

  final  todo;
  final index;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed:(){
      context.read<Cards>().rem(index);},
      child: Icon(Icons.restore_from_trash),
    );



  }
}
