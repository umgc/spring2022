class Medication {
  int? id;
  String? title;
  String? dose;
  int? status;


  Medication({this.title, this.dose, this.status});

  Medication.withId({this.id, this.title, this.dose, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['dose'] = dose;
    map['status'] = status;

    return map;
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication.withId(

        id: map['id'],
        title: map['title'],
        dose: map['dose'],
        status: map['status']);

  }
}