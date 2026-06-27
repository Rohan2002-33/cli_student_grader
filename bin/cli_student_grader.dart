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
      case "1": addStudent();
      case "2": recordScore();
      case "3": addBonusPoints();
      case "4": addComment();
      case "5": print("Coming soon...");
      case "6": print("Coming soon...");
      case "7": print("Coming soon...");
      case "8": running = false;
      default:  print("Invalid option.");
    }
  } while (running);

  print("Goodbye!");
}
void addStudent() {
  stdout.write("\nEnter student name: ");
  var name = stdin.readLineSync() ?? "Unknown";

  var student = <String, dynamic>{
    "name": name,
    "scores": <int>[],
    "subjects": {...availableSubjects},
    "bonus": null,
    "comment": null,
  };

  students.add(student);
  print("✓ Student '$name' added!");
}
void recordScore() {
  if (students.isEmpty) { print("No students yet."); return; }

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  stdout.write("Pick student number: ");
  var pick = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;
  if (pick < 1 || pick > students.length) { print("Invalid."); return; }
  var student = students[pick - 1];

  print("Subjects: ${student["subjects"]}");
  stdout.write("Enter subject: ");
  stdin.readLineSync();

  int score = -1;
  while (score < 0 || score > 100) {
    stdout.write("Enter score (0-100): ");
    score = int.tryParse(stdin.readLineSync() ?? "-1") ?? -1;
    if (score < 0 || score > 100) print("✗ Must be 0-100!");
  }

  (student["scores"] as List<int>).add(score);
  print("✓ Score $score recorded for ${student["name"]}!");
}
void addBonusPoints() {
  if (students.isEmpty) { print("No students yet."); return; }

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }
  stdout.write("Pick student number: ");
  var pick = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;
  if (pick < 1 || pick > students.length) { print("Invalid."); return; }
  var student = students[pick - 1];

  stdout.write("Enter bonus (1-10): ");
  var bonusValue = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  if (student["bonus"] == null) {
    student["bonus"] ??= bonusValue;
    print("✓ Bonus $bonusValue added!");
  } else {
    print("✗ Bonus already set to ${student["bonus"]}!");
  }
}

void addComment() {
  if (students.isEmpty) { print("No students yet."); return; }

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }
  stdout.write("Pick student number: ");
  var pick = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;
  if (pick < 1 || pick > students.length) { print("Invalid."); return; }
  var student = students[pick - 1];

  stdout.write("Enter comment: ");
  student["comment"] = stdin.readLineSync();

  String display = (student["comment"] as String?)?.toUpperCase() ?? "No comment provided";
  print("✓ Comment saved: $display");
}