import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/member_infoCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewEventFollowers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomText(
                text: "Who is Going ?",
                size: 20,
                fontWeight: FontWeight.bold,
                letterspacing: 5,
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: userProvider.eventparticipants
                    .map((e) => GestureDetector(
                          onTap: () {},
                          child: MemberInfo(
                            user: e,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
