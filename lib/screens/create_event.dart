import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/models/event.dart';
import 'package:events_app/models/society.dart';
import 'package:events_app/models/user.dart';
import 'package:events_app/providers/eventProvider.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/customtextformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  final UserModel eventcreator;
  final SocietyModel eventorganizer;

  const CreateEvent(
      {Key? key, required this.eventcreator, required this.eventorganizer})
      : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final formkey = GlobalKey<FormState>();
  TextEditingController eventname = TextEditingController();
  TextEditingController eventaddress = TextEditingController();
  TextEditingController discription = TextEditingController();
  String id = "";
  String eventdate = "";
  String image = "";
  String heldby = "";
  String startime = "";
  String endtime = "";
  String hostid = "";
  int participants = 0;
  int intrestcount = 0;
  bool isonline = false;
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay eventendTime = TimeOfDay.now();
  String eventStartingTime = "";
  String eventendingTime = "";

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050)) as DateTime;
    if (pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        eventdate = pickedDate.toString().substring(0, 11);
      });
  }

  Future<void> _selectTime(BuildContext context, int startorendtime) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: currentTime);
    if (pickedTime != null)
      setState(() {
        if (startorendtime == 1) {
          currentTime = pickedTime;
          eventStartingTime = pickedTime.toString().substring(10, 15);
        } else {
          eventendTime = pickedTime;
          eventendingTime = pickedTime.toString().substring(10, 15);
        }
      });
  }

  void clearControllers() {
    eventname.text = "";
    eventaddress.text = "";
    eventdate = "";
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<EventProvider>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 1,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 35,
                        ),
                        onPressed: () {
                          //  changeScreenReplacement(context, )
                        },
                      ),
                    ),
                    CustomText(
                      text: 'Create Event',
                      color: Colors.black,
                      size: 30,
                      fontWeight: FontWeight.bold,
                      letterspacing: 2,
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 1,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.black,
                          size: 35,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(padding: EdgeInsets.only(top: 15)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: CustomText(
                      text: "Event Name",
                      color: Colors.black,
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                text: "Enter Event Name",
                editingController: eventname,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 8, 0, 8),
                    child: CustomText(
                      text: 'Participants',
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 25)),
                  CustomText(
                    text: '(choose how many people can join event)',
                    //fontWeight: FontWeight.bold,
                    size: 15,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                child: Row(
                  children: [
                    Container(
                        height: height * 0.08,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // tapped = true;
                              // print(tapped);
                            });
                          },
                          child: Card(
                              color: Colors.black,
                              child: Center(
                                child: CustomText(
                                  text: participants.toString(),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )),
                    Padding(padding: EdgeInsets.only(left: 50)),
                    Card(
                      color: Colors.grey.shade300,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_rounded,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            // authProvider
                            participants++;
                            participants = participants;
                          });
                        },
                      ),
                    ),
                    Card(
                      color: Colors.grey.shade300,
                      child: IconButton(
                        icon: Icon(
                          Icons.exposure_minus_1,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            if (participants > 5) {
                              participants--;
                              participants = participants;
                            }
                            ;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: CustomText(
                      text: "Event Date",
                      color: Colors.black,
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 24, 40, 12),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    //color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => {print(currentDate), _selectDate(context)},
                      child: TextFormField(
                        enabled: false,
                        //controller: authProvider.password,
                        decoration: InputDecoration(
                            hintText: currentDate.toString().substring(0, 11),
                            border: InputBorder.none,
                            icon: Icon(Icons.calendar_today)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 0, 15),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Start Time",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 20,
                    ),
                    Padding(padding: EdgeInsets.only(left: width * 0.2)),
                    CustomText(
                      text: "End Time",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0, 40, 12),
                    child: Container(
                      height: 55,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                        //  color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () =>
                              {print(currentTime), _selectTime(context, 1)},
                          child: TextFormField(
                            enabled: false,
                            //controller: authProvider.password,
                            decoration: InputDecoration(
                                hintText:
                                    currentTime.toString().substring(10, 15),
                                border: InputBorder.none,
                                icon: Icon(Icons.watch)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 12),
                    child: Container(
                      height: 55,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => {_selectTime(context, 0)},
                          child: TextFormField(
                            enabled: false,
                            //controller: authProvider.password,
                            decoration: InputDecoration(
                                hintText:
                                    eventendTime.toString().substring(10, 15),
                                border: InputBorder.none,
                                icon: Icon(Icons.watch)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(05, 15, 0, 15),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: width * 0.065)),
                    CustomText(
                      text: "Online",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 24,
                    ),
                    Padding(padding: EdgeInsets.only(left: width * 0.48)),
                    CupertinoSwitch(
                        activeColor: Colors.blue,
                        value: isonline,
                        onChanged: (bool value) {
                          setState(() {
                            isonline = value;
                            print(isonline);
                          });
                        })
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: width * 0.08)),
                  CustomText(
                    text: "Event Adress",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    size: 20,
                  ),
                ],
              ),
              CustomTextField(
                  text: "Enter Event Address", editingController: eventaddress),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: width * 0.08)),
                  CustomText(
                    text: "Event Description (Optional  )",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    size: 20,
                  ),
                ],
              ),
              CustomTextField(
                  text: "Enter Event Description",
                  editingController: discription),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                child: Container(
                    height: height * 0.07,
                    width: width * 0.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            // if (!await authProvider.CreateEvent()) {
                            if (!await authProvider.createEvent(
                                eventname.text,
                                discription.text,
                                eventaddress.text,
                                eventdate,
                                "",
                                widget.eventcreator.name,
                                widget.eventorganizer.name,
                                eventStartingTime,
                                eventendingTime,
                                participants,
                                isonline,
                                widget.eventorganizer.uid,
                                widget.eventcreator.uid)) {
                              print("Error");
                            } else {
                              print("added");
                              clearControllers();
                              isonline = false;
                            }
                          }
                        },
                        child: CustomText(
                          text: "Create",
                          fontWeight: FontWeight.bold,
                          size: 24,
                          color: Colors.white,
                        ))),
              )
            ],
          ),
        ),
      )),
    );
  }
}
