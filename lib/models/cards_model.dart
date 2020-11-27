import 'package:flutter/material.dart';
import 'package:flutter_app34/repository/repository.dart';
import 'package:flutter_app34/entity/entity.dart';
import 'package:translator/translator.dart';

class CardsModel with ChangeNotifier{
  List<Cards> _allTodoList = [];
  List<Cards> get allTodoList => _allTodoList;
  List<Cards> get incompletedTodoList => _allTodoList.where((todo) => todo.is_done == false).toList();
  List<Cards> get completedTodoList => _allTodoList.where((todo) => todo.is_done == true).toList();
  List<Cards> get blueList => _allTodoList.where((todo) => todo.blue == true).toList();
  List<Cards> get redList => _allTodoList.where((todo) => todo.red == true).toList();
  List<Cards> get flaggList => _allTodoList.where((todo) => todo.flagg == true).toList();
  List<Cards> get purpleList => _allTodoList.where((todo) => todo.purple == true).toList();
  List<Cards> get orangeList => _allTodoList.where((todo) => todo.orange == true).toList();

  List<Cards> get shuffled_allTodoList=>_allTodoList;
  List<Cards> get shuffled_blueList => _allTodoList.where((todo) => todo.blue == true).toList();
  List<Cards> get shuffled_redList => _allTodoList.where((todo) => todo.red == true).toList();
  List<Cards> get shuffled_purpleList => _allTodoList.where((todo) => todo.purple == true).toList();
  List<Cards> get shuffled_orangeList => _allTodoList.where((todo) => todo.orange == true).toList();
  List<Cards> get shuffled_flaggList => _allTodoList.where((todo) => todo.flagg == true).toList();

  void shuffle_list(){
    shuffled_allTodoList.shuffle();
    shuffled_blueList.shuffle();
    shuffled_redList.shuffle();
    shuffled_flaggList.shuffle();
    shuffled_orangeList.shuffle();
    shuffled_purpleList.shuffle();

    notifyListeners();
  }






  final TodoRepository repo = TodoRepository();
  final translator = GoogleTranslator();
  CardsModel(){
    _fetchAll();
  }


  void _fetchAll() async {
    _allTodoList = await repo.getAllTodos();
    notifyListeners();
  }

  void add(Cards todo) async {
    await repo.insertTodo(todo);
    _fetchAll();
  }

  void update(Cards todo) async {
    await repo.updateTodo(todo);
    _fetchAll();
  }

  void toggleIsDone(Cards todo) async {
    todo.is_done = !todo.is_done;
    var translation = await translator
        .translate(todo.en_card_name, from: 'en', to: 'ja');
    todo.en_card_name=translation.toString();
    update(todo);
  }

  void remove(Cards todo) async {
    await repo.deleteTodoById(todo.id);
    _fetchAll();
  }

  void on_purple(Cards todo){
    todo.purple=!todo.purple;
    update(todo);
  }
  void on_orange(Cards todo){
    todo.orange=!todo.orange;
    update(todo);
  }
  void on_blue(Cards todo){
    todo.blue=!todo.blue;
    update(todo);
  }
  void on_red(Cards todo){
    todo.red=!todo.red;
    update(todo);
  }
  void on_flagg(Cards todo){
    todo.flagg=!todo.flagg;
    update(todo);
  }
  void f_refresh(Cards todo){
    todo.refresh=!todo.refresh;
    notifyListeners();
  }
  void all_refresh(Cards todo){
    todo.refresh=false;
    notifyListeners();
  }

}