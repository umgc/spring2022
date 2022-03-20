class Transportation {
  int? id;
  String? name;
  String? phone;
  int? status;


  Transportation({this.name, this.phone, this.status});

  Transportation.withId({this.id, this.name, this.phone, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['status'] = status;

    return map;
  }

  factory Transportation.fromMap(Map<String, dynamic> map) {
    return Transportation.withId(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        status: map['status']);

  }
}