class HomeworkResponse {
  final Homeworkss? homework;

  HomeworkResponse({
    required this.homework,
  });

  factory HomeworkResponse.fromJson(Map<String, dynamic> json) {
    return HomeworkResponse(
      homework: json['homework'] != null ? Homeworkss.fromJson(json['homework']) : null,
    );
  }
}

class Homeworkss {
  final int? id;
  final String? title;
  final String? semester;
  final int? categoryId;
  final int? subjectId;
  final int? chapterId;
  final int? lessonId;
  final String? difficulty;
  final int? mark;
  final int? pass;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final List<QuestionGroup>? questionGroups;

  Homeworkss({
    required this.id,
    required this.title,
    required this.semester,
    this.categoryId,
    this.subjectId,
    this.chapterId,
    this.lessonId,
    this.difficulty,
    required this.mark,
    required this.pass,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.questionGroups,
  });

  factory Homeworkss.fromJson(Map<String, dynamic> json) {
    return Homeworkss(
      id: json['id'] as int?,
      title: json['title']?.toString(),
      semester: json['semester']?.toString(),
      categoryId: json['category_id'] as int?,
      subjectId: json['subject_id'] as int?,
      chapterId: json['chapter_id'] as int?,
      lessonId: json['lesson_id'] as int?,
      difficulty: json['difficulty']?.toString(),
      mark: json['mark'] as int?,
      pass: json['pass'] as int?,
      status: json['status'] as int?,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      questionGroups: (json['question_groups'] as List?)
          ?.map((group) => QuestionGroup.fromJson(group))
          .toList(),
    );
  }
}

class QuestionGroup {
  final int? id;
  final String? name;
  final List<Question>? questions;

  QuestionGroup({
    required this.id,
    required this.name,
    required this.questions,
  });

  factory QuestionGroup.fromJson(Map<String, dynamic> json) {
    return QuestionGroup(
      id: json['id'] as int?,
      name: json['name']?.toString(),
      questions: (json['questions'] as List?)
          ?.map((question) => Question.fromJson(question))
          .toList(),
    );
  }
}

class Question {
  final int? id;
  final String? question;
  final String? image;
  final String? audio;
  final String? imageLink;
  final String? audioLink;
  final int? status;
  final int? categoryId;
  final int? subjectId;
  final int? chapterId;
  final int? lessonId;
  final String? semester;
  final String? difficulty;
  final String? answerType;
  final String? questionType;
  final Pivot? pivot;
  final List<Answer>? answers;

  Question({
    required this.id,
    required this.question,
    this.image,
    this.audio,
    this.imageLink,
    this.audioLink,
    this.status,
    this.categoryId,
    this.subjectId,
    this.chapterId,
    this.lessonId,
    this.semester,
    this.difficulty,
    this.answerType,
    this.questionType,
    this.pivot,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int?,
      question: json['question']?.toString(),
      image: json['image']?.toString(),
      audio: json['audio']?.toString(),
      imageLink: json['image_link']?.toString(),
      audioLink: json['audio_link']?.toString(),
      status: json['status'] as int?,
      categoryId: json['category_id'] as int?,
      subjectId: json['subject_id'] as int?,
      chapterId: json['chapter_id'] as int?,
      lessonId: json['lesson_id'] as int?,
      semester: json['semester']?.toString(),
      difficulty: json['difficulty']?.toString(),
      answerType: json['answer_type']?.toString(),
      questionType: json['question_type']?.toString(),
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
      answers: (json['answers'] as List?)
          ?.map((answer) => Answer.fromJson(answer))
          .toList(),
    );
  }
}

class Pivot {
  final int? questionGroupId;
  final int? questionId;

  Pivot({
    required this.questionGroupId,
    required this.questionId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      questionGroupId: json['question_group_id'] as int?,
      questionId: json['question_id'] as int?,
    );
  }
}

class Answer {
  final int? id;
  final String? answer;
  final String? trueAnswer;  // This field should map to `true_answer` from the JSON.

  Answer({
    required this.id,
    required this.answer,
    this.trueAnswer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as int?,
      answer: json['answer']?.toString(),
      trueAnswer: json['true_answer']?.toString(),
    );
  }
}
