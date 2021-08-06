import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/models/event.dart';
import 'package:events_app/models/society.dart';
import 'package:events_app/models/user.dart';
import 'package:events_app/providers/eventProvider.dart';
import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/screens/loading.dart';
import 'package:events_app/screens/showUserProfile.dart';
import 'package:events_app/screens/vieweventfollwers.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/eventSummaryCard.dart';
import 'package:events_app/widgets/member_infoCard.dart';
import 'package:events_app/widgets/society_infoCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class EventDetails extends StatefulWidget {
  final EventModel event;
  final UserModel eventhost;
  final UserModel user;
  final SocietyModel eventhostSociety;
  final bool showhostsoc;
  //late List<UserModel> eventparticipants;

  const EventDetails({
    Key? key,
    required this.event,
    required this.eventhost,
    required this.user,
    required this.eventhostSociety,
    required this.showhostsoc,
  }) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final userprovider = Provider.of<UserProvider>(context);
    final eventprovider = Provider.of<EventProvider>(context);
    bool ifalreadyliked;

    //just for testing
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: userprovider.ifalreadylikedbyuser(
                collectionName: "Events",
                collectionDocid: widget.event.uid,
                userid: userprovider.varifiedUser.uid),
            builder: (BuildContext context, AsyncSnapshot<bool> result) {
              if (result.data.toString() == "true") {
                ifalreadyliked = true;
              } else
                ifalreadyliked = false;
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: height * 0.35,
                        width: width,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: Stack(
                              children: [
                                Loading(),
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: widget.event.image,
                                  fit: BoxFit.fill,
                                  height: height * 0.35,
                                  width: width,
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: Container(
                              height: height * 0.07,
                              width: width * 0.15,
                              child: IconButton(
                                icon: Icon(
                                  Icons.thumb_up,
                                  color: ifalreadyliked
                                      ? Colors.blue
                                      : Colors.black,
                                ),
                                onPressed: () async {
                                  if (ifalreadyliked) {
                                    userprovider.deleteMem(
                                        collectionName: "Events",
                                        collectionDocid: widget.event.uid,
                                        userid: widget.user.uid);
                                    setState(() {
                                      //  liked = false;
                                    });
                                  } else {
                                    await userprovider.createEventMem(
                                        collectionName: "Events",
                                        user: widget.user,
                                        eventid: widget.event.uid);
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, height * 0.28, 0, 0),
                        child: EventSummaryCard(
                          event: widget.event,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomText(
                          text: "About",
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.05, 0, 0, height * 0.01),
                        child: CustomText(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. When an unknown printer took a galley of type and scrambled it to make a type specimen book",
                          fontWeight: FontWeight.w700,
                          size: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  if (widget.showhostsoc)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CustomText(
                            text: "Host Society",
                            fontWeight: FontWeight.bold,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  if (widget.showhostsoc)
                    SocietyInfoCard(
                      society: widget.eventhostSociety,
                    ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomText(
                          text: "Host",
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        changeScreen(context,
                            ShowUserProfile(userModel: widget.eventhost));
                      },
                      child: MemberInfo(user: widget.eventhost)),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomText(
                          text: "Who's Going ?",
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Container(
                      height: height * 0.07,
                      child: GestureDetector(
                        onTap: () {
                          changeScreen(context, ViewEventFollowers());
                        },
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: userprovider.eventparticipants.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                child: Center(
                              child: ClipOval(
                                child: CircleAvatar(
                                  radius: 25,
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: userprovider
                                        .eventparticipants[index].profileimage,
                                  ),
                                ),
                              ),
                            ));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
