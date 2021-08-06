import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/society.dart';

class UserModel {
  static const NAME = "name";
  static const ADDRESS = "address";
  static const INSTA = "instagramID";
  static const PROFILEIMAGE = "profileimage";
  static const COVERIMAGE = "coverimage";
  static const UNIVERSITY = "university";
  static const DEPARTMENT = "department";
  static const DATEOFBIRTH = "dateofbirth";
  static const BIO = "bio";
  static const EMAIL = "email";
  static const PHONENUMBER = "phonenumber";
  static const LIKEDSOCIETIES = "likedsocieties";

  String _uid = "";
  String _name = "";
  String _address = "";
  String _instagramID = "";
  String _profileimage = "";
  String _coverimage = "";
  String _university = "";
  String _dateofbirth = "";
  String _bio = "";
  String _phonenumber = "";
  String _department = "";
  String _email = "";
  List<SocietyModel> _likedsocieties = [];
  //String _likedsocieties;

//  getters
  String get uid => _uid;
  String get name => _name;
  String get address => _address;
  String get instagramID => _instagramID;
  String get profileimage => _profileimage;
  String get coverimage => _coverimage;
  String get university => _university;
  String get dateofbirth => _dateofbirth;
  String get bio => _bio;
  String get email => _email;
  String get department => _department;
  String get phonenumser => _phonenumber;
  List<SocietyModel> get likedsocieties => _likedsocieties;

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _uid = snapshot.id;
    _name = snapshot.data()![NAME];
    _address = snapshot.data()![ADDRESS];
    _instagramID = snapshot.data()![INSTA];
    _profileimage = snapshot.data()![PROFILEIMAGE];
    _coverimage = snapshot.data()![COVERIMAGE];
    _university = snapshot.data()![UNIVERSITY];
    _dateofbirth = snapshot.data()![DATEOFBIRTH];
    _bio = snapshot.data()![BIO];
    _phonenumber = snapshot.data()![PHONENUMBER];
    _department = snapshot.data()![DEPARTMENT];
    _email = snapshot.data()![EMAIL];
  }
}
