import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/models/society.dart';
import 'package:events_app/providers/societyProvider.dart';
import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/screens/society_details.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SocietyInfoCard extends StatelessWidget {
  final SocietyModel society;
  SocietyInfoCard({required this.society});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final userprovider = Provider.of<UserProvider>(context);
    final societyprovider = Provider.of<SocietyProvider>(context);
    return GestureDetector(
      onTap: () async {
        await userprovider.loadSocietyMembers(societyid: society.uid);
        bool isadmin = await societyprovider.isadminorUser(
            uid: userprovider.varifiedUser.uid, socid: society.uid);
        changeScreen(
            context,
            SocietyDetails(
              society: society,
              user: userprovider.varifiedUser,
              isadmin: isadmin,
            ));
      },
      child: Container(
        height: height * 0.13,
        width: width * 0.95,
        child: Card(
          color: Colors.white,
          elevation: 02,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: width * 0.03)),
              CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                backgroundImage: AssetImage("images/11.png"),
                // child: FadeInImage.memoryNetwork(
                //     placeholder: kTransparentImage, image: user.profileimage),
                radius: 33,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: society.name,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: society.university + " ," + society.department,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      size: 14,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
