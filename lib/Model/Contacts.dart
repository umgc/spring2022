class Contact {
  int? id;
  String? name;
  String? phone;
  int? status;


  Contact({this.name, this.phone, this.status});

  Contact.withId({this.id, this.name, this.phone, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['status'] = status;

    return map;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact.withId(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        status: map['status']);

  }
}