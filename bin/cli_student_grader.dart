import 'dart:io';

const String appTitle = "Student Grader v1.0";
final Set<String> availableSubjects = {"Math", "English", "Science", "History"};
var students = <Map<String, dynamic>>[];
var running = true;

void main() {
  do {
    print("""
===== $appTitle =====
1. Add Student
2. Record Score
3. Add Bonus Points
4. Add Comment
5. View All Students
6. View Report Card
7. Class Summary
8. Exit
=====================""");

    stdout.write("Choose an option: ");
    var input = stdin.readLineSync() ?? "";

    switch (input) {
      case "1": print("Coming soon...");
      case "2": print("Coming soon...");
      case "3": print("Coming soon...");
      case "4": print("Coming soon...");
      case "5": print("Coming soon...");
      case "6": print("Coming soon...");
      case "7": print("Coming soon...");
      case "8": running = false;
      default:  print("Invalid option.");
    }
  } while (running);

  print("Goodbye!");
}