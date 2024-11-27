import 'package:flutter/material.dart';

void main() {
  runApp(ResultEntryApp());
}

class ResultEntryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Result Entry',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: ResultEntryScreen(),
    );
  }
}

class ResultEntryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {'id': 1, 'name': 'John Nelson', 'course': 'BSEM', 'class': '1101'},
    {'id': 2, 'name': 'Samuel Hill', 'course': 'BSEM', 'class': '1102'},
    {'id': 3, 'name': 'Luis Scott', 'course': 'BSEM', 'class': '1103'},
    {'id': 4, 'name': 'Vandy Lee', 'course': 'BSEM', 'class': '1104'},
    {'id': 5, 'name': 'Abu Turay', 'course': 'BSEM', 'class': '1105'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Entry'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            title: Text(student['name']),
            subtitle: Text('ID: ${student['id']}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GradeEntryScreen(student: student),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GradeEntryScreen extends StatefulWidget {
  final Map<String, dynamic> student;

  GradeEntryScreen({required this.student});

  @override
  _GradeEntryScreenState createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
  final List<Map<String, dynamic>> modules = [
    {'module': 'OOP1', 'score': '', 'grade': ''},
    {'module': 'DATABASE', 'score': '', 'grade': ''},
    {'module': 'N/Economy', 'score': '', 'grade': ''},
    {'module': 'S/W Engin', 'score': '', 'grade': ''},
    {'module': 'Digital/IMG', 'score': '', 'grade': ''},
  ];

  void _uploadGrades() {
    // Logic to upload grades
    print("Grades Uploaded:");
    for (var module in modules) {
      print(
          "Module: ${module['module']}, Score: ${module['score']}, Grade: ${module['grade']}");
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Grades uploaded successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.student['name']}'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Course: ${widget.student['course']}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Class: ${widget.student['class']}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  final module = modules[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(module['module'])),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              decoration: InputDecoration(hintText: 'Score'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                module['score'] = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              decoration: InputDecoration(hintText: 'Grade'),
                              onChanged: (value) {
                                module['grade'] = value;
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              print(
                                  'Module: ${module['module']}, Score: ${module['score']}, Grade: ${module['grade']}');
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadGrades,
              child: Text('Upload Grades'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
