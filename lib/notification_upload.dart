// import 'package:flutter/material.dart';

// class NotificationUploadScreen extends StatefulWidget {
//   @override
//   _NotificationUploadScreenState createState() =>
//       _NotificationUploadScreenState();
// }

// class _NotificationUploadScreenState extends State<NotificationUploadScreen> {
//   final TextEditingController notificationController = TextEditingController();

//   void uploadNotification() {
//     String notification = notificationController.text.trim();
//     if (notification.isNotEmpty) {
//       // Logic to save/upload notification (e.g., to a database)
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Notification uploaded successfully!')),
//       );
//       notificationController.clear();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text('Please enter a notification before uploading.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Notification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: notificationController,
//               maxLines: 5,
//               decoration: InputDecoration(
//                 hintText: 'Enter your notification here',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: uploadNotification,
//               child: Text('Upload Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:my_application/database.dart';

// class NotificationScreen extends StatefulWidget {
//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   List<Map<String, String>> notifications = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }

//   _loadNotifications() async {
//     notifications =
//         await DatabaseHelper.instance.getNotifications(); // Fetch notifications
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: ListView.builder(
//         itemCount: notifications.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text(notifications[index]["message"]!),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'database_helper.dart';

class NotificationScreen extends StatelessWidget {
  final String studentUsername;

  const NotificationScreen({Key? key, required this.studentUsername})
      : super(key: key);

  Future<List<Map<String, dynamic>>> _loadNotifications() async {
    final student =
        await DatabaseHelper.instance.getStudentByUsername(studentUsername);
    if (student != null) {
      return await DatabaseHelper.instance
          .getNotifications(student['student_id'] as int);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading notifications.'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available.'));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notificationMessage =
                  notifications[index]['notification_message'] as String?;
              final date = notifications[index]['date'] as String?;
              return ListTile(
                title: Text(notificationMessage ?? 'No message'),
                subtitle: Text('Date: ${date ?? 'Unknown date'}'),
              );
            },
          );
        },
      ),
    );
  }
}
