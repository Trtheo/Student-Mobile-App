import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/student_model.dart';
import '../utils/session_manager.dart';
import 'view_student_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Student> allStudents = [];
  List<Student> filteredStudents = [];
  String? userEmail;

  @override
  void initState() {
    super.initState();
    loadUserAndData();
  }

  void loadUserAndData() async {
    final email = await SessionManager.getEmail();
    if (email == null) return;
    setState(() {
      userEmail = email;
    });
    loadStudents();
  }

  void loadStudents() async {
    if (userEmail == null) return;
    final data = await DatabaseHelper().getStudentsByUser(userEmail!);
    setState(() {
      allStudents = data;
      filteredStudents = data;
    });
  }

  void filterSearch(String query) {
    final results = allStudents
        .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredStudents = results;
    });
  }

  void openStudentDetails(Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ViewStudentScreen(student: student)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: filterSearch,
            ),
          ),
          Expanded(
            child: filteredStudents.isEmpty
                ? const Center(child: Text('No students found.'))
                : ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          title: Text(student.name),
                          subtitle: Text("Age: ${student.age}, Course: ${student.course}"),
                          leading: const Icon(Icons.person, color: Colors.deepOrange),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => openStudentDetails(student),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
