import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/models/society.dart';
import 'package:events_app/models/user.dart';
import 'package:events_app/providers/eventProvider.dart';
import 'package:events_app/providers/societyProvider.dart';
import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/screens/viewsocietyMembers.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/eventFeed_widget.dart';
import 'package:events_app/widgets/society_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SocietyDetails extends StatefulWidget {
  final SocietyModel society;
  final UserModel user;

  const SocietyDetails({Key? key, required this.society, required this.user})
      : super(key: key);

  @override
  _SocietyDetailsState createState() => _SocietyDetailsState();
}

class _SocietyDetailsState extends State<SocietyDetails> {
  bool showSocietyEvents = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final userProvider = Provider.of<UserProvider>(context);
    final societyProvider = Provider.of<SocietyProvider>(context);

    final eventProvider = Provider.of<EventProvider>(context);
    bool ifalreadyliked;
    int showinsublist;
    int memberscount = userProvider.societyMembers.length;
    if (memberscount > 6)
      showinsublist = 6;
    else
      showinsublist = memberscount;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: userProvider.ifalreadylikedbyuser(
                  collectionName: "Societies",
                  collectionDocid: widget.society.uid,
                  userid: widget.user.uid),
              builder: (BuildContext context, AsyncSnapshot<bool> result) {
                if (result.data.toString() == "true") {
                  ifalreadyliked = true;
                } else
                  ifalreadyliked = false;
                return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.3,
                              width: width * 0.93,
                              child: Card(
                                elevation: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: Image(
                                    image: AssetImage("images/8.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(140, 150, 0, 0),
                              child: CircleAvatar(
                                child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: widget.society.profileimage),
                                //backgroundImage: AssetImage("images/11.png"),
                                radius: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              //  child: Card(
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                              //     ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                          child: CustomText(
                            text: widget.society.name,
                            fontWeight: FontWeight.w700,
                            size: 22,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                        //   child: CustomText(
                        //     text: "(${widget.society.type})",
                        //     fontWeight: FontWeight.w700,
                        //     size: 18,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: height * 0.07,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (ifalreadyliked)
                                        return Colors.grey;
                                      else
                                        return Colors.blue;
                                    },
                                  ),
                                ),
                                onPressed: () async {
                                  print("printing data");
                                  print(result.data);
                                  if (ifalreadyliked) {
                                    userProvider.deleteMem(
                                        collectionName: "Societies",
                                        collectionDocid: widget.society.uid,
                                        userid: widget.user.uid);
                                    setState(() {
                                      //  liked = false;
                                    });
                                  } else {
                                    await userProvider.createEventMem(
                                        collectionName: "Societies",
                                        user: widget.user,
                                        eventid: widget.society.uid);

                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.23)),
                                    Icon(Icons.group),
                                    CustomText(
                                        text: ifalreadyliked
                                            ? "  Unfollow"
                                            : "  Follow",
                                        size: 18,
                                        color: Colors.white),
                                  ],
                                )),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Container(
                        //     height: height * 0.07,
                        //     width: width * 0.9,
                        //     decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15))),
                        //     child: ElevatedButton(
                        //         onPressed: () {},
                        //         child: Row(
                        //           children: [
                        //             Padding(
                        //                 padding: EdgeInsets.only(
                        //                     left: width * 0.23)),
                        //             Icon(Icons.group),
                        //             CustomText(
                        //                 text: "  Add An Event",
                        //                 size: 18,
                        //                 color: Colors.white),
                        //           ],
                        //         )),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.04, bottom: height * 0.02),
                          child: GestureDetector(
                            onTap: () {
                              changeScreen(context, ViewSocietyMembers());
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Row(
                                    children: userProvider.societyMembers
                                        .map((item) => GestureDetector(
                                              onTap: () {
                                                changeScreen(context,
                                                    ViewSocietyMembers());
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey.shade100,
                                                child: ClipOval(
                                                  child:
                                                      FadeInImage.memoryNetwork(
                                                          placeholder:
                                                              kTransparentImage,
                                                          image: item
                                                              .profileimage),
                                                ),
                                                radius: 20,
                                              ),
                                            ))
                                        .toList()
                                        .sublist(0, showinsublist),
                                  ),
                                  if (memberscount > 6)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        text: "+" +
                                            (memberscount - 6).toString() +
                                            " Others",
                                        size: 16,
                                        color: Colors.black54,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(thickness: 2),
                        SocietyInfo(),
                        Divider(thickness: 2),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: eventProvider.events
                              .map((item) => GestureDetector(
                                    onTap: () {},
                                    child: EventFeed(
                                      event: item,
                                      useremail: widget.user.email,
                                      showhostsoc: false,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ));
              }),
        ),
      ),
    );
  }
}
