import 'dart:ui';

import 'package:events_app/models/user.dart';
import 'package:events_app/providers/societyProvider.dart';
import 'package:events_app/screens/loading.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/society_infoCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowUserProfile extends StatefulWidget {
  final UserModel userModel;

  const ShowUserProfile({Key? key, required this.userModel}) : super(key: key);

  @override
  _ShowUserProfileState createState() => _ShowUserProfileState();
}

class _ShowUserProfileState extends State<ShowUserProfile> {
  bool showmore = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final socProvider = Provider.of<SocietyProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "images/14.jpg",
                    height: height * 0.35,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5),
                      child: Container(
                        width: width,
                        height: height * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, height * 0.06, width * 0.5, 0),
                    child: Center(
                      child: CircleAvatar(
                        radius: 72,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          radius: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Stack(
                              children: [
                                Loading(),
                                ClipOval(
                                  child: Center(
                                    child: FadeInImage.memoryNetwork(
                                        fit: BoxFit.fill,
                                        height: height * 0.23,
                                        width: width * 0.4,
                                        placeholder: kTransparentImage,
                                        image: widget.userModel.profileimage),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // radius: 40,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(width * 0.8, height * 0.12, 0, 0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 30,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.call),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(width * 0.6, height * 0.12, 0, 0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 30,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.message),
                        onPressed: () {},
                      ),
                    ),
                  ),

                  //     Container(
                  //       height: height * 0.32,
                  //       width: width,
                  //       decoration: BoxDecoration(
                  //           gradient: LinearGradient(
                  //               begin: Alignment.topLeft,
                  //               end: Alignment.topRight,
                  //               colors: [
                  //             //                        Colors.black.withOpacity(0.5),
                  //             Colors.black.withOpacity(0.2),
                  //             Colors.black.withOpacity(0.1),
                  //             Colors.black.withOpacity(0.05),
                  //             Colors.black.withOpacity(0.07),
                  //           ])),
                  //       child: Column(
                  //         children: [
                  //           Padding(padding: EdgeInsets.only(top: height * 0.04)),
                  //           Center(
                  //             child: CircleAvatar(
                  //               radius: 43,
                  //               backgroundColor: Colors.grey,
                  //               child: CircleAvatar(
                  //                 radius: 40,
                  //                 child: ClipRRect(
                  //                   borderRadius: BorderRadius.circular(30),
                  //                   child: Stack(
                  //                     children: [
                  //                       Loading(),
                  //                       FadeInImage.memoryNetwork(
                  //                           fit: BoxFit.fill,
                  //                           height: height * 0.15,
                  //                           placeholder: kTransparentImage,
                  //                           image: widget.userModel.profileimage),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 // radius: 40,
                  //               ),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  //             child: CustomText(
                  //               text: widget.userModel.name,
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           CustomText(
                  //             text: widget.userModel.bio,
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold,
                  //             size: 14,
                  //           ),
                  //           TextButton(
                  //               onPressed: () {
                  //                 setState(() {
                  //                   showmore = !showmore;
                  //                 });
                  //               },
                  //               child: CustomText(
                  //                 text: showmore ? "Show less" : "Show More",
                  //                 size: 12,
                  //               ))
                  //         ],
                  //       ),
                  //     ),
                  //     IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))
                ],
              ),
              Container(
                height: height * 0.13,
                child: Stack(
                  children: [
                    Image.asset(
                      "images/15.jpg",
                      fit: BoxFit.cover,
                      width: width,
                    ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10),
                        child: Container(
                          width: width,
                          height: height * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CustomText(
                                text: widget.userModel.name,
                                color: Colors.black,
                                size: 26,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: widget.userModel.bio,
                                color: Colors.black,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.35,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            child: CustomText(
                              text: showmore ? "show less" : "show more",
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              setState(() {
                                showmore = !showmore;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              if (showmore)
                Container(
                  height: height * 0.35,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.layers,
                                color: Colors.white,
                              ),
                              Padding(padding: EdgeInsets.only(left: 15)),
                              CustomText(
                                text: widget.userModel.university +
                                    " , " +
                                    widget.userModel.department,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_ic_call,
                                color: Colors.white,
                              ),
                              Padding(padding: EdgeInsets.only(left: 15)),
                              CustomText(
                                text: widget.userModel.phonenumser,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.fmd_good_rounded,
                                color: Colors.white,
                              ),
                              Padding(padding: EdgeInsets.only(left: 15)),
                              CustomText(
                                text: widget.userModel.address,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.facebook,
                                color: Colors.white,
                              ),
                              Padding(padding: EdgeInsets.only(left: 15)),
                              CustomText(
                                text: "huzaifashakeel_",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Liked Socities",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: socProvider.socities
                    .map((item) => GestureDetector(
                          onTap: () {},
                          child: SocietyInfoCard(
                            society: item,
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
