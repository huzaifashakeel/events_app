import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/event.dart';
import 'package:events_app/models/user.dart';

class SocietyModel {
  static const NAME = "name";
  static const DESCRIPTION = "description";
  static const PROFILEIMAGE = "profileimage";
  static const COVERIMAGE = "coverimage";
  static const UNIVERSITY = "university";
  static const DEPARTMENT = "department";
  static const CREATIONDATE = "creationdate";
  static const HELDEVENTS = "heldevents";
  static const UPCOMINGEVENTS = "upcomingevents";
  static const MEMBERS = "members";
  static const ADMIN = "admin";
  static const ADMINUID = "adminUid";
  static const GOALS = "goals";
  static const TYPE = "type";

  String _uid = "";
  String _name = "";
  String _description = "";
  String _university = "";
  String _profileimage = "";
  String _coverimage = "";
  Timestamp _creationdate = Timestamp(0, 0);
  String _goals = "";
  String _type = "";
  String _department = "";
  String _admin = "";
  String _adminUid = "";
  List<EventModel> _heldevents = [];
  List<EventModel> _upcomingevents = [];
  List<UserModel> _members = [];
  //String _likedsocieties;

//  getters
  String get uid => _uid;
  String get name => _name;
  String get description => _description;
  String get university => _university;
  String get profileimage => _profileimage;
  String get coverimage => _coverimage;
  Timestamp get creationdate => _creationdate;
  String get goals => _goals;
  String get type => _type;
  String get department => _department;
  String get admin => _admin;
  String get adminUid => _adminUid;
  List<EventModel> get heldevents => _heldevents;
  List<EventModel> get upcomingevents => _upcomingevents;
  List<UserModel> get members => _members;

  SocietyModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _uid = snapshot.id;
    _name = snapshot.data()![NAME];
    _description = snapshot.data()![DESCRIPTION];
    _university = snapshot.data()![UNIVERSITY];
    _department = snapshot.data()![DEPARTMENT];
    _profileimage = snapshot.data()![PROFILEIMAGE];
    _coverimage = snapshot.data()![COVERIMAGE];
    _creationdate = snapshot.data()![CREATIONDATE];
    _goals = snapshot.data()![GOALS];
    _type = snapshot.data()![TYPE];
    //_heldevents = snapshot.data()![HELDEVENTS];
    //_upcomingevents = snapshot.data()![UPCOMINGEVENTS];
    //_members = snapshot.data()![MEMBERS];
    _admin = snapshot.data()![ADMIN];
    _adminUid = snapshot.data()![ADMINUID];
  }
}
