class Allergy {
  int? id;
  String? allergy;
  String? reaction;

  int? status;

  Allergy({this.allergy, this.reaction});

  Allergy.withId({this.id, this.allergy, this.reaction});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['allergy'] = allergy;
    map['reaction'] = reaction;


    return map;
  }

  factory Allergy.fromMap(Map<String, dynamic> map) {
    return Allergy.withId(
        id: map['id'],
        allergy: map['allergy'],
        reaction: map['reaction']);

  }
}