import 'package:flutter_app34/dao/cards_dao.dart';
import 'package:flutter_app34/entity/entity.dart';

class TodoRepository {
  final todoDao = CardsDao();

  Future getAllTodos() => todoDao.getAll();

  Future insertTodo(Cards todo) => todoDao.create(todo);

  Future updateTodo(Cards todo) => todoDao.update(todo);

  Future deleteTodoById(int id) => todoDao.delete(id);

  //not use this sample
  Future deleteAllTodos() => todoDao.deleteAll();
}
