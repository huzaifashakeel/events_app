import 'dart:io';
import 'package:events_app/firebase%20torage/firebase_storage.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/models/user.dart';
import 'package:events_app/providers/societyProvider.dart';
import 'package:events_app/screens/homePage.dart';
import 'package:events_app/screens/loading.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/customtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateSociety extends StatefulWidget {
  // final User user;
  final UserModel userModel;

  const CreateSociety({Key? key, required this.userModel}) : super(key: key);

  @override
  _CreateSocietyState createState() => _CreateSocietyState();
}

class _CreateSocietyState extends State<CreateSociety>
    with TickerProviderStateMixin {
  String societytype = "  Common";
  String department = "  Electrical";

  final formkey = GlobalKey<FormState>();
  TextEditingController societyname = TextEditingController();
  TextEditingController societyuniversity = TextEditingController();
  TextEditingController goals = TextEditingController();
  TextEditingController societydescription = TextEditingController();
  String adminName = "";
  String adminUID = "";
  String type = "";
  clearControllers() {
    societyname.text = "";
    societydescription.text = "";
    societyuniversity.text = "";
    goals.text = "";
  }

  // ignore: avoid_init_to_null
  XFile? _image = null;
  late ImagePicker imagePicker = ImagePicker();
  getImage(bool isCamera) async {
    XFile? image;
    try {
      if (isCamera) {
        image = await imagePicker.pickImage(source: ImageSource.camera);
      } else {
        image = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image;
          print(_image);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final societyProvider = Provider.of<SocietyProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: height * 0.3,
                        width: width,
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
                        padding: EdgeInsets.fromLTRB(
                            width * 0.3, height * 0.21, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            print("picking image");
                            getImage(false);
                          },
                          child: CircleAvatar(
                            child: ClipOval(
                              child: _image == null
                                  ? Image.asset("images/13.jpg")
                                  : Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                      height: height * 0.2,
                                      width: width * 0.34,
                                    ),
                            ),
                            // backgroundImage: AssetImage("images/7.jpg"),
                            radius: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "Society Name",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      )
                    ],
                  ),
                  CustomTextField(
                      text: "Enter Society Name",
                      editingController: societyname),
                  Row(
                    children: [
                      CustomText(
                        text: "Society Description",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      )
                    ],
                  ),
                  CustomTextField(
                      text: "Enter Society Description",
                      editingController: societydescription),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, height * 0.015, 0, height * 0.015),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Type",
                          fontWeight: FontWeight.w700,
                          size: 16,
                        ),
                        Padding(padding: EdgeInsets.only(left: width * 0.48)),
                        Card(
                          color: Colors.grey.shade200,
                          child: DropdownButton<String>(
                            value: societytype,
                            onChanged: (String? newValue) {
                              setState(() {
                                societytype = newValue!;
                              });
                            },
                            items: <String>[
                              '  Common',
                              '  Technology',
                              '  Tours',
                              '  Cultural'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: CustomText(
                                  text: value,
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "University",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      )
                    ],
                  ),
                  CustomTextField(
                      text: "Select Your UNiversity",
                      editingController: societyuniversity),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, height * 0.015, 0, height * 0.015),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Department",
                          fontWeight: FontWeight.w700,
                          size: 16,
                        ),
                        Padding(padding: EdgeInsets.only(left: width * 0.33)),
                        Card(
                          color: Colors.grey.shade200,
                          child: DropdownButton<String>(
                            value: department,
                            onChanged: (String? newValue) {
                              setState(() {
                                department = newValue!;
                              });
                            },
                            items: <String>[
                              '  CS',
                              '  Electrical',
                              '  Civil',
                              '  Mechenical'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: CustomText(
                                  text: value,
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "Society Goals",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      )
                    ],
                  ),
                  CustomTextField(
                    text: "Enter Your Goals",
                    editingController: goals,
                    textype: TextInputType.multiline,
                    height: 150,
                    maxLines: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, height * 0.015, 0, height * 0.015),
                    child: Container(
                        height: height * 0.07,
                        width: width * 0.5,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                String profileimageurl = await uploadPic(
                                    imagefile: File(_image!.path));
                                print("UPloading Society Data");
                                if (!await societyProvider.createSociety(
                                    societyname.text,
                                    societydescription.text,
                                    societyuniversity.text,
                                    goals.text,
                                    societytype,
                                    department,
                                    DateTime.now(),
                                    widget.userModel.name,
                                    widget.userModel.uid,
                                    profileimageurl,
                                    "")) {
                                  print("error in adding society");
                                } else {
                                  clearControllers();
                                  changeScreen(
                                      context,
                                      HomePage(
                                          useremail: widget.userModel.email));
                                  print("Society Added");
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
          ),
        ),
      ),
    );
  }
}
