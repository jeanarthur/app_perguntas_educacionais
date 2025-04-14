import 'dart:developer';

import 'package:app_perguntas_educacionais/domain/models/question/question.dart';
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

  Future<int?> updateQuizBook(QuizBook quizBook) async {
    final db = await database;

    log("[LocalDataService] [updateQuizBook] updating ${quizBook.toString()}");
    try {
      int rows = await db.update(
        'quiz_books',
        quizBook.toMap(),
        where: 'id = ?',
        whereArgs: [quizBook.id],
      );
      log("[LocalDataService] [updateQuizBook] updated quiz book [rows affected: $rows]");
      return quizBook.id;
    } on Exception catch (e) {
      log("[LocalDataService] [updateQuizBook] error on update quiz book [$e]");
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

  Future<Database> get questionDatabase async {
    WidgetsFlutterBinding.ensureInitialized();

    return await openDatabase(
      join(await getDatabasesPath(), 'question_sqlite.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE questions(id INTEGER PRIMARY KEY, quizBookId INTEGRE, title TEXT, options TEXT, correctOptionIndex INTEGER)');
      },
      version: 1
    );
  }

  Future<List<Question>> getQuestionList(int quizBookId) async {
    final db = await questionDatabase;

    final List<Map<String, Object?>> questionMaps = await db.query('questions', where: 'quizBookId = ?', whereArgs: [quizBookId]);

    return [
      for (final {'id': id as int, 'quizBookId': quizBookId as int, 'title': title as String, 'options': options as String, 'correctOptionIndex': correctOptionIndex as int}
          in questionMaps)
        Question(id: id, quizBookId: quizBookId, title: title, options: options.split("<endOption>"), correctOptionIndex: correctOptionIndex),
    ];
  }

  Future<int?> createQuestion(Question question) async {
    final db = await questionDatabase;

    if (question.id == -1) {
      var result = await db.query('questions', columns: ['id'], orderBy: "id desc", limit: 1);
      if (result.isNotEmpty){
        int lastUsedId = result.first['id'] as int;
        question.id = lastUsedId + 1;
      } else {
        question.id = 0;
      }
    }

    log("[LocalDataService] [createQuestion] creating ${question.toString()}");
    try {
      await db.insert(
        'questions',
        question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      log("[LocalDataService] [createQuestion] created question ${question.title}");
      return question.id;
    } on Exception catch (e) {
      log("[LocalDataService] [createQuestion] error on create question [$e]");
      return null;
    }
  }

  Future<int?> updateQuestion(Question question) async {
    final db = await questionDatabase;

    log("[LocalDataService] [updateQuestion] updating ${question.toString()}");
    try {
      int rows = await db.update(
        'questions',
        question.toMap(),
        where: 'id = ?',
        whereArgs: [question.id],
      );
      log("[LocalDataService] [updateQuestion] updated question [rows affected: $rows]");
      return question.id;
    } on Exception catch (e) {
      log("[LocalDataService] [updateQuestion] error on update question [$e]");
      return null;
    }
  }

  Future<int?> deleteQuestion(int questionId) async {
    final db = await questionDatabase;

    try {
      int rows = await db.delete(
        'questions',
        where: 'id = ?',
        whereArgs: [questionId],
      );
      log("[LocalDataService] [deleteQuestion] deleted question [rows affected: $rows]");
      return rows;
    } on Exception catch (e) {
      log("[LocalDataService] [deleteQuestion] error on delete question [$e]");
      return null;
    }
  }

}