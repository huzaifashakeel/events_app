import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/society.dart';
import 'package:events_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class SocietyProvider with ChangeNotifier {
  late SocietyModel eventhostsociety;
  String societycollection = "Societies";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<SocietyModel> socities = [];

  SocietyProvider.initialize() {
    _loadSocities();
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

  Future<bool> createSociety(
      String name,
      String description,
      String university,
      String goals,
      String type,
      String depratment,
      String societyCreationTime,
      String adminname,
      String adminuid,
      String profileImage,
      String coverImage) async {
    try {
      Map<String, dynamic> values = {
        "id": "234",
        "name": name,
        "description": description,
        "university": university,
        "goals": goals,
        "type": type,
        "department": depratment,
        "creationdate": societyCreationTime,
        "admin": adminname,
        "adminUid": adminuid,
        "profileimage": "",
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
}
