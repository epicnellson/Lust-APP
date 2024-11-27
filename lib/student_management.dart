// import 'package:flutter/material.dart';
// import 'package:my_application/add_student.dart';
// import 'add_student.dart';

// class StudentManagementScreen extends StatefulWidget {
//   @override
//   _StudentManagementScreenState createState() =>
//       _StudentManagementScreenState();
// }

// class _StudentManagementScreenState extends State<StudentManagementScreen> {
//   List<Map<String, String>> students = [
//     {"ID": "1", "Name": "John Nelson", "Class": "BSEM"},
//     {"ID": "2", "Name": "Samuel Hill", "Class": "BSEM"},
//     {"ID": "3", "Name": "Luis Scott", "Class": "BSEM"},
//     {"ID": "4", "Name": "Vandy Lee", "Class": "BSEM"},
//     {"ID": "5", "Name": "Abu Turay", "Class": "BSEM"},
//   ];
//   String searchQuery = "";

//   void _deleteStudent(String id) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Deletion"),
//           content: Text("Are you sure you want to delete this student?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   students.removeWhere((student) => student["ID"] == id);
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: Text("Yes"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("No"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _addStudent(Map<String, String> newStudent) {
//     setState(() {
//       students.add({
//         "ID": (students.length + 1).toString(), // Auto-generate ID
//         "Name": newStudent["fullName"]!,
//         "Class": newStudent["class"]!,
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey,
//         title: Text("Manage Students"),
//         leading: IconButton(
//           icon: Icon(Icons.menu),
//           onPressed: () {
//             // Navigate to profile or other menu options
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Search Bar
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   searchQuery = value.toLowerCase();
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Here you can add, remove, and search for students",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             // Students Table
//             Expanded(
//               child: ListView(
//                 children: students
//                     .where((student) =>
//                         student["Name"]!.toLowerCase().contains(searchQuery))
//                     .map((student) => Card(
//                           child: ListTile(
//                             leading: Text(student["ID"]!),
//                             title: Text(student["Name"]!),
//                             subtitle: Text(student["Class"]!),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 TextButton(
//                                   onPressed: () {
//                                     // Add edit functionality here
//                                   },
//                                   child: Text("Edit"),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () =>
//                                       _deleteStudent(student["ID"]!),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//             // Add Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AddStudentScreen(
//                           onAddStudent: _addStudent,
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text("Add Student"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:my_application/database_helper.dart'; // Database helper

// class StudentManagementScreen extends StatefulWidget {
//   @override
//   _StudentManagementScreenState createState() =>
//       _StudentManagementScreenState();
// }

// class _StudentManagementScreenState extends State<StudentManagementScreen> {
//   final TextEditingController _studentNameController = TextEditingController();
//   final TextEditingController _studentIdController = TextEditingController();
//   final TextEditingController _studentClassController = TextEditingController();

//   List<Map<String, dynamic>> students = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadStudents();
//   }

//   _loadStudents() async {
//     students = await DatabaseHelper.instance.getStudents();
//     setState(() {});
//   }

//   _addStudent(Map<String, String> studentData) async {
//     await DatabaseHelper.instance.addStudent(
//       username: studentData['ID']!,
//       firstName: studentData['firstName']!,
//       lastName: studentData['lastName']!,
//       className: studentData['class']!,
//     );
//     _loadStudents(); // Reload the student list
//   }

//   _deleteStudent(int studentId) async {
//     bool confirmDelete = await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Delete Student'),
//           content: Text('Are you sure you want to delete this student?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//     if (confirmDelete) {
//       await DatabaseHelper.instance.deleteStudent(studentId);
//       _loadStudents(); // Reload the student list after deletion
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Management'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _studentNameController,
//               decoration: InputDecoration(labelText: 'Student Name'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _studentIdController,
//               decoration: InputDecoration(labelText: 'Student ID'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _studentClassController,
//               decoration: InputDecoration(labelText: 'Student Class'),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_studentNameController.text.isNotEmpty &&
//                   _studentIdController.text.isNotEmpty &&
//                   _studentClassController.text.isNotEmpty) {
//                 _addStudent({
//                   'firstName': _studentNameController.text,
//                   'lastName': '',
//                   'ID': _studentIdController.text,
//                   'class': _studentClassController.text,
//                 });
//               }
//             },
//             child: Text('Add Student'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: students.length,
//               itemBuilder: (context, index) {
//                 var student = students[index];
//                 return ListTile(
//                   title: Text(student['first_name']),
//                   subtitle: Text(student['class']),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () => _deleteStudent(student['student_id']),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'add_student.dart';

class StudentManagementScreen extends StatefulWidget {
  @override
  _StudentManagementScreenState createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  List<Map<String, String>> students = [
    {"ID": "9050002222", "Name": "John Nelson", "Class": "BSEM"},
    {"ID": "905003333", "Name": "Samuel Hill", "Class": "BSEM"},
    {"ID": "905004444", "Name": "Luis Scott", "Class": "BSEM"},
    {"ID": "905005555", "Name": "Vandy Lee", "Class": "BSEM"},
    {"ID": "905006666", "Name": "Abu Turay", "Class": "BSEM"},
    {"ID": "905004293", "Name": "Emmanuel Nelson", "Class": "BSEM"},
    {"ID": "905001212", "Name": "Sarah Okikeh", "Class": "BSEM"},
    {"ID": "905001111", "Name": "John Cookson", "Class": "BSEM"},
  ];

  String searchQuery = "";

  void _deleteStudent(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this student?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  students.removeWhere((student) => student["ID"] == id);
                });
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  void _addStudent(Map<String, String> newStudent) {
    setState(() {
      students.add({
        "ID": newStudent['ID']!,
        "Name": "${newStudent['firstName']} ${newStudent['lastName']}",
        "Class": newStudent['class']!,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Manage Students"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Navigate to profile or other menu options
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              "Here you can add, remove, and search for students",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // Students Table
            Expanded(
              child: ListView(
                children: students
                    .where((student) =>
                        student["Name"]!.toLowerCase().contains(searchQuery))
                    .map((student) => Card(
                          child: ListTile(
                            leading: Text(student["ID"]!),
                            title: Text(student["Name"]!),
                            subtitle: Text(student["Class"]!),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Add edit functionality here
                                  },
                                  child: Text("Edit"),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () =>
                                      _deleteStudent(student["ID"]!),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            // Add Button
            ElevatedButton(
              onPressed: () {
                // Navigate to AddStudentScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentScreen(
                      onAddStudent: (newStudent) => _addStudent(newStudent),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
