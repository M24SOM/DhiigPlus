import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';

class FindDonor extends StatefulWidget {
  const FindDonor({Key? key}) : super(key: key);

  @override
  State<FindDonor> createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  CollectionReference requests =
      FirebaseFirestore.instance.collection('Requests');

  Future requestDonation() async {
    return requests
        .add({
          'hospital': selectedhospital,
          'district': selectedDistrict,
          'bloodType': selectedBloodType,
          'date': selectedDate,
          'name': 'Shirwac',
        })
        .then((value) => print("Request Added $value"))
        .catchError((error) => print("Failed to add Request: $error"));

    // await FirebaseFirestore.instance.collection('Requests').add({
    //   'hospital': selectedhospital,
    //   'district': selectedDistrict,
    //   'bloodType': selectedBloodType,
    //   'date': selectedDate,
    //   'name': 'Shirwac',
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Find Donor'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 40),
              child: Column(
                children: [
                  DropdownButtonHideUnderline(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        InputDecorator(
                          decoration: const InputDecoration(
                            filled: false,
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.black87,
                            ),
                            labelText: 'CHOOSE DISTRECT',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 201, 13, 13),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              height: 2,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          isEmpty: selectedDistrict == null,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              menuMaxHeight: 500,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              value: selectedDistrict,
                              isDense: true,
                              onChanged: (district) {
                                setState(() {
                                  selectedDistrict = district;
                                });
                              },
                              items: districts.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      // height: 0,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        InputDecorator(
                          decoration: const InputDecoration(
                            filled: false,
                            prefixIcon: Icon(
                              Icons.local_hospital,
                              color: Colors.black87,
                            ),
                            labelText: 'Select Hospital',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 247, 3, 3),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              height: 2,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          isEmpty: selectedhospital == null,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              menuMaxHeight: 500,
                              isExpanded: false,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              value: selectedhospital,
                              isDense: true,
                              onChanged: (hospital) {
                                setState(() {
                                  selectedhospital = hospital;
                                });
                              },
                              items: hospital.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      // height: 2,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  DropdownButtonHideUnderline(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        InputDecorator(
                          decoration: const InputDecoration(
                            filled: false,
                            prefixIcon: Icon(
                              Icons.local_hospital,
                              color: Colors.black87,
                            ),
                            labelText: 'SELECT Blood',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 247, 3, 3),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              height: 2,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          isEmpty: selectedBloodType == null,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              menuMaxHeight: 500,
                              isExpanded: false,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              value: selectedBloodType,
                              isDense: true,
                              onChanged: (bloodType) {
                                setState(() {
                                  selectedBloodType = bloodType;
                                });
                              },
                              items: bloodTypes.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      // height: 2,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // PASSWORD
                  TextFormField(
                    autofillHints: const [AutofillHints.password],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      height: 2,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Add Notes'.toUpperCase(),
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 253, 31, 31),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                        color: Colors.black87,
                        // size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: hidePassword
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.black54,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.black87,
                              ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  // District

                  const SizedBox(height: 20),
                ],
              ),
            ),
            // FULL NAME

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    width: 255,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        requestDonation();
                      },
                      child: Text(
                        'POST'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
          ],
        ),
      ),
    );
  }
}
