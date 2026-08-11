# 👥 Employee Management App — Flutter

A full-stack Flutter application demonstrating **mobile UI development, local database management, REST API integration, authentication, form validation, and backend development**.

The project consists of a Flutter client application and a Node.js/Express backend. The Flutter application contains reusable UI components, models, services, views, form validation, state management, and local SQLite persistence. The backend provides authentication endpoints backed by PostgreSQL.

---

## 🚀 Project Overview

This project was developed to explore how a Flutter application can communicate with a backend API while also maintaining local application data.

The project is structured into two main parts:

```text
Employee_management_flutter/
│
├── crud_flutter_todo/        # Flutter application
│
└── flutter_todo_backend/     # Node.js backend API
```

### Frontend

The Flutter application uses:

* Dart
* Flutter
* Riverpod
* SQLite
* HTTP
* Form validation
* Reusable custom widgets
* Material UI components

### Backend

The backend uses:

* Node.js
* Express.js
* PostgreSQL
* JWT
* bcrypt
* REST-style API endpoints

The current repository therefore demonstrates both **mobile frontend development and backend/API concepts**.

---

# 🛠️ Tech Stack

## Frontend

| Technology               | Purpose                     |
| ------------------------ | --------------------------- |
| **Flutter**              | Cross-platform mobile UI    |
| **Dart**                 | Application development     |
| **Riverpod**             | State management            |
| **SQLite / sqflite**     | Local data persistence      |
| **HTTP**                 | API communication           |
| **Form Field Validator** | Input validation            |
| **Material Text Fields** | Reusable form controls      |
| **Heatmap Calendar**     | Calendar/data visualization |
| **Cupertino Icons**      | UI icons                    |

The Flutter project's `pubspec.yaml` currently defines these dependencies, including `flutter_riverpod`, `sqflite`, `http`, `form_field_validator`, `material_text_fields`, and `flutter_heatmap_calendar`.

## Backend

| Technology       | Purpose             |
| ---------------- | ------------------- |
| **Node.js**      | Backend runtime     |
| **Express.js**   | HTTP server/API     |
| **PostgreSQL**   | Relational database |
| **pg**           | PostgreSQL client   |
| **bcryptjs**     | Password hashing    |
| **jsonwebtoken** | JWT authentication  |

The backend's `package.json` confirms Express, PostgreSQL (`pg`), bcryptjs, and jsonwebtoken as dependencies.

---

# 🏗️ Architecture

The project follows a basic layered architecture:

```text
                    Flutter Application
                           │
                           ▼
                    ┌──────────────┐
                    │     Views    │
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │    Widgets   │
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │    Models    │
                    └──────┬───────┘
                           │
              ┌────────────┴────────────┐
              │                         │
              ▼                         ▼
       Database Service            HTTP/API Layer
              │                         │
              ▼                         ▼
          SQLite DB              Node.js / Express
                                        │
                                        ▼
                                   PostgreSQL
```

The Flutter `lib` directory is separated into `models`, `services`, and `views`, providing a clear separation between data models, data access, and UI.

---

# 📁 Project Structure

```text
Employee_management_flutter/
│
├── crud_flutter_todo/
│   │
│   ├── Assets/
│   │   └── Logos/
│   │
│   ├── android/
│   ├── ios/
│   ├── linux/
│   ├── macos/
│   ├── web/
│   ├── windows/
│   │
│   ├── lib/
│   │   ├── models/
│   │   │   └── task.dart
│   │   │
│   │   ├── services/
│   │   │   └── database_service.dart
│   │   │
│   │   ├── views/
│   │   │   ├── home/
│   │   │   ├── login/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   │
│   │   ├── main.dart
│   │   └── user.dart
│   │
│   ├── test/
│   ├── pubspec.yaml
│   └── analysis_options.yaml
│
└── flutter_todo_backend/
    ├── database.js
    ├── server.js
    ├── testdb.js
    ├── package.json
    └── package-lock.json
```

The repository currently contains separate Flutter and Node.js projects.

---

# ⚛️ Flutter Architecture

## Models

The application contains dedicated model classes for representing application data.

For example:

```text
lib/
└── models/
    └── task.dart
```

Models provide a structured representation of data that can be passed between the UI and services.

This keeps the data representation separate from UI implementation.

---

# 🗄️ SQLite Database Layer

The project uses the `sqflite` package to provide local SQLite persistence.

The database service follows a singleton-style approach:

```dart
class DatabaseService {
  static Database? _db;

  static final DatabaseService instance =
      DatabaseService._constructor();

  DatabaseService._constructor();
}
```

This ensures that the application reuses a shared database service rather than repeatedly creating separate service instances.

The database is created using:

```text
master_db.db
```

and currently defines a `tasks` table containing:

```text
id
content
status
```

The database service provides operations for:

* Creating the database
* Creating tables
* Adding records
* Reading records
* Updating record status
* Deleting records

The implementation uses parameterised SQLite queries for update/delete conditions through `whereArgs`.

---

# 🔄 CRUD Operations

The local database layer demonstrates the core CRUD operations.

### Create

```dart
db.insert(...)
```

Used to add new records.

### Read

```dart
db.query(...)
```

Used to retrieve records from SQLite.

### Update

```dart
db.update(...)
```

Used to modify record status.

### Delete

```dart
db.delete(...)
```

Used to remove records.

This creates a complete local CRUD data flow:

```text
UI
 │
 ▼
DatabaseService
 │
 ├── INSERT
 ├── SELECT
 ├── UPDATE
 └── DELETE
 │
 ▼
SQLite
```

The `DatabaseService` implements these operations in the Flutter application.

---

# 🔐 Authentication Architecture

The backend implements authentication using:

* Password hashing with `bcryptjs`
* JSON Web Tokens
* PostgreSQL user storage

The authentication flow is:

```text
Flutter App
     │
     │ POST /register
     ▼
Express API
     │
     │ bcrypt.hash()
     ▼
PostgreSQL
```

For login:

```text
Flutter App
     │
     │ POST /login
     ▼
Express API
     │
     ├── Find user
     ├── bcrypt.compare()
     └── Generate JWT
             │
             ▼
          Flutter
```

The backend implements `/register`, `/login`, and `/profile` endpoints.

---

# 🔑 Password Security

Passwords are not stored directly in plaintext.

During registration, the backend hashes the password using bcrypt:

```javascript
const hashedPassword =
    await bcrypt.hash(password, 10);
```

The hashed password is then stored in PostgreSQL.

During login, the supplied password is compared against the stored hash:

```javascript
const isMatch =
    await bcrypt.compare(
        password,
        user.password
    );
```

This demonstrates the basic principle of **secure password storage using one-way password hashing**.

---

# 🎫 JWT Authentication

After successful authentication, the backend generates a JSON Web Token:

```javascript
const token = jwt.sign(
  {
    userId: user.id,
    email: user.email
  },
  JWT_SECRET,
  {
    expiresIn: '1h'
  }
);
```

The token contains basic user information and has a one-hour expiration.

The `/profile` endpoint reads the token from the request's `Authorization` header and verifies it using the JWT secret.

```text
Authorization: Bearer <token>
```

This demonstrates token-based authentication between a mobile client and backend API.

---

# 🌐 REST API

The Node.js backend is implemented using Express.

Current endpoints include:

| Method | Endpoint    | Purpose                                    |
| ------ | ----------- | ------------------------------------------ |
| `POST` | `/register` | Create a user                              |
| `POST` | `/login`    | Authenticate a user                        |
| `GET`  | `/profile`  | Validate JWT and retrieve user information |

The Express server listens on port `3000`.

---

# 🐘 PostgreSQL Integration

The backend communicates with PostgreSQL through the `pg` package.

Database operations use parameterised queries:

```javascript
await pool.query(
  'SELECT * FROM users WHERE email = $1',
  [email]
);
```

Using parameters instead of directly concatenating user input helps prevent SQL injection vulnerabilities.

The backend separates database connectivity into:

```text
flutter_todo_backend/
├── database.js
└── server.js
```

The `database.js` module provides the database connection used by the Express server.

---

# 📱 UI & Reusable Components

The Flutter application separates UI into views and reusable widgets.

```text
views/
├── home/
├── login/
├── pages/
└── widgets/
```

This structure helps prevent large UI files and allows common controls to be reused across multiple screens.

The project also uses the `material_text_fields` package to build customised form fields and `form_field_validator` for validation.

---

# 🧠 State Management

The project includes **Riverpod** for application state management.

```text
flutter_riverpod
```

Riverpod provides a scalable way to expose and consume application state without tightly coupling widgets to the underlying business logic.

This allows the application to evolve from local widget state toward shared application state as additional features are introduced.

---

# 📝 Form Validation

The application uses:

```text
form_field_validator
```

for handling form validation.

This allows validation logic to be separated from the UI and provides a consistent approach for checking user input before submitting data.

Examples of validation that can be applied include:

* Required fields
* Email format
* Password requirements
* Input length
* Invalid values

---

# 🔌 API Communication

The Flutter application includes the `http` package:

```yaml
http: ^1.6.0
```

This provides the foundation for communicating with the Node.js REST API.

The intended architecture is:

```text
Flutter
   │
   │ HTTP Request
   ▼
Express API
   │
   ▼
PostgreSQL
```

This separates the mobile UI from backend data storage and allows the application to evolve toward a full client-server architecture.

---

# 📅 Calendar & Data Visualisation

The Flutter application includes:

```text
flutter_heatmap_calendar
```

which can be used to represent activity over time using a heatmap-style calendar.

This provides a foundation for visualising employee-related activity such as:

* Attendance
* Daily activity
* Working days
* Task completion
* Productivity

The dependency is currently included in the project's Flutter configuration.

---

# 🔄 End-to-End Data Flow

A typical authenticated application flow can be represented as:

```text
┌─────────────────────┐
│     Flutter UI      │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│   Form Validation   │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ HTTP / API Request  │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  Express Backend    │
└──────────┬──────────┘
           │
      ┌────┴─────┐
      ▼          ▼
   bcrypt      JWT
      │          │
      └────┬─────┘
           ▼
┌─────────────────────┐
│    PostgreSQL      │
└─────────────────────┘
```

For local application data:

```text
Flutter UI
    │
    ▼
DatabaseService
    │
    ▼
SQLite
```

This project therefore demonstrates both **remote API-based data handling and local persistence**.

---

# 🚀 Getting Started

## Prerequisites

Install:

* Flutter SDK
* Dart SDK
* Node.js
* npm
* PostgreSQL
* Android Studio or VS Code
* Android/iOS emulator or physical device

---

## 1. Clone the Repository

```bash
git clone https://github.com/shrudh14007/Employee_management_flutter.git
```

```bash
cd Employee_management_flutter
```

---

# 📱 Running the Flutter Application

Navigate to the Flutter project:

```bash
cd crud_flutter_todo
```

Install Flutter dependencies:

```bash
flutter pub get
```

Check connected devices:

```bash
flutter devices
```

Run the application:

```bash
flutter run
```

For static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

---

# 🖥️ Running the Backend

Open another terminal:

```bash
cd flutter_todo_backend
```

Install Node.js dependencies:

```bash
npm install
```

Configure PostgreSQL in the backend database configuration.

Then start the server:

```bash
node server.js
```

The API runs on:

```text
http://localhost:3000
```

The backend's Express application currently listens on port `3000`.

---

# 🔐 Authentication Flow

### Registration

```http
POST /register
Content-Type: application/json
```

Example:

```json
{
  "email": "user@example.com",
  "password": "password"
}
```

### Login

```http
POST /login
Content-Type: application/json
```

Example:

```json
{
  "email": "user@example.com",
  "password": "password"
}
```

Successful authentication returns a JWT.

### Profile

```http
GET /profile
Authorization: Bearer <JWT_TOKEN>
```

The server validates the token before returning the decoded user information.

---

# 🧪 Technical Concepts Demonstrated

This project demonstrates practical experience with:

### Flutter

* Flutter application development
* Dart
* Stateful and stateless widgets
* Widget composition
* Reusable components
* Form handling
* Input validation
* Navigation
* State management
* Riverpod
* HTTP requests
* Local SQLite persistence
* CRUD operations
* Cross-platform project configuration

### Backend

* Node.js
* Express.js
* REST API development
* PostgreSQL
* SQL queries
* Database connection pooling
* Password hashing
* JWT authentication
* Authentication middleware concepts
* HTTP status codes
* JSON request/response handling

### Software Engineering

* Separation of concerns
* Service layer
* Model layer
* UI layer
* Client-server architecture
* Local vs remote persistence
* Error handling
* Input validation
* Secure password storage
* Parameterised SQL queries

---

# 🔮 Future Improvements

The project can be extended into a more complete employee management system.

## Employee CRUD

```text
POST   /employees
GET    /employees
GET    /employees/:id
PUT    /employees/:id
DELETE /employees/:id
```

## Additional Employee Features

* Employee profiles
* Department management
* Job roles
* Salary information
* Joining dates
* Leaving dates
* Attendance
* Leave management
* Employee search
* Filtering
* Sorting
* Employee statistics

## Authentication Improvements

* Refresh tokens
* Role-based access control
* Admin/user permissions
* Secure environment variables
* Authentication middleware
* Password reset
* Email verification

## Database Improvements

* Database migrations
* Foreign key relationships
* Employee/department relationships
* Indexing
* Transaction management
* Improved schema design

## Flutter Improvements

* Repository pattern
* Dedicated API service
* Better Riverpod architecture
* Loading/error states
* Offline-first support
* Pagination
* Search and filtering
* Automated widget tests
* Integration tests

---

# 🧩 Potential Production Architecture

A future production version could follow:

```text
                     ┌──────────────────┐
                     │   Flutter App    │
                     └────────┬─────────┘
                              │
                         HTTPS / REST
                              │
                              ▼
                     ┌──────────────────┐
                     │  Express API     │
                     └────────┬─────────┘
                              │
               ┌──────────────┼──────────────┐
               │              │              │
               ▼              ▼              ▼
          Authentication   Business       Validation
             / JWT          Logic
               │              │
               └──────────────┼──────────────┘
                              │
                              ▼
                     ┌──────────────────┐
                     │   PostgreSQL     │
                     └──────────────────┘
```

This architecture would allow the application to scale while keeping the Flutter frontend independent from the database layer.

---

# 🎯 Learning Objectives

The main purpose of this project was to gain practical experience building a mobile application beyond basic UI development.

Key areas explored include:

* Designing Flutter applications using reusable components
* Managing application state
* Building local persistence with SQLite
* Implementing CRUD functionality
* Connecting a Flutter application to a backend
* Creating REST APIs with Express
* Working with PostgreSQL
* Implementing authentication
* Hashing passwords securely
* Working with JWTs
* Structuring frontend and backend projects
* Separating UI, models, services, and database logic

---

# 👨‍💻 Author

**Shrudhir Praveen**

GitHub:
https://github.com/shrudh14007

Repository:
https://github.com/shrudh14007/Employee_management_flutter

---

## ⭐ Project Status

This project is currently a **learning and development project** demonstrating Flutter, local database operations, backend APIs, and authentication concepts.

The architecture provides a foundation that can be extended into a complete employee management platform.

---

⭐ If you find the project useful, consider giving the repository a star.
