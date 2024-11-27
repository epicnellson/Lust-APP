// import 'package:flutter/material.dart';
// import 'package:my_application/notification_upload.dart';

// class ViewReportsScreen extends StatelessWidget {
//   final List<Map<String, String>> reports = [
//     {'name': 'John Nelson', 'report': 'I have a Missen Grade'},
//     {'name': 'Vandy Lee', 'report': 'You Made A Mistake'},
//     {
//       'name': 'Abu Turay',
//       'report': 'Sir.. You didn’t add the 15 marks you promised.'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reports'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.message),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => NotificationUploadScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: reports.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               title: Text(reports[index]['name']!),
//               subtitle: Text(reports[index]['report']!),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'database_helper.dart';

// class ViewReportPage extends StatefulWidget {
//   final int studentId;

//   ViewReportPage({required this.studentId});

//   @override
//   _ViewReportPageState createState() => _ViewReportPageState();
// }

// class _ViewReportPageState extends State<ViewReportPage> {
//   late Future<List<Map<String, dynamic>>> reports;

//   @override
//   void initState() {
//     super.initState();
//     _loadReports();
//   }

//   // Load student's reports
//   void _loadReports() async {
//     final reportsData = await DatabaseHelper.instance.getReports(widget.studentId);
//     setState(() {
//       reports = Future.value(reportsData);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("View Reports")),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: reports,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error loading reports'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No reports available'));
//           } else {
//             final reportsData = snapshot.data!;
//             return ListView.builder(
//               itemCount: reportsData.length,
//               itemBuilder: (context, index) {
//                 final report = reportsData[index];
//                 return ListTile(
//                   title: Text(report['report_content']),
//                   subtitle: Text('Submitted on: ${report['created_at']}'),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'database_helper.dart';

class ViewReportPage extends StatefulWidget {
  final int studentId;

  ViewReportPage({required this.studentId});

  @override
  _ViewReportPageState createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
  late Future<List<Map<String, dynamic>>> reports;

  @override
  void initState() {
    super.initState();
    reports = _loadReports();
  }

  // Load student's reports
  Future<List<Map<String, dynamic>>> _loadReports() async {
    return await DatabaseHelper.instance.getReports(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Reports'),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: reports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading reports'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No reports available'));
          } else {
            final reportsData = snapshot.data!;
            return ListView.builder(
              itemCount: reportsData.length,
              itemBuilder: (context, index) {
                final report = reportsData[index];
                return ListTile(
                  title: Text(report['report_content']),
                  subtitle: Text('Submitted on: ${report['created_at']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
