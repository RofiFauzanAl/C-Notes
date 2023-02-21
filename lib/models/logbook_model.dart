class LogbookNotes{
  int? idNotesLogbook, priority;
  String? titleLogbook, target, lessonLearn, 
          problem, achievements, solvingProblem, 
          createNotesLogbookAt, updateNotesLogbookAt, 
          idCategoryFK, reminder;

  LogbookNotes({
    this.idNotesLogbook,
    this.titleLogbook,
    this.target,
    this.lessonLearn,
    this.problem,
    this.achievements,
    this.solvingProblem,
    this.priority,
    this.reminder,
    this.createNotesLogbookAt,
    this.updateNotesLogbookAt,
    this.idCategoryFK,
  });

  factory LogbookNotes.fromJson(Map<String, dynamic> json) => LogbookNotes(
    idNotesLogbook: json['idNotesLogbook'],
    titleLogbook: json['titleLogbook'],
    target: json['target'],
    lessonLearn: json['lessonLearn'],
    problem: json['problem'],
    achievements: json['achievements'],
    solvingProblem: json['solvingProblem'],
    createNotesLogbookAt: json['createNotesLogbookAt'],
    updateNotesLogbookAt: json['updateNotesLogbookAt'],
    idCategoryFK: json['idCategoryFK'],
    priority: json['priority'],
    reminder: json['reminder'],
  );

  Map<String, dynamic> toJson() => {
    'idNotesLogbook': idNotesLogbook,
    'titleLogbook': titleLogbook,
    'target': target,
    'lessonLearn': lessonLearn,
    'problem': problem,
    'achievements': achievements,
    'solvingProblem': solvingProblem,
    'priority': priority,
    'reminder': reminder,
    'createNotesLogbookAt': createNotesLogbookAt,
    'updateNotesLogbookAt': updateNotesLogbookAt,
    'idCategoryFK': idCategoryFK,
  };

}