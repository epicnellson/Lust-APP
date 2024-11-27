// import 'package:flutter/material.dart';
// import 'admin_dashboard.dart';

// class AdminMessageScreen extends StatelessWidget {
//   final TextEditingController messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Send Message')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: messageController,
//               decoration: InputDecoration(labelText: 'Message'),
//               maxLines: 3,
//             ),
//             Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 // Code to send message to the database
//                 print('Message Sent: ${messageController.text}');
//               },
//               child: Text('Send'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'database_helper.dart';

class SendMessageScreen extends StatefulWidget {
  final String studentName;

  const SendMessageScreen({Key? key, required this.studentName})
      : super(key: key);

  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    String message = _messageController.text.trim();

    if (message.isNotEmpty) {
      await DatabaseHelper.instance.sendNotification(
        studentName: widget.studentName,
        message: message,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Message')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
