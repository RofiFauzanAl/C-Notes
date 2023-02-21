class CasualNotes{
  int? idNotesLogbook, priority;
  String? titleNotes, description, createNotesAt, updateNotesAt, idCategoryFK, reminder;

  CasualNotes({
    this.idNotesLogbook,
    this.titleNotes,
    this.description,
    this.createNotesAt,
    this.updateNotesAt,
    this.idCategoryFK,
    this.priority,
    this.reminder,
  });

  factory CasualNotes.fromJson(Map<String, dynamic> json) => CasualNotes(
    idNotesLogbook: json['idNotesLogbook'],
    titleNotes: json['titleNotes'],
    description: json['description'],
    createNotesAt: json['createNotesAt'],
    updateNotesAt: json['updateNotesAt'],
    idCategoryFK: json['idCategoryFK'],
    priority: json['priority'],
    reminder: json['reminder'],
  );

  Map<String, dynamic> toJson() => {
    'idNotesLogbook': idNotesLogbook,
    'titleNotes': titleNotes,
    'description': description,
    'createNotesAt': createNotesAt,
    'updateNotesAt': updateNotesAt,
    'idCategoryFK': idCategoryFK,
    'priority': priority,
    'reminder': reminder,
  };
}