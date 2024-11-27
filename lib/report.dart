// import 'package:flutter/material.dart';

// class ReportScreen extends StatelessWidget {
//   final TextEditingController reportController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey,
//         title: Text('Reports'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Make your Report/Issues',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: reportController,
//               maxLines: 8,
//               decoration: InputDecoration(
//                 hintText: 'Report.....',
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (reportController.text.isNotEmpty) {
//                     // Handle report submission logic here
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Report submitted successfully!'),
//                         backgroundColor: Colors.green,
//                       ),
//                     );
//                     reportController.clear();
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Please enter your report.'),
//                         backgroundColor: Colors.red,
//                       ),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       Colors.black, // Matches the black "Send" button
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text('Send', style: TextStyle(color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_application/database_helper.dart'; // Ensure the path is correct

class ReportScreen extends StatefulWidget {
  final String
      studentName; // The student's name passed from the login or dashboard screen

  const ReportScreen({Key? key, required this.studentName}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _reportController = TextEditingController();

  // Function to save the report to the database
  Future<void> _submitReport() async {
    String reportContent = _reportController.text.trim();

    if (reportContent.isNotEmpty) {
      try {
        // Save the report in the database
        await DatabaseHelper.instance.submitReport(
          studentName: widget.studentName,
          reportContent: reportContent,
        );

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report submitted successfully')),
        );

        // Clear the text field after submission
        _reportController.clear();
      } catch (e) {
        // Handle any errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting report: $e')),
        );
      }
    } else {
      // Show an error if the report is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a report')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Report'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _reportController,
              maxLines: 10, // Allow multiple lines for the report
              decoration: const InputDecoration(
                labelText: 'Write your report here',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReport,
              child: const Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}
