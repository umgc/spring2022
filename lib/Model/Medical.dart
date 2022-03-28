class Medical {
  int? id;
  String? medical;
  String? mednote;

  int? status;

  Medical({this.medical, this.mednote});

  Medical.withId({this.id, this.medical, this.mednote});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['medical'] = medical;
    map['mednote'] = mednote;


    return map;
  }

  factory Medical.fromMap(Map<String, dynamic> map) {
    return Medical.withId(
        id: map['id'],
        medical: map['medical'],
        mednote: map['mednote']);

  }
}