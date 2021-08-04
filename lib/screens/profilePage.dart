import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/screens/homePage.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String useremail;

  const ProfilePage({Key? key, required this.useremail}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userBio = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userUniversity = TextEditingController();
  TextEditingController userDepartment = TextEditingController();
  TextEditingController userPhNo = TextEditingController();
  TextEditingController userInsta = TextEditingController();
  String userDOB = "";
  String userEmail = "";
  String userid = "";
  final formkey = GlobalKey<FormState>();

  void clearControllers() {
    userBio.text = "";
    userCity.text = "";
    userDOB = "";
    userDepartment.text = "";
    userInsta.text = "";
    userName.text = "";
    userPhNo.text = "";
    userUniversity.text = "";
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Stack(children: [
                  Container(
                    width: double.maxFinite,
                    height: _size.height * 0.40,
                    color: Colors.red,
                    child: Image.asset(
                      'images/2.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                    child: Container(
                      width: double.maxFinite,
                      height: _size.height * 0.40,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.only(top: _size.height * 0.07, left: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ))),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: _size.height * 0.15),
                    child: Column(
                      children: [
                        ClipRect(
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: DottedBorder(
                              dashPattern: [6, 6],
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              strokeWidth: 2,
                              color: Colors.white,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: 'Change Image',
                            color: Colors.white,
                            size: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: _size.height * 0.30),
                    child: Container(
                      height: _size.width * 0.35,
                      width: _size.width * 0.35,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new ExactAssetImage('images/7.jpg'),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: DottedBorder(
                                dashPattern: [6, 6],
                                borderType: BorderType.RRect,
                                radius: Radius.circular(10),
                                strokeWidth: 2,
                                color: Colors.white,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: 'Change Image',
                              color: Colors.white,
                              size: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child:
                    Text('Name', style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userName,
                text: "Your Name",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child:
                    Text('Bio', style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userBio,
                maxLines: 10,
                text: "Add an Existing Bio",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child:
                    Text('City', style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userCity,
                text: "Enter Your City",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('University',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userUniversity,
                text: "Select Your University",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('Department',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userDepartment,
                text: "Select Your Department",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('Phone Number',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userPhNo,
                text: "Enter Your Phone Number",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text('Instagram ID',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              CustomTextField(
                editingController: userInsta,
                text: "Enter Your Instagram Username",
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (!await userProvider.createUser(
                                  userName.text,
                                  userCity.text,
                                  userInsta.text,
                                  userUniversity.text,
                                  userDepartment.text,
                                  "10-12-1990",
                                  userBio.text,
                                  userPhNo.text,
                                  widget.useremail.toString(),
                                  "",
                                  "",
                                  userInsta.text + "123")) {
                                print("error in adding User");
                              } else {
                                clearControllers();
                                userProvider.isvar = true;
                                changeScreenReplacement(context,
                                    HomePage(useremail: widget.useremail));
                                print("User Added");
                              }
                            }
                          },
                          child: CustomText(
                            text: "Varify",
                            fontWeight: FontWeight.bold,
                            size: 24,
                            color: Colors.white,
                          ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
