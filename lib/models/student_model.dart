/// A model class representing a student record.
class Student {
  final int? id;
  final String name;
  final int age;
  final String course;
  final String userEmail;

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.course,
    required this.userEmail,
  });

  /// Converts this Student object into a Map to store in SQLite.
Map<String, dynamic> toMap() {
  return {
    if (id != null) 'id': id as Object, // Cast to Object
    'name': name,
    'age': age,
    'course': course,
    'user_email': userEmail,
  };
}

  /// Creates a Student object from a Map retrieved from SQLite.
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      course: map['course'],
      userEmail: map['user_email'],
    );
  }
}
