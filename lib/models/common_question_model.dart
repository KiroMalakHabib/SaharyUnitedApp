class CommonQuestionModel {
  final int id;
  final String question;
  final String answer;

  CommonQuestionModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory CommonQuestionModel.fromJson(Map<String, dynamic> json) {
    return CommonQuestionModel(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }
}
