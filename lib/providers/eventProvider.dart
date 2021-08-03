import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/event.dart';
import 'package:events_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> events = [];

  String eventcollection = 'Events';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  EventProvider.initialize() {
    _loadevents();
  }

  _loadevents() async {
    await _firestore.collection(eventcollection).get().then((result) {
      for (DocumentSnapshot<Map<String, dynamic>> event in result.docs) {
        events.add(EventModel.fromSnapshot(event));
      }
      notifyListeners();
    });
  }

  Future<bool> createEvent(
      String id,
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
      bool isonline) async {
    try {
      Map<String, dynamic> values = {
        "hostid": id,
        "name": eventname,
        "description": eventdescription,
        "location": eventaddress,
        "date": eventdate,
        "image": "none",
        "heldby": host,
        "heldbySociety": hostsociety,
        "startime": startime,
        "endtime": endtime,
        "Intrest_count": 4,
        "participants": partcipants,
        "isonline": isonline,
      };

      _firestore.collection(eventcollection).doc().set(values);
      // clearControllers();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
