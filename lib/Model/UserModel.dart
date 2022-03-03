class UserModel {
  String user_id='';
  String phone='';
  String password='';

  UserModel(this.user_id,  this.phone, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'phone': phone,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    phone = map['phone'];
    password = map['password'];
  }
}
