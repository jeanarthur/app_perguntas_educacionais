import 'dart:developer';

import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataService {

  Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();

    return await openDatabase(
      join(await getDatabasesPath(), 'quiz_book_sqlite.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE quiz_books(id INTEGER PRIMARY KEY, title TEXT, icon INTEGER, color INTEGER)');
      },
      version: 1
    );
  }

  Future<List<QuizBook>> getQuizBookList() async {
    final db = await database;

    final List<Map<String, Object?>> quizBookMaps = await db.query('quiz_books');

    return [
      for (final {'id': id as int, 'title': title as String, 'icon': icon as int, 'color': color as int}
          in quizBookMaps)
        QuizBook(id: id, title: title, icon: IconData(icon, fontFamily: 'MaterialIcons'), color: Color(color)),
    ];
  }

  Future<int?> createQuizBook(QuizBook quizBook) async {
    final db = await database;

    if (quizBook.id == -1) {
      var result = await db.query('quiz_books', columns: ['id'], orderBy: "id desc", limit: 1);
      if (result.isNotEmpty){
        int lastUsedId = result.first['id'] as int;
        quizBook.id = lastUsedId + 1;
      } else {
        quizBook.id = 0;
      }
    }

    log("[LocalDataService] [createQuizBook] creating ${quizBook.toString()}");
    try {
      await db.insert(
        'quiz_books',
        quizBook.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      log("[LocalDataService] [createQuizBook] created quiz book ${quizBook.title}");
      return quizBook.id;
    } on Exception catch (e) {
      log("[LocalDataService] [createQuizBook] error on create quiz book [$e]");
      return null;
    }
  }

  Future<int?> deleteQuizBook(int quizBookId) async {
    final db = await database;

    try {
      int rows = await db.delete(
        'quiz_books',
        where: 'id = ?',
        whereArgs: [quizBookId],
      );
      log("[LocalDataService] [deleteQuizBook] deleted quiz book [rows affected: $rows]");
      return rows;
    } on Exception catch (e) {
      log("[LocalDataService] [deleteQuizBook] error on delete quiz book [$e]");
      return null;
    }
  }
}