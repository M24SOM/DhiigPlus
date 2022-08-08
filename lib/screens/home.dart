import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhiigplus/constants/colors.dart';
import 'package:dhiigplus/global/global.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> requests =
        FirebaseFirestore.instance.collection('Requests').snapshots();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Donate'),
          centerTitle: true,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: requests,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            final requestsData = snapshot.data!;
            print(requestsData);
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  elevation: 1,
                  shadowColor: Colors.red,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: 350,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Color(0xff67727d)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data["name"],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                // onlineDriverData.email!,

                                data["date"].toDate().toString().split(' ')[0],
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Location",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          Text(
                            data["district"],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Blood Type",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Color(0xff67727d)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data['bloodType'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: TextButton(
                                    onPressed: () {
                                      customLaunch(
                                          'tel:+252${data['phoneNumber']}');
                                    },
                                    child: const Text(
                                      'Donate',
                                      style: TextStyle(color: primary),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}

customLaunch(command) async {
  if (await canLaunchUrl(Uri.parse(command))) {
    await launchUrl(Uri.parse(command));
  } else {
    print('could not launch $command');
  }
}
