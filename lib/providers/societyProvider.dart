import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/society.dart';
import 'package:flutter/cupertino.dart';

class SocietyProvider with ChangeNotifier {
  late SocietyModel eventhostsociety;
  String societycollection = "Societies";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<SocietyModel> socities = [];

  List<SocietyModel> usersocities = [];

  SocietyProvider.initialize() {
    _loadSocities();
  }
  loadUserSocities({required String useruid}) async {
    await _firestore
        .collection("Users")
        .doc(useruid)
        .collection("Societies")
        .get()
        .then((result) => {
              usersocities = [],
              for (DocumentSnapshot<Map<String, dynamic>> user in result.docs)
                {usersocities.add(SocietyModel.fromSnapshot(user))}
            });
  }

  _loadSocities() async {
    await _firestore.collection(societycollection).get().then((result) {
      for (DocumentSnapshot<Map<String, dynamic>> user in result.docs) {
        print(user.id.toString());
        socities.add(SocietyModel.fromSnapshot(user));
      }
    });
  }

  Future getSocietybyid({required String id}) async {
    await _firestore.collection(societycollection).doc(id).get().then((doc) {
      eventhostsociety = SocietyModel.fromSnapshot(doc);
    });
  }

  Future<bool> isadminorUser(
      {required String uid, required String socid}) async {
    bool isadmin = false;
    await _firestore
        .collection(societycollection)
        .doc(socid)
        .get()
        .then((value) => {
              print("Printing uids\n\n\n"),
              print(uid),
              print(value.data()!["adminUid"]),
              if (uid.trim() == value.data()!["adminUid"].toString().trim())
                {print("isadmin is true"), isadmin = true},
              if (uid.trim() != value.data()!["adminUid"].toString().trim())
                {print("isadmin is false"), isadmin = false}
            });
    print("printing is admin");
    print(isadmin);
    return isadmin;
  }

  Future<bool> createSociety(
      String name,
      String description,
      String university,
      String goals,
      String type,
      String depratment,
      DateTime societyCreationTime,
      String adminname,
      String adminuid,
      String profileImage,
      String coverImage) async {
    try {
      Map<String, dynamic> values = {
        "name": name,
        "description": description,
        "university": university,
        "goals": goals,
        "type": type,
        "department": depratment,
        "creationdate": societyCreationTime,
        "admin": adminname,
        "adminUid": adminuid,
        "profileimage": profileImage,
        "coverimage": ""
      };
      _firestore.collection(societycollection).doc().set(values);
      //clearControllers();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> createuserSociety(
      {required SocietyModel society, required String userid}) async {
    try {
      Map<String, dynamic> values = {
        "name": society.name,
        "description": society.description,
        "university": society.university,
        "goals": society.goals,
        "type": society.type,
        "department": society.department,
        "creationdate": society.creationdate,
        "admin": society.admin,
        "adminUid": society.adminUid,
        "profileimage": society.profileimage,
        "coverimage": society.coverimage
      };
      _firestore
          .collection("Users")
          .doc(userid)
          .collection(societycollection)
          .doc(society.uid)
          .set(values);
      //clearControllers();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
