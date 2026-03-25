# Task Manager App (Flutter)

##  Overview
This is a Task Management mobile application built using Flutter. The app allows users to create, manage, and track tasks efficiently with dependency handling and smooth UI interactions.

---

##  Features

###  Core Features
- Create tasks with:
  - Title
  - Description
  - Due Date
  - Status (To-Do, In Progress, Done)
  - Blocked By (optional dependency)
- View all tasks in a list
- Delete tasks
- Update task status by tapping

---

###  Search & Filter
- Search tasks by title (real-time)
- Filter tasks by status

---

###  Draft Saving
- User input is preserved if they leave the task creation screen

---

###  Dependency Logic (Blocked By)
- Tasks can depend on other tasks
- Blocked tasks appear visually disabled (greyed out)
- When the dependency task is marked as "Done", blocked tasks become active

---

###  Async Handling
- Simulated 2-second delay on task creation
- Loading indicator shown during saving
- Prevents multiple submissions

---

### UI/UX Highlights
- Clean and simple interface
- Visual feedback using opacity and color for blocked tasks
- Smooth user interaction

---

##  Tech Stack
- Flutter (Dart)
- State Management: setState
- Local in-memory storage

---

##  Project Structure
lib/
├── main.dart
├── models/
│ └── task.dart
├── screens/
└── add_task_screen.dart


---

## ▶️ How to Run

1. Install Flutter SDK
2. Clone this repository
3. Run the following commands:
flutter pub get
flutter run

##  Key Highlights
- Implemented task dependency system
- Dynamic UI updates using state
- Async behavior handling with loading indicators
- Clean and modular code structure