class CareTeam {
  int? id;
  String? name;
  String? phone;
  int? status;


  CareTeam({this.name, this.phone, this.status});

  CareTeam.withId({this.id, this.name, this.phone, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['status'] = status;

    return map;
  }

  factory CareTeam.fromMap(Map<String, dynamic> map) {
    return CareTeam.withId(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        status: map['status']);

  }
}