import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _UserNameContorller = TextEditingController();
  final bloodTypeController = TextEditingController();
  final _PhoneContorller = TextEditingController();
  final _controller = TextEditingController();

  @override
  void dispose() {
    bloodTypeController.dispose();
    _PhoneContorller.dispose();
    _UserNameContorller.dispose();
    // _lastNameContorller.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.pinkAccent,
                    width: 1.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("images/logo.jpg"),
                )),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 18,
            ),

            // hellow again
            const Text(
              'DhiigPlus+',
              style: TextStyle(
                color: Colors.red,
                fontSize: 32.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 40,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 254, 254),
                  border:
                      Border.all(color: const Color.fromARGB(255, 230, 8, 8)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: TextField(
                    enabled: false,
                    controller: _UserNameContorller,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name or Username',
                        prefixIcon: Icon(Icons.person, color: Colors.red),
                        fillColor: Color(0x00000064)),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  border:
                      Border.all(color: const Color.fromARGB(255, 236, 18, 18)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: TextField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.red,
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 255, 247, 247),
                    border: Border.all(
                        color: const Color.fromARGB(255, 223, 21, 21)),
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 250, 250, 248)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: TextField(
                    enabled: false,
                    controller: bloodTypeController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Blood Type',
                        prefixIcon: Icon(
                          Icons.bloodtype,
                          color: Colors.red,
                        ),
                        // prefixIcon: Icon(Icons.email),
                        fillColor: Color(0x00000064)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
