import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/event.dart';
import 'package:events_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> events = [];
  List<EventModel> socevents = [];

  String eventcollection = 'Events';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  EventProvider.initialize() {
    loadevents();
  }

  loadSocietyEvents({required String Socid}) async {
    await _firestore
        .collection("Societies")
        .doc(Socid)
        .collection(eventcollection)
        .get()
        .then((result) => {
              socevents = [],
              for (DocumentSnapshot<Map<String, dynamic>> event in result.docs)
                {socevents.add(EventModel.fromSnapshot(event))}
            });
  }

  loadevents() async {
    await _firestore.collection(eventcollection).get().then((result) {
      events = [];
      for (DocumentSnapshot<Map<String, dynamic>> event in result.docs) {
        events.add(EventModel.fromSnapshot(event));
      }
      notifyListeners();
    });
  }

  Future<bool> createEvent(
    String eventname,
    String eventdescription,
    String eventaddress,
    String eventdate,
    String eventimage,
    String host,
    String hostsociety,
    String startime,
    String endtime,
    int partcipants,
    bool isonline,
    //int intrestcount,
    String hostsocietyid,
    String hostuid,
  ) async {
    try {
      Map<String, dynamic> values = {
        "name": eventname,
        "description": eventdescription,
        "location": eventaddress,
        "date": eventdate,
        "image": eventimage,
        "heldby": host,
        "heldbySociety": hostsociety,
        "startime": startime,
        "endtime": endtime,
        "Intrest_count": 4,
        "participants": partcipants,
        "isonline": isonline,
        "hostsocietyid": hostsocietyid,
        "hostuid": hostuid,
      };

      _firestore.collection(eventcollection).doc().set(values);
      _firestore
          .collection("Societies")
          .doc(hostsocietyid)
          .collection("Events")
          .doc()
          .set(values);
      // clearControllers();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
