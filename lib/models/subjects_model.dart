class Subject {
  final int id;
  final double price;
  final String name;

  Subject({required this.id, required this.price, required this.name});

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json['id'],
        price: json['price'],
        name: json['name'],
      );
}

class Subjects{
  final List<dynamic> subjectsList;

  Subjects({required this.subjectsList});

  factory Subjects.fromJson(Map<String, dynamic> json) =>
  Subjects(subjectsList: json['subjects']);
}