import 'dart:async';
import 'package:database_app/Employees.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

      join(await getDatabasesPath(), 'emp_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE employees(id INTEGER PRIMARY KEY,name TEXT , email TEXT)',
        );
      }, version: 1);

  Future<List<Employees>> EmployeesList() async {
    // Get the reference
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('employees');

    return List.generate(maps.length, (index) {
      return Employees(
          id: maps[index]['id'],
          name: maps[index]['name'],
          email: maps[index]['email']);
    });
  }

  print(await EmployeesList());

  Future<void> updateEmployees(Employees employees) async {
    final db = await database;

    await db.update(
      'employees',
      employees.toMap(),
      where: 'id =?',
      whereArgs: [employees.id],
    );
  }

  Future<void> deleteEmployees(int id) async {
    final db = await database;

    await db.delete(
      'employees',
      where: 'id =?',
      whereArgs: [id],
    );
  }

  Future<void> insertEmployee(Employees employees) async {
    final db = await database;

    await db.insert('employees', employees.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  var saiteja = Employees(id: 01, name: 'Saiteja', email: 'Saiteja.com');
  var mahesh = Employees(id: 02, name: 'Mahesh', email: 'Mahesh@gmail.com');
  var yesh = Employees(id: 03, name: 'yesh', email: 'yesh@gmail.com');
  var roshan = Employees(id: 04, name: 'roshan', email: 'roshan@gmail.com');
  var raja = Employees(id: 05, name: 'raja', email: 'raja@gmail.com');

  yesh = Employees(id: yesh.id + 8, name: yesh.name, email: yesh.email);

  await updateEmployees(yesh);

  await insertEmployee(saiteja);
  await insertEmployee(mahesh);
  await insertEmployee(yesh);
  await insertEmployee(roshan);
  await insertEmployee(raja);
}