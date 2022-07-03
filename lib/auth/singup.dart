import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _hidePassword = true;
  String? _selectedDistrict;
  String? _selectedBloodType;
  final List<String> _bloodTypes = [
    'O-',
    'O+',
    'A-',
    'A+',
    'B-',
    'B+',
    'AB-',
    'AB+'
  ];
  final List<String> _districts = [
    'Hodan',
    'H/wadaag',
    'Hilwaa',
    'X/Weyne',
    'X/Jajab',
    'Shibis',
    'Shingani',
    'Abdiaziz',
    'W/Nabada',
    'Waaberi',
    'Wadajir',
    'Yaaqshid',
    'Dharkenley',
    'Kaxda',
    'Bondhere',
    'Kaaraan',
    'Daynile'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: const <Widget>[
                      Icon(
                        Icons.bloodtype,
                        size: 70,
                        color: Colors.red,
                      ),
                      Text(
                        'DhiigPlus+',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 32.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        autofillHints: const [AutofillHints.name],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          height: 2,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Full name'.toUpperCase(),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.black87,
                            // size: 20,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        // autofillHints: const [AutofillHints.telephoneNumberNational],
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          height: 2,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Phone number'.toUpperCase(),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: Colors.black87,
                            // size: 20,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
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
                                labelText: 'DISTRICT',
                                // selectedCity == null ? 'PLEASE CHOOSE' : 'DISTRICT',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 2,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              isEmpty: _selectedDistrict == null,
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  menuMaxHeight: 500,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  value: _selectedDistrict,
                                  isDense: true,
                                  onChanged: (district) {
                                    // print('New value: ${district!}');
                                    setState(() {
                                      _selectedDistrict = district;
                                    });
                                  },
                                  items: _districts
                                      .map<DropdownMenuItem<String>>(
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
                                          height: 2,
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
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      DropdownButtonHideUnderline(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            InputDecorator(
                              decoration: const InputDecoration(
                                filled: false,
                                prefixIcon: Icon(
                                  Icons.bloodtype_outlined,
                                  color: Colors.black87,
                                ),
                                labelText: 'BLOOD TYPE',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 2,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              isEmpty: _selectedBloodType == null,
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  menuMaxHeight: 500,
                                  isExpanded: false,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  value: _selectedBloodType,
                                  isDense: true,
                                  onChanged: (bloodType) {
                                    // print('New value: ${bloodType!}');
                                    setState(() {
                                      _selectedBloodType = bloodType;
                                    });
                                  },
                                  items: _bloodTypes
                                      .map<DropdownMenuItem<String>>(
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
                                          height: 2,
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
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        obscureText: _hidePassword,
                        autofillHints: const [AutofillHints.password],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          height: 2,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password'.toUpperCase(),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
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
                            icon: _hidePassword
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
                                _hidePassword = !_hidePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                        width: 350,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            // padding: MaterialStateProperty.all<EdgeInsets>(
                            //   const EdgeInsets.all(12),
                            // ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Register'.toUpperCase(),
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                        width: 350,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            // padding: MaterialStateProperty.all<EdgeInsets>(
                            //   const EdgeInsets.all(12),
                            // ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                    color: Colors.red, width: 1.6),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Log in'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.red,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
