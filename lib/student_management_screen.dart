import 'package:flutter/material.dart';

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
            // Add and Delete Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add student functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Add"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // General delete functionality if needed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Del"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
