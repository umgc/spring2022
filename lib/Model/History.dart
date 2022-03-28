class History {
  int? id;
  String? history;
  String? desc;
  int? status;


  History({this.history, this.desc, this.status});

  History.withId({this.id, this.history, this.desc, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['history'] = history;
    map['desc'] = desc;
    map['status'] = status;

    return map;
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History.withId(
        id: map['id'],
        history: map['history'],
        desc: map['desc'],
        status: map['status']);

  }
}