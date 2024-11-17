import 'package:flutter/material.dart';
import 'student_dashboard.dart';

class StudentLoginPage extends StatefulWidget {
  @override
  _StudentLoginPageState createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  // Updated valid credentials list
  final Map<String, String> validCredentials = {
    'Emmanuel Nelson': '905004293',
    'Sarah Okikeh': '905001212',
    'John Cookson': '905001111',
    'John Nelson': '9050002222',
    'Samuel Hill': '905003333',
    'Luis Scott': '905004444',
    'Vandy Lee': '905005555',
    'Abu Turay': '905006666',
  };

  String errorMessage = '';

  void _login() {
    String name = _nameController.text.trim();
    String id = _idController.text.trim();

    if (validCredentials[name] == id) {
      // Navigate to Student Dashboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentDashboard(name: name)),
      );
    } else {
      // Display error message if credentials don't match
      setState(() {
        errorMessage = 'Invalid name or ID. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Login'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png', // Make sure this path is correct in pubspec.yaml
                  width: 150,
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true, // Mask the ID input
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _login,
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'select_user.dart';

// class StudentLoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Login'),
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/logo.png', // Make sure this path is correct in pubspec.yaml
//               width: 150,
//             ),
//             SizedBox(height: 30),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Username',
//                 labelStyle: TextStyle(color: Colors.black),
//                 filled: true,
//                 fillColor: Colors.black12,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'ID',
//                 labelStyle: TextStyle(color: Colors.black),
//                 filled: true,
//                 fillColor: Colors.black12,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               onPressed: () {
//                 // Add login logic here
//               },
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
