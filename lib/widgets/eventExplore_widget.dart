import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/models/event.dart';
import 'package:events_app/providers/societyProvider.dart';
import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/screens/eventDetails.dart';
import 'package:events_app/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class EventExploreWidget extends StatelessWidget {
  final EventModel event;
  final String useremail;

  const EventExploreWidget(
      {Key? key, required this.event, required this.useremail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    final userprovider = Provider.of<UserProvider>(context);
    final societyProvider = Provider.of<SocietyProvider>(context);

    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (!userprovider.isvar) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'You Must complete your information to view Event Details'),
                      ));
                    } else {
                      await userprovider.getuserbyid(uid: event.hostuid.trim());

                      await societyProvider.getSocietybyid(
                          id: event.hostsocietyid);
                      if (userprovider.isvar) {
                        await userprovider.getVarifiedUser(email: useremail);
                      }

                      changeScreen(
                          context,
                          EventDetails(
                            event: event,
                            eventhost: userprovider.eventhost,
                            user: userprovider.varifiedUser,
                            eventhostSociety: societyProvider.eventhostsociety,
                            showhostsoc: true,
                          ));
                    }
                  },
                  child: Container(
                      height: _height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Colors.amber,
                      ),
                      child: Stack(
                        children: [
                          Loading(),
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: this.event.image,
                            height: _height * 0.2,
                            //height: 200,
                            fit: BoxFit.fill,
                            // width: double.infinity,
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Chip(
                      label: Text(
                        'Online',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black87,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 5, right: 5),
              title: Text(event.name),
              dense: true,
              isThreeLine: true,
              subtitle: Text(
                event.location,
              ),
            )
          ],
        ),
      ),
    );
  }
}
