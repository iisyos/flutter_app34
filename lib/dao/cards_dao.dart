import 'package:flutter_app34/entity/entity.dart';
import "package:flutter_app34/service/service.dart";


class CardsDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = "cards";

  Future<int> create(Cards todo) async {
    final db = await dbProvider.database;
    var result = db.insert(tableName, todo.toDatabaseJson());
    return result;
  }

  Future<List<Cards>> getAll() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    List<Cards> todos = result.isNotEmpty
        ? result.map((item) => Cards.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  Future<int> update(Cards todo) async {
    final db = await dbProvider.database;
    var result = await db.update(tableName, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //not use this sample
  Future deleteAll() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      tableName,
    );

    return result;
  }

}