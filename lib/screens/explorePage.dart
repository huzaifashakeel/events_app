import 'package:events_app/providers/eventProvider.dart';
import 'package:events_app/providers/societyProvider.dart';
import 'package:events_app/providers/userProvider.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/eventExplore_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  final String useremail;

  const ExplorePage({Key? key, required this.useremail}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final eventprovider = Provider.of<EventProvider>(context);
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CustomText(
            text: "Explore",
            size: 20,
            fontWeight: FontWeight.bold,
            letterspacing: 5,
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CupertinoSearchTextField(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
                childAspectRatio: (_width * 0.45) / (_width * 0.64),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 2,
                physics: ScrollPhysics(),
                children: eventprovider.events
                    .map((item) => EventExploreWidget(
                          event: item,
                          useremail: widget.useremail,
                        ))
                    .toList()),
          ),
        ),
      ])),
    );
  }
}
