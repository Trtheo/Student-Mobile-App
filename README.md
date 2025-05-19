# 📘 Student Record Management App (Flutter with Dart) programming language

A modern Flutter mobile application to manage student records with:

- 🔐 Login/Register using a Node.js backend API
- 💾 Local student data stored via SQLite
- 🌙 Dark mode toggle
- 👥 Multi-user support (records are tied to login email)
- ✨ Beautiful UI with bottom navigation and clean design

---

## 📱 Features

- ✅ User registration and login (via REST API)
- ✅ Secure session management with `SharedPreferences`
- ✅ SQLite CRUD (Create, Read, Update, Delete) for student records
- ✅ Scoped records per user (multi-profile)
- ✅ Dark mode support (persisted)
- ✅ Bottom navigation bar: Home, Student CRUD, Settings
- ✅ Search student by name
- ✅ View, edit, and delete student details with confirmation
- ✅ Responsive and adaptive UI design

---

## 🧱 Tech Stack

| Layer       | Tech                                 |
|-------------|--------------------------------------|
| Frontend    | Flutter (Dart)                       |
| Local DB    | SQLite using `sqflite` package       |
| Auth API    | Node.js + Express + SQLite (backend) |
| Storage     | SharedPreferences (token + settings) |

---

## 📦 Packages Used

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.6
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0
  path_provider: ^2.1.2
  provider: ^6.1.1
  path: ^1.8.3
```
 ## Setup Instructions
1. Clone the Repository 
```bash 
git clone https://github.com/Trtheo/Student-Mobile-App.git
```
2. Run Flutter App

```bash
flutter pub get
flutter run
```
**Make sure you have an Android emulator or physical device running.**

3. Start Node.js API (for login/register) in this path
 ```bash
student_record_app\student-auth-api
```
**run**  
```bash 
node server.js
```
**You will see this on terminal**
```bash
Server running on http://localhost:5000
```

#### Register API Example (Test in Postman or other Test tool)
##### POST   http://localhost:5000/api/login


```bash
{
  "name": "Theophile Niyigaba",
  "email": "theophile@gmail.com",
  "password": "secure123"
}
```

#### Login API Example

**POST    http://localhost:5000/api/login**
```bash
{
  "email": "theophile@gmail.com",
  "password": "secure123"
}
```


### 🙋‍♂️ Author
- Theophile Niyigaba
- Computer & Software Engineer
📧 niyigabatheo10@gmail.com
🌐 https://visittheo.vercel.app/