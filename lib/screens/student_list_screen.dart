import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/student_model.dart';
import '../utils/session_manager.dart';
import 'view_student_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
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
    setState(() => userEmail = email);
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

  void viewStudent(Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ViewStudentScreen(student: student)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Students")),
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
                ? const Center(child: Text("No students found."))
                : ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final s = filteredStudents[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          title: Text(s.name),
                          subtitle: Text("Age: ${s.age}, Course: ${s.course}"),
                          leading: const Icon(Icons.person, color: Colors.indigo),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => viewStudent(s),
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
