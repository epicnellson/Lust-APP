import 'package:flutter/material.dart';
import 'student_login.dart'; // Ensure this file exists and has StudentLoginPage
import 'admin_login.dart'; // Ensure this file exists and has AdminLoginPage

class SelectUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ensure this image exists and is added in pubspec.yaml
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image_not_supported,
                size: 150,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            _buildButton(
              context: context,
              label: 'Student',
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentLoginPage()),
                );
              },
            ),
            SizedBox(height: 20),
            _buildButton(
              context: context,
              label: 'Admin',
              color: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'student_login.dart'; // Import student login page
// import 'admin_login.dart'; // Import admin login page

// class SelectUserPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select User'),
//         backgroundColor: Colors.black,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/logo.png', // Ensure image is referenced in pubspec.yaml
//               width: 150,
//             ),
//             SizedBox(height: 30),
//             _buildButton(
//               context: context,
//               label: 'Student',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => StudentLoginPage()),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             _buildButton(
//               context: context,
//               label: 'Admin',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AdminLoginPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButton({
//     required BuildContext context,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30), // Rounded button
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//         textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         elevation: 5,
//       ),
//       onPressed: onPressed,
//       child: Text(label),
//     );
//   }
// }
