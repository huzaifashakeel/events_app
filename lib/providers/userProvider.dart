import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String usercollection = "Users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserModel> users = [];
  List<UserModel> eventparticipants = [];
  List<UserModel> societyMembers = [];
  late UserModel varifiedUser;
  late UserModel eventhost;
  late bool isvar = false;

  UserProvider.initialze() {
    _loadusers();
  }

  _loadusers() async {
    await _firestore.collection(usercollection).get().then((result) {
      for (DocumentSnapshot<Map<String, dynamic>> user in result.docs) {
        users.add(UserModel.fromSnapshot(user));
      }
    });
    notifyListeners();
  }

  getVarifiedUser({required String email}) async {
    await _firestore
        .collection(usercollection)
        .where("email", isEqualTo: email)
        .get()
        .then((reult) {
      varifiedUser = UserModel.fromSnapshot(reult.docs.single);
    });
  }

  Future<bool> isuservarified({required String email}) async {
    try {
      await _firestore
          .collection(usercollection)
          .where("email", isEqualTo: email)
          .get()
          .then((reult) {
        if (reult.docs.first.data().isEmpty)
          isvar = false;
        else
          isvar = true;
      });
    } catch (e) {
      print(e);
      isvar = false;
    }
    return isvar;
  }

  Future getuserbyid({required String uid}) async {
    await _firestore.collection(usercollection).doc(uid).get()
        //.where("id", isEqualTo: id)
        //.get()
        .then((doc) {
      eventhost = UserModel.fromSnapshot(doc);
    });
  }

  getUserByID({required String id}) async =>
      await _firestore.collection(usercollection).doc(id).get().then((doc) {
        print("printing docomentdata\n\n");
        print(doc.data());
        eventhost = UserModel.fromSnapshot(doc);
      });

  Future<bool> createUser(
      String username,
      String usercity,
      String userInsta,
      String useruni,
      String userdepartment,
      String userDOB,
      String userbio,
      String phno,
      String email,
      String profileimage,
      String coverimage,
      String userid) async {
    try {
      Map<String, dynamic> values = {
        "name": username,
        "address": usercity,
        "instagramID": userInsta,
        "university": useruni,
        "department": userdepartment,
        "dateofbirth": "10-12-1998",
        "bio": userbio,
        "phonenumber": phno,
        "email": email,
        "profileimage": "",
        "coverimage": "",
        "id": userid,
      };

      _firestore.collection(usercollection).doc().set(values);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //relational functions of User and event

  Future<bool> ifalreadylikedbyuser(
      {required String collectionName,
      required String collectionDocid,
      required String userid}) async {
    bool userexist = false;
    await _firestore
        .collection(collectionName)
        .doc(collectionDocid)
        .collection(usercollection)
        .doc(userid)
        .get()
        .then((result) => {userexist = result.exists});
    return userexist;
  }

  deleteMem(
      {required String collectionName,
      required String collectionDocid,
      required String userid}) async {
    await _firestore
        .collection(collectionName)
        .doc(collectionDocid)
        .collection(usercollection)
        .doc(userid)
        .delete();
    await _firestore
        .collection("Users")
        .doc(userid)
        .collection("Societies")
        .doc(collectionDocid)
        .delete();
  }

  loadEventParticipant({required String eventid}) async {
    await _firestore
        .collection("Events")
        .doc(eventid)
        .collection(usercollection)
        .get()
        .then((result) => {
              eventparticipants = [],
              for (DocumentSnapshot<Map<String, dynamic>> participant
                  in result.docs)
                {eventparticipants.add(UserModel.fromSnapshot(participant))}
            });
  }

//relational functions of user and Society

  loadSocietyMembers({required String societyid}) async {
    await _firestore
        .collection("Societies")
        .doc(societyid)
        .collection(usercollection)
        .get()
        .then((result) => {
              societyMembers = [],
              for (DocumentSnapshot<Map<String, dynamic>> participant
                  in result.docs)
                {societyMembers.add(UserModel.fromSnapshot(participant))}
            });
  }

  Future<bool> createEventMem(
      {required String collectionName,
      required UserModel user,
      required String eventid}) async {
    try {
      Map<String, dynamic> values = {
        "name": user.name,
        "address": user.address,
        "instagramID": user.instagramID,
        "university": user.university,
        "department": user.department,
        "phonenumber": user.phonenumser,
        "email": user.email,
        "profileimage": user.profileimage,
        "dateofbirth": "10-12-1998",
        "bio": user.bio,
        "coverimage": "",
      };
      _firestore
          .collection(collectionName)
          .doc(eventid)
          .collection("Users")
          .doc(user.uid)
          .set(values);
      //clearControllers();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
