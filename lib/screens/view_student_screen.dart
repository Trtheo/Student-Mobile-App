import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../db/database_helper.dart';
import 'add_edit_student.dart';

class ViewStudentScreen extends StatelessWidget {
  final Student student;

  const ViewStudentScreen({super.key, required this.student});

  void confirmDelete(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete ${student.name}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete", style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper().deleteStudent(student.id!);
      Navigator.pop(context); // close view screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student deleted successfully")),
      );
    }
  }

  void openEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditStudentScreen(student: student),
      ),
    ).then((_) => Navigator.pop(context)); // pop after returning
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.indigo,
                    child: Text(student.name[0].toUpperCase(), style: const TextStyle(fontSize: 30, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Name: ${student.name}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text("Age: ${student.age}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text("Course: ${student.course}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => openEditScreen(context),
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => confirmDelete(context),
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
