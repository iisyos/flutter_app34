
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cards.dart';
import 'models/listtile.dart';


void main()=>(runApp(MyApp()));

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return
      MultiProvider(
        child: Mypage(),
          providers: [
            ChangeNotifierProvider<Cards>(
              create: (context)=>Cards(),
            )
          ],
      );
  }
}

class Mypage extends StatelessWidget {
  const Mypage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home:Scaffold(
        floatingActionButton: plus_button(),

        body: Center(
        child:bodywidget())
    ));
  }
}

class bodywidget extends StatelessWidget {

  Widget build(BuildContext context) {
    var list=context.select((Cards value) => value.cards);
    var c=context.select(( Cards value) => value.c);
    return list.isEmpty? Center(child: Text("No Card")):
    ListView.builder(itemBuilder:(BuildContext context,index){
      var todo = list[index];
      return list_tile(todo: todo,index:index);
    },itemCount: list.length )
    ;
  }
}









class plus_button extends StatelessWidget {
  const plus_button({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
    showDialog(
    context: context,
    builder: (BuildContext context) =>AddTodoDialog()
    );
    },
    );
  }
}
class AddTodoDialog extends StatelessWidget {
  AddTodoDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleTextEditingController = TextEditingController();
    return SimpleDialog(
      title: Text("Add word in English"),
      contentPadding: EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          controller: titleTextEditingController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Write"
          ),
        ),
        FlatButton(
          child: Text('Add'),
          color: Colors.blue,
          onPressed: () {
            context.read<Cards>().add_card(para(titleTextEditingController.text,titleTextEditingController.text));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}



