class MedicalHistory {
  int? id;
  String? history;


  int? status;

  MedicalHistory({this.history});

  MedicalHistory.withId({this.id, this.history});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['history'] = history;


    return map;
  }

  factory MedicalHistory.fromMap(Map<String, dynamic> map) {
    return MedicalHistory.withId(
        id: map['id'],
        history: map['history'],);

  }
}