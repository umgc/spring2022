class User {
  final String imagePath;
  final String imagePath2;
  final String imagePath3;
  final String name;
  final String phone;
  final String bday;
  final String cont1;
  final String cont1ph;
  final String cont2;
  final String cont2ph;
  final String prov1;
  final String prov1ph;
  final String prov2;
  final String prov2ph;
  final String trans1;
  final String trans1ph;
  final String trans2;
  final String trans2ph;

  const User({
    required this.imagePath,
    required this.imagePath2,
    required this.imagePath3,
    required this.name,
    required this.phone,
    required this.bday,
    required this.cont1,
    required this.cont1ph,
    required this.cont2,
    required this.cont2ph,
    required this.prov1,
    required this.prov1ph,
    required this.prov2,
    required this.prov2ph,
    required this.trans1,
    required this.trans1ph,
    required this.trans2,
    required this.trans2ph,

  });

  User copy({
    String? imagePath,
    String? imagePath2,
    String? imagePath3,
    String? name,
    String? phone,
    String? bday,
    String? cont1,
    String? cont1ph,
    String? cont2,
    String? cont2ph,
    String? prov1,
    String? prov1ph,
    String? prov2,
    String? prov2ph,
    String? trans1,
    String? trans1ph,
    String? trans2,
    String? trans2ph,

  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        imagePath2: imagePath2 ?? this.imagePath2,
        imagePath3: imagePath3 ?? this.imagePath3,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        bday: bday ?? this.bday,
        cont1: cont1 ?? this.cont1,
        cont1ph : cont1ph ?? this.cont1ph,
        cont2 : cont2 ?? this.cont2,
        cont2ph : cont2ph ?? this.cont2ph,
        prov1 : prov1 ?? this.prov1,
        prov1ph : prov1ph ?? this.prov1ph,
        prov2 : prov2 ?? this.prov2,
        prov2ph : prov2ph ?? this.prov2ph,
        trans1 : trans1 ?? this.trans1,
        trans1ph: trans1ph ?? this.trans1ph,
        trans2 : trans2 ?? this.trans2,
        trans2ph : trans2ph ?? this.trans2ph,
      );

  static User fromJson(Map<String, dynamic> json) => User(
      imagePath: json['imagePath'],
      imagePath2: json['imagePath2'],
      imagePath3: json['imagePath3'],
      name: json['name'],
      phone: json['phone'],
      bday: json['bday'],
      cont1: json['cont1'],
      cont1ph: json['cont1ph'],
      cont2 :  json['cont2'],
      cont2ph: json['cont2ph'],
      prov1: json['prov1'],
      prov1ph: json['prov1ph'],
      prov2: json['prov2'],
      prov2ph: json['prov2ph'],
      trans1: json['trans1'],
      trans1ph: json['trans1ph'],
      trans2: json['trans2'],
      trans2ph: json['trans2ph'],

  );

  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
    'imagePath2': imagePath2,
    'imagePath3': imagePath3,
    'name': name,
    'phone': phone,
    'bday': bday,
    'cont1' : cont1,
    'cont1ph' : cont1ph,
    'cont2' : cont2,
    'cont2ph' : cont2ph,
    'prov1' : prov1,
    'prov1ph' : prov1ph,
    'prov2' : prov2,
    'prov2ph' : prov2ph,
    'trans1' : trans1,
    'trans1ph' : trans1ph,
    'trans2' : trans2,
    'trans2ph' : trans2ph,
  };
}
