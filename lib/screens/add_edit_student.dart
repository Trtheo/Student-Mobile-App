import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../db/database_helper.dart';
import '../utils/session_manager.dart';

class AddEditStudentScreen extends StatefulWidget {
  final Student? student;

  const AddEditStudentScreen({super.key, this.student});

  @override
  State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age.toString();
      courseController.text = widget.student!.course;
    }
  }

  void handleSave() async {
  final name = nameController.text.trim();
  final ageText = ageController.text.trim();
  final course = courseController.text.trim();

  if (name.isEmpty || ageText.isEmpty || course.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("All fields are required")),
    );
    return;
  }

  final age = int.tryParse(ageText);
  if (age == null || age <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter a valid age")),
    );
    return;
  }

  final userEmail = await SessionManager.getEmail();
  if (userEmail == null) return;

  final student = Student(
    id: widget.student?.id,
    name: name,
    age: age,
    course: course,
    userEmail: userEmail,
  );

  if (widget.student == null) {
    await DatabaseHelper().insertStudent(student);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student added successfully")),
    );
  } else {
    await DatabaseHelper().updateStudent(student);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student updated successfully")),
    );
  }

  Navigator.pop(context, true); // return true so the list screen reloads
}

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Student" : "Add Student")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Age"),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: courseController,
                  decoration: const InputDecoration(labelText: "Course"),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: handleSave,
                  icon: const Icon(Icons.save),
                  label: Text(isEditing ? "Update Student" : "Add Student"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
