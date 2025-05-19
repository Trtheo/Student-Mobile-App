# 📘 Student Record Management App with REST APIs (Flutter with Dart) programming language

A modern Flutter mobile application to manage student records with:

-  Login/Register/Forgot Password using a Node.js & Express backend API
-  Local student data stored via SQLite
-  Dark mode toggle
-  Multi-user support (records are tied to login email)
-  Beautiful UI with bottom navigation and clean design

---

##  Features

-  User registration , login and reset password (via REST API)
-  Secure session management with `SharedPreferences`
-  SQLite CRUD (Create, Read, Update, Delete) for student records
-  Scoped records per user (multi-profile)
-  Dark mode support (persisted)
-  Bottom navigation bar: Home, Student CRUD, Settings
-  Search student by name
-  View, edit, and delete student details with confirmation
-  Responsive and adaptive UI design
- Reset password when user forgot password and is already registered.

---

##  Tech Stack

| Layer       | Tech                                 |
|-------------|--------------------------------------|
| Frontend    | Flutter (Dart)                       |
| Local DB    | SQLite using `sqflite` package       |
| Auth API    | Node.js + Express + SQLite (backend) |
| Storage     | SharedPreferences (token + settings) |

---

##  Packages Used

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

#### Forgot Password API Example

**POST    http://localhost:5000/api/reset-password**

 ```bash
  {
  "email": "theophile@gmail.com",
  "password": "Secure8543222!#@"
}
 ```
**--------------------------------------------------------**
###  Author
- Theophile Niyigaba
- Computer & Software Engineer
📧 niyigabatheo10@gmail.com
🌐 https://visittheo.vercel.app/


## Here is the sample demo of this Mobile App.

### A. Mobile Screens
1. Splash Screen when app is open in 5 seconnd
  
  ![splash_screen](assets\Screens\SplashScreen.png)

2. Register Screen
  ![splash_screen](assets\Screens\RegisterScreen.png)

3. Login Screen

  ![splash_screen](assets\Screens\LoginScreen.png)

4. CRUD (Add, Edit , View ) Screen

  ![splash_screen](assets\Screens\AddDeleteEditScreen.png)

5. List of Students Screen

  ![splash_screen](assets\Screens\ListOfStudents.png)

6. Profile Settings Screen
 ![splash_screen](assets\Screens\ProfileSettingScreen.png)
 
 7. Reset Password Screen

 ![splash_screen](assets\Screens\ResetPassScreen.png)
 

## B. API Testing in Postman

1. Register API

![splash_screen](assets\API_Images\registerAPI.png)

2. Login API

![splash_screen](assets\API_Images\loginAPI.png)

3. Get All users Registered API

![splash_screen](assets\API_Images\getAllUsersAPI.png)
 
4. Reset Password API

![splash_screen](assets\API_Images\ResetPassAPI.png)


