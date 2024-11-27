// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('school_result.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }

//   Future<void> _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE students (
//         student_id INTEGER PRIMARY KEY AUTOINCREMENT,
//         username TEXT NOT NULL UNIQUE,
//         first_name TEXT NOT NULL,
//         last_name TEXT NOT NULL,
//         class TEXT NOT NULL
//       );
//     ''');

//     await db.execute('''
//       CREATE TABLE reports (
//         report_id INTEGER PRIMARY KEY AUTOINCREMENT,
//         student_id INTEGER NOT NULL,
//         report_content TEXT NOT NULL,
//         created_at TEXT NOT NULL,
//         FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
//       );
//     ''');

//     await db.execute('''
//       CREATE TABLE notifications (
//         notification_id INTEGER PRIMARY KEY AUTOINCREMENT,
//         student_id INTEGER NOT NULL,
//         notification_message TEXT NOT NULL,
//         date TEXT NOT NULL,
//         FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
//       );
//     ''');

//     await db.execute('''
//       CREATE TABLE results (
//         result_id INTEGER PRIMARY KEY AUTOINCREMENT,
//         student_id INTEGER NOT NULL,
//         score TEXT NOT NULL,
//         grade TEXT NOT NULL,
//         FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
//       );
//     ''');
//   }

//   // Add a new student
//   Future<int> addStudent({
//     required String username,
//     required String firstName,
//     required String lastName,
//     required String className,
//   }) async {
//     final db = await instance.database;
//     return await db.insert(
//       'students',
//       {
//         'username': username,
//         'first_name': firstName,
//         'last_name': lastName,
//         'class': className,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace, // Avoid duplicate entries
//     );
//   }

//   // Fetch all students
//   Future<List<Map<String, dynamic>>> getStudents() async {
//     final db = await instance.database;
//     return await db.query('students');
//   }

//   // Fetch a student by username
//   Future<Map<String, dynamic>?> getStudentByUsername(String username) async {
//     final db = await instance.database;
//     final result = await db.query(
//       'students',
//       where: 'username = ?',
//       whereArgs: [username],
//     );
//     return result.isNotEmpty ? result.first : null;
//   }

//   // Submit a report
//   Future<void> submitReport({
//     required String studentName,
//     required String reportContent,
//   }) async {
//     final db = await instance.database;

//     final student = await getStudentByUsername(studentName);
//     if (student != null) {
//       await db.insert('reports', {
//         'student_id': student['student_id'],
//         'report_content': reportContent,
//         'created_at': DateTime.now().toIso8601String(),
//       });
//     } else {
//       throw Exception('Student not found');
//     }
//   }

//   // Fetch reports for a student
//   Future<List<Map<String, dynamic>>> getReports(int studentId) async {
//     final db = await instance.database;
//     return await db.query(
//       'reports',
//       where: 'student_id = ?',
//       whereArgs: [studentId],
//       orderBy: 'created_at DESC',
//     );
//   }

//   // Add notification
//   Future<void> sendNotification({
//     required String studentName,
//     required String message,
//   }) async {
//     final db = await instance.database;

//     final student = await getStudentByUsername(studentName);
//     if (student != null) {
//       await db.insert('notifications', {
//         'student_id': student['student_id'],
//         'notification_message': message,
//         'date': DateTime.now().toIso8601String(),
//       });
//     } else {
//       throw Exception('Student not found');
//     }
//   }

//   // Fetch notifications for a student
//   Future<List<Map<String, dynamic>>> getNotifications(int studentId) async {
//     final db = await instance.database;
//     return await db.query(
//       'notifications',
//       where: 'student_id = ?',
//       whereArgs: [studentId],
//       orderBy: 'date DESC',
//     );
//   }

//   // Add a result
//   Future<void> uploadResult({
//     required String studentName,
//     required String score,
//     required String grade,
//   }) async {
//     final db = await instance.database;

//     final student = await getStudentByUsername(studentName);
//     if (student != null) {
//       await db.insert('results', {
//         'student_id': student['student_id'],
//         'score': score,
//         'grade': grade,
//       });
//     } else {
//       throw Exception('Student not found');
//     }
//   }

//   // Fetch results for a student
//   Future<List<Map<String, dynamic>>> getResults(int studentId) async {
//     final db = await instance.database;
//     return await db.query(
//       'results',
//       where: 'student_id = ?',
//       whereArgs: [studentId],
//     );
//   }

//   // Close the database
//   Future<void> close() async {
//     final db = await instance.database;
//     await db.close();
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('school_result.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        student_id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        class TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE reports (
        report_id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER NOT NULL,
        report_content TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE notifications (
        notification_id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER NOT NULL,
        notification_message TEXT NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE results (
        result_id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER NOT NULL,
        score TEXT NOT NULL,
        grade TEXT NOT NULL,
        FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
      );
    ''');
  }

  // Add a new student
  Future<int> addStudent({
    required String username,
    required String firstName,
    required String lastName,
    required String className,
  }) async {
    final db = await instance.database;
    return await db.insert(
      'students',
      {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'class': className,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all students
  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await instance.database;
    return await db.query('students');
  }

  // Fetch a student by username
  Future<Map<String, dynamic>?> getStudentByUsername(String username) async {
    final db = await instance.database;
    final result = await db.query(
      'students',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Fetch a student by ID
  Future<Map<String, dynamic>?> getStudentById(int studentId) async {
    final db = await instance.database;
    final result = await db.query(
      'students',
      where: 'student_id = ?',
      whereArgs: [studentId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Delete a student
  Future<void> deleteStudent(int studentId) async {
    final db = await instance.database;
    await db.delete(
      'students',
      where: 'student_id = ?',
      whereArgs: [studentId],
    );
  }

  // Update a student's details
  Future<void> updateStudent({
    required int studentId,
    required String username,
    required String firstName,
    required String lastName,
    required String className,
  }) async {
    final db = await instance.database;
    await db.update(
      'students',
      {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'class': className,
      },
      where: 'student_id = ?',
      whereArgs: [studentId],
    );
  }

  // Submit a report
  Future<void> submitReport({
    required String studentName,
    required String reportContent,
  }) async {
    final db = await instance.database;

    final student = await getStudentByUsername(studentName);
    if (student != null) {
      await db.insert('reports', {
        'student_id': student['student_id'],
        'report_content': reportContent,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      throw Exception('Student not found');
    }
  }

  // Fetch reports for a student
  Future<List<Map<String, dynamic>>> getReports(int studentId) async {
    final db = await instance.database;
    return await db.query(
      'reports',
      where: 'student_id = ?',
      whereArgs: [studentId],
      orderBy: 'created_at DESC',
    );
  }

  // Add notification
  Future<void> sendNotification({
    required String studentName,
    required String message,
  }) async {
    final db = await instance.database;

    final student = await getStudentByUsername(studentName);
    if (student != null) {
      await db.insert('notifications', {
        'student_id': student['student_id'],
        'notification_message': message,
        'date': DateTime.now().toIso8601String(),
      });
    } else {
      throw Exception('Student not found');
    }
  }

  // Fetch notifications for a student
  Future<List<Map<String, dynamic>>> getNotifications(int studentId) async {
    final db = await instance.database;
    return await db.query(
      'notifications',
      where: 'student_id = ?',
      whereArgs: [studentId],
      orderBy: 'date DESC',
    );
  }

  // Add a result
  Future<void> uploadResult({
    required String studentName,
    required String score,
    required String grade,
  }) async {
    final db = await instance.database;

    final student = await getStudentByUsername(studentName);
    if (student != null) {
      await db.insert('results', {
        'student_id': student['student_id'],
        'score': score,
        'grade': grade,
      });
    } else {
      throw Exception('Student not found');
    }
  }

  // Fetch results for a student
  Future<List<Map<String, dynamic>>> getResults(int studentId) async {
    final db = await instance.database;
    return await db.query(
      'results',
      where: 'student_id = ?',
      whereArgs: [studentId],
    );
  }

  // Close the database
  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
