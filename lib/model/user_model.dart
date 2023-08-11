import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? phone;
  String? name;
  String? Id;
  String? email;
  String? address;

  UserModel({this.phone, this.email, this.name, this.Id, this.address});

  UserModel.fromSnapshot(DataSnapshot snap) {
    phone = (snap.value as dynamic)['phone'];
    name = (snap.value as dynamic)['name'];
    Id = snap.key;
    email = (snap.value as dynamic)['email'];
    address = (snap.value as dynamic)['address'];
  }
}
