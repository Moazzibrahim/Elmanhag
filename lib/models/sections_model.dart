class Section {
  final String name;
  final int id;
  final int subjectId;

  Section({required this.name, required this.id, required this.subjectId});

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        name: json['section'],
        id: json['id'],
        subjectId: json['subject_id'],
      );
}

class Sections {
  final List<dynamic> sectionsList;

  Sections({required this.sectionsList});

  factory Sections.fromjson(Map<String, dynamic> json) =>
      Sections(sectionsList: json['sections']);
}

class Lesson {
  final String name;
  final int id;
  final int sectionId;

  Lesson({required this.name, required this.id, required this.sectionId});

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        name: json['lesson'],
        id: json['id'],
        sectionId: json['section_id'],
      );
}

class Lessons{
  final List<dynamic> lessonsList;

  Lessons({required this.lessonsList});

  factory Lessons.fromJson(Map<String,dynamic> json)=>
  Lessons(lessonsList: json['lessons']);
}
