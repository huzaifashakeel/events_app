import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/user.dart';

class EventModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const NAME = "name";
  static const LOCATION = "location";
  static const DATE = "date";
  static const IMAGE = "image";
  static const HELDBY = "heldby";
  static const HOSTUID = "hostuid";
  static const HELDBYSOCIETY = "heldbySociety";
  static const INTRESTS = "Intrest_count";
  static const STARTIME = "startime";
  static const ENDTIME = "endtime";
  static const TOTALPARTICIPANTS = "participants";
  static const LIKEDBY = "likedby";
  static const ISONLINE = "isonline";

  static const HOSTSOCIETYID = "hostsocietyid";

  static const INTRESTEDMEMBERS = "intrestedmembers";

  String _id = "";
  String _uid = "";
  String _name = "";
  String _description = "";
  String _location = "";
  String _date = "";
  String _image = "";
  String _heldby = "";
  String _heldbySociety = "";
  String _startime = "";
  String _endtime = "";
  String _hostuid = "";
  String _hostsocietyid = "";
  int _participants = 0;
  int _intrestcount = 0;
  bool _isonline = false;

//  getters
  String get id => _id;
  String get uid => _uid;
  String get name => _name;
  String get description => _description;
  String get location => _location;
  String get date => _date;
  String get heldby => _heldby;
  String get heldbySociety => _heldbySociety;
  String get image => _image;
  String get startime => _startime;
  String get endtime => _endtime;
  String get hostuid => _hostuid;
  String get hostsocietyid => _hostsocietyid;
  bool get isonline => _isonline;
  int get intrestcount => _intrestcount;
  int get participants => _participants;

  EventModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _uid = snapshot.id;
    _description = snapshot.data()![DESCRIPTION];
    _name = snapshot.data()![NAME];
    _location = snapshot.data()![LOCATION];
    _date = snapshot.data()![DATE];
    _heldby = snapshot.data()![HELDBY];
    _heldbySociety = snapshot.data()![HELDBYSOCIETY];
    _intrestcount = snapshot.data()![INTRESTS];
    _startime = snapshot.data()![STARTIME];
    _endtime = snapshot.data()![ENDTIME];
    _image = snapshot.data()![IMAGE];
    _isonline = snapshot.data()![ISONLINE];
    _hostuid = snapshot.data()![HOSTUID];

    //_likedby = snapshot.data()![LIKEDBY];
    _hostsocietyid = snapshot.data()![HOSTSOCIETYID];
    _participants = snapshot.data()![TOTALPARTICIPANTS];
    //_intrestcount = snapshot.data()![INTRESTS];
    // _intrestedmembers = snapshot.data()![INTRESTEDMEMBERS];
  }
}
