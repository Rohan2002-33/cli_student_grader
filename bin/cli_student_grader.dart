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
      case "5": viewAllStudents();
      case "6": viewReportCard();
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
void viewAllStudents() {
  if (students.isEmpty) { print("No students yet."); return; }

  print("\n===== ALL STUDENTS =====");
  for (var student in students) {
    var tags = [
      student["name"],
      "${(student["scores"] as List).length} scores",
      if (student["bonus"] != null) "★ Has Bonus",
      if (student["comment"] != null) "💬 Has Comment",
    ];
    print("→ ${tags.join(" | ")}");
  }
  print("========================");
}

double calculateAvg(Map<String, dynamic> student) {
  var scores = student["scores"] as List<int>;
  if (scores.isEmpty) return 0.0;

  int sum = 0;
  for (var s in scores) { sum += s; }
  double rawAvg = sum / scores.length;
  double finalAvg = rawAvg + (student["bonus"] ?? 0);
  return finalAvg > 100 ? 100.0 : finalAvg;
}

void viewReportCard() {
  if (students.isEmpty) { print("No students yet."); return; }

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }
  stdout.write("Pick student number: ");
  var pick = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;
  if (pick < 1 || pick > students.length) { print("Invalid."); return; }
  var student = students[pick - 1];

  double avg = calculateAvg(student);

  String grade;
  if (avg >= 90)      grade = "A";
  else if (avg >= 80) grade = "B";
  else if (avg >= 70) grade = "C";
  else if (avg >= 60) grade = "D";
  else                grade = "F";

  String feedback = switch (grade) {
    "A" => "Outstanding performance!",
    "B" => "Good work, keep it up!",
    "C" => "Satisfactory. Room to improve.",
    "D" => "Needs improvement.",
    "F" => "Failing. Please seek help.",
    _   => "Unknown grade.",
  };

  String comment = (student["comment"] as String?)?.toUpperCase() ?? "No comment provided";

  const int w = 27;
  String row(String label, String value) {
    var content = " $label: $value";
    return "|${content.padRight(w)}|";
  }
  var border = "+${'-' * w}+";

  print(border);
  print("|${"       REPORT CARD       ".padRight(w)}|");
  print(border);
  print(row("Name   ", "${student["name"]}"));
  print(row("Scores ", "${student["scores"]}"));
  print(row("Bonus  ", "${student["bonus"] ?? "None"}"));
  print(row("Average", avg.toStringAsFixed(2)));
  print(row("Grade  ", grade));
  print(row("Comment", comment));
  print(border);
  print("★ Feedback: $feedback\n");
}