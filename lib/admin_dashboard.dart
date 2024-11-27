import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'result_entry.dart';
import 'student_management.dart';
import 'view_report.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  File? _profileImage;

  // Placeholder list of students
  List<Map<String, dynamic>> students = [
    {'student_id': 1, 'name': 'John Doe'},
    {'student_id': 2, 'name': 'Jane Smith'},
  ];

  // Function to pick an image for the profile
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  _profileImage != null ? FileImage(_profileImage!) : null,
              child: _profileImage == null
                  ? Icon(Icons.person, size: 20, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 10),
            Text('Hi Admin! Welcome'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildButton(context, 'Result Entry', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultEntryScreen()),
                );
              }),
              SizedBox(height: 20),
              _buildButton(context, 'Student Management', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentManagementScreen()),
                );
              }),
              SizedBox(height: 20),
              _buildButton(context, 'View Reports', () {
                if (students.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewReportPage(
                        studentId: students.first['student_id'],
                      ),
                    ),
                  );
                } else {
                  // Show a message if there are no students
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No students available to view reports!'),
                    ),
                  );
                }
              }),
              SizedBox(height: 20),
              _buildButton(context, 'Logout', () {
                Navigator.pop(context);
              }, isLogout: true),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build buttons
  Widget _buildButton(
      BuildContext context, String label, VoidCallback onPressed,
      {bool isLogout = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLogout ? Colors.red : Colors.black,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
