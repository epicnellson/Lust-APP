// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class StudentDashboard extends StatefulWidget {
//   final String studentName; // Accept studentName as a parameter

//   const StudentDashboard({Key? key, required this.studentName})
//       : super(key: key);

//   @override
//   _StudentDashboardState createState() => _StudentDashboardState();
// }

// class _StudentDashboardState extends State<StudentDashboard> {
//   File? _profileImage;

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _profileImage = File(pickedFile.path);
//       });
//     }
//   }

//   void _showProfileOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               leading: Icon(Icons.upload),
//               title: Text('Upload New Profile'),
//               onTap: () {
//                 _pickImage();
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundImage:
//                   _profileImage != null ? FileImage(_profileImage!) : null,
//               child:
//                   _profileImage == null ? Icon(Icons.person, size: 20) : null,
//             ),
//             SizedBox(width: 10),
//             Text('Hello ${widget.studentName}!'),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.3),
//                 spreadRadius: 5,
//                 blurRadius: 10,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildButton(context, 'View Result'),
//               SizedBox(height: 20),
//               _buildButton(context, 'Report'),
//               SizedBox(height: 20),
//               _buildButton(context, 'Notification'),
//               SizedBox(height: 20),
//               _buildButton(context, 'Logout', isLogout: true),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(BuildContext context, String label,
//       {bool isLogout = false}) {
//     return ElevatedButton(
//       onPressed: () {
//         if (isLogout) {
//           Navigator.pop(context);
//         } else {
//           // Add your action for each button here
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       child: Text(label, style: TextStyle(color: Colors.white)),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:my_application/report.dart'; // Import the ReportScreen

class StudentDashboard extends StatefulWidget {
  final String studentName;

  const StudentDashboard({Key? key, required this.studentName})
      : super(key: key);

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.upload),
              title: Text('Upload New Profile'),
              onTap: () {
                _pickImage();
                Navigator.pop(context);
              },
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
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  _profileImage != null ? FileImage(_profileImage!) : null,
              child:
                  _profileImage == null ? Icon(Icons.person, size: 20) : null,
            ),
            SizedBox(width: 10),
            Text('Hello ${widget.studentName}!'),
          ],
        ),
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
              _buildButton(context, 'View Result'),
              SizedBox(height: 20),
              _buildButton(context, 'Report', onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportScreen(
                      studentName: widget.studentName, // Pass the student name
                    ),
                  ),
                );
              }),
              SizedBox(height: 20),
              _buildButton(context, 'Notification'),
              SizedBox(height: 20),
              _buildButton(context, 'Logout', isLogout: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label,
      {bool isLogout = false, VoidCallback? onTap}) {
    return ElevatedButton(
      onPressed: () {
        if (isLogout) {
          Navigator.pop(context);
        } else {
          if (onTap != null) onTap();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
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
