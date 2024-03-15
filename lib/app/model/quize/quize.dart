// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  bool? success;
  Quiz? quiz;

  QuizModel({
    this.success,
    this.quiz,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    success: json["success"],
    quiz: json["quiz"] == null ? null : Quiz.fromJson(json["quiz"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "quiz": quiz?.toJson(),
  };
}

class Quiz {
  int? id;
  String? title;
  String? description;
  int? duration;
  int? categoryId;
  int? lang;
  int? isFree;
  dynamic image;
  dynamic mrp;
  dynamic discount;
  List<Question>? questions;

  Quiz({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.categoryId,
    this.lang,
    this.isFree,
    this.image,
    this.mrp,
    this.discount,
    this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    duration: json["duration"],
    categoryId: json["category_id"],
    lang: json["lang"],
    isFree: json["is_free"],
    image: json["image"],
    mrp: json["mrp"],
    discount: json["discount"],
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "duration": duration,
    "category_id": categoryId,
    "lang": lang,
    "is_free": isFree,
    "image": image,
    "mrp": mrp,
    "discount": discount,
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  int? id;
  String? quizeId;
  String? text;
  List<Option>? options;

  Question({
    this.id,
    this.quizeId,
    this.text,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    quizeId: json["quize_id"],
    text: json["text"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quize_id": quizeId,
    "text": text,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  int? id;
  int? questionId;
  String? optionText;
  int? isCorrect;

  Option({
    this.id,
    this.questionId,
    this.optionText,
    this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    questionId: json["question_id"],
    optionText: json["option_text"],
    isCorrect: json["is_correct"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_id": questionId,
    "option_text": optionText,
    "is_correct": isCorrect,
  };
}
