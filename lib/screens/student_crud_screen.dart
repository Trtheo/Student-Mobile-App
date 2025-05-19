import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/student_model.dart';
import '../utils/session_manager.dart';
import 'add_edit_student.dart';
import 'view_student_screen.dart';

class StudentCrudScreen extends StatefulWidget {
  const StudentCrudScreen({super.key});

  @override
  State<StudentCrudScreen> createState() => _StudentCrudScreenState();
}

class _StudentCrudScreenState extends State<StudentCrudScreen> {
  List<Student> students = [];
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
    loadData();
  }

  void loadData() async {
    if (userEmail == null) return;
    final data = await DatabaseHelper().getStudentsByUser(userEmail!);
    setState(() {
      students = data;
    });
  }

  void confirmDelete(Student student) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Delete ${student.name}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete", style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper().deleteStudent(student.id!);
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student deleted")),
      );
    }
  }

  void addStudent() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEditStudentScreen()),
    );
    if (result == true) loadData();
  }

  void editStudent(Student student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditStudentScreen(student: student)),
    );
    if (result == true) loadData();
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
      appBar: AppBar(title: const Text("Manage Students")),
      body: students.isEmpty
          ? const Center(child: Text("No students found."))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final s = students[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(s.name),
                    subtitle: Text("Age: ${s.age} | Course: ${s.course}"),
                    leading: const Icon(Icons.school),
                    onTap: () => viewStudent(s),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit, color: Colors.indigo), onPressed: () => editStudent(s)),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => confirmDelete(s)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addStudent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
