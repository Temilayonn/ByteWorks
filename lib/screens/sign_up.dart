

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:byteinc/models/user.dart';
import 'package:byteinc/screens/sign_in.dart';
import 'package:byteinc/utilities/constants.dart';
import 'package:byteinc/widgets/custom_page_route.dart';
import 'package:byteinc/widgets/form_errors.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPassHidden = true;
  bool _isConfirmPassHidden = true;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'Choose gender';
  var items = ['Choose gender', 'Male', 'Female', 'Other'];
  late String _email;
  late String _password;
  late String _confirmPassword;
  late String _firstName;
  late String _lastName;
  late String _houseAddress;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  late File _image;
  late String imagePath;
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      imagePath = image.path;
      _image = image;
      imageAdded = true;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      imagePath = image.path;
      imageAdded = true;
      _image = image;
    });
  }

  bool imageAdded = false;
  removeImage() {
    setState(() {
      imageAdded = false;
      _image = "" as File;
    });
  }



  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text(" Registering ... Please wait")
    ],
  );
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  late User user;

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);
    //
    // VoidCallback doRegister = () {
    //   print('on doRegister');
    //
    //   final form = _formKey.currentState;
    //   if (form.validate()) {
    //     form.save();
    //
    //     auth.registeredInStatus = Status.Authenticating;
    //     auth.notify();
    //
    //     if (_password.endsWith(_confirmPassword)) {
    //       auth
    //           .register(
    //           _email, _password, _confirmPassword, _firstName, _lastName)
    //           .then((response) {
    //         // auth.register().then((response) {
    //         if (response['status']) {
    //           print(response['status']);
    //           User user = response['data'];
    //
    //           Provider.of<UserProvider>(context, listen: false).setUser(user);
    //           Navigator.push(
    //             context,
    //             CustomPageRoute(
    //               child: SignIn(),
    //               direction: AxisDirection.left,
    //             ),
    //           );
    //         } else {
    //           auth.registeredInStatus = Status.NotRegistered;
    //           auth.notify();
    //           Flushbar(
    //             title: 'Registration fail',
    //             message: response.toString(),
    //             duration: Duration(seconds: 10),
    //           ).show(context);
    //         }
    //       });
    //     } else {
    //       auth.registeredInStatus = Status.NotRegistered;
    //       auth.notify();
    //       Flushbar(
    //         title: 'Mismatch password',
    //         message: 'Please enter valid confirm password',
    //         duration: Duration(seconds: 10),
    //       ).show(context);
    //     }
    //   } else {
    //     auth.registeredInStatus = Status.NotRegistered;
    //     auth.notify();
    //     Flushbar(
    //       title: 'Invalid form',
    //       message: 'Please complete the form properly',
    //       duration: Duration(seconds: 10),
    //     ).show(context);
    //   }
    // };
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create \nyour account",
                    style: TextStyle(
                      // letterSpacing: 1.5,
                      fontSize: 24,
                      color: Color(0xFF10151A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          // radius: 65,
                          // backgroundImage: _image != null
                          //     ? FileImage(
                          //   _image,
                          // )
                          //     : CircleAvatar(),
                        ),
                        Positioned(
                          top: 10,
                          right: 110,
                          child: InkWell(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white, width: 3),
                                  color: Color(0xff979797)),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.photo_camera

                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    formTextTitle("First Name"),
                    SizedBox(height: 10),
                    buildTextFormField(
                      validate: (value) =>
                          value.isEmpty ? 'Please enter first name' : null,
                      pass: false,
                      text: "First Name",
                      onSave: (val) => _firstName = val,
                      textInputType: TextInputType.name,
                      onChange: (String) {},
                    ),
                    SizedBox(height: 20),
                    formTextTitle("Last Name"),
                    SizedBox(height: 10),
                    buildTextFormField(
                      validate: (value) =>
                          value.isEmpty ? 'Please enter last name' : null,
                      pass: false,
                      text: "Last Name",
                      onSave: (val) => _lastName = val,
                      onChange: (String) {},
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(height: 20),
                    formTextTitle("Email Address"),
                    SizedBox(height: 10),
                    buildTextFormField(
                        pass: false,
                        text: "Email Address",
                        validate: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              errors.add(kEmailNullError);
                            });
                            return "Please enter valid email";
                          }
                        },
                        // onChange: (value) {
                        //   if (value.isEmpty ||
                        //       !emailvalidatorRegExp.hasMatch(value)) {
                        //     setState(() {
                        //       errors.add(kEmailNullError);
                        //     });
                        //     return "Please enter valid email";
                        //   }
                        // },
                        onChange: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              errors.add(kEmailNullError);
                            });
                            return "Please enter valid email";
                          }
                        },
                        onSave: (newValue) => _email = newValue,
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: 20),
                    formTextTitle("House Address"),
                    SizedBox(height: 10),
                    buildTextFormField(
                      validate: (value) =>
                          value.isEmpty ? 'Please enter address' : null,
                      pass: false,
                      text: "House Address",
                      onSave: (val) => _lastName = val,
                      onChange: (String) {},
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(height: 20),
                    DropdownButton(
                      isExpanded: true,
                      value: dropdownvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(
                          () {
                            dropdownvalue = dropdownvalue;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    CSCPicker(
                      ///Enable disable state dropdown [OPTIONAL PARAMETER]
                      showStates: true,

                      /// Enable disable city drop down [OPTIONAL PARAMETER]
                      showCities: false,

                      ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                      ),

                      ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)

                      ///selected item style [OPTIONAL PARAMETER]
                      selectedItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                      dropdownHeadingStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),

                      ///DropdownDialog Item style [OPTIONAL PARAMETER]
                      dropdownItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///Dialog box radius [OPTIONAL PARAMETER]
                      dropdownDialogRadius: 10.0,

                      ///Search bar radius [OPTIONAL PARAMETER]
                      searchBarRadius: 10.0,

                      ///Default Country [OPTIONAL PARAMETER]
                     // defaultCountry: DefaultCountry.Nigeria,

                      ///triggers once country selected in dropdown
                      onCountryChanged: (value) {
                        setState(() {
                          ///store value in country variable
                          countryValue = value;
                        });
                      },

                      ///triggers once state selected in dropdown
                      onStateChanged: (value) {
                        setState(() {
                          ///store value in state variable
                          stateValue = value!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'd MMM, yyyy',
                       initialValue: 'DD MMM, yyyy',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date of Birth',
                      dateHintText: 'Select date',
                      // timeLabelText: "Hour",
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }

                        return true;
                      },
                      onChanged: (val) => print(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              formTextTitle("Password"),
              SizedBox(height: 10),
              buildPasswordTextFormField(
                  text: "Enter Password",
                  onSave: (newValue) => _password = newValue,
                  onChange: (value) => value.isEmpty
                      ? 'Please enter password'
                      : _password = value,
                  validate: (value) =>
                      value.isEmpty ? 'Please enter password' : null,
                  togglePasswordView: () {
                    setState(() {
                      _isPassHidden = !_isPassHidden;
                    });
                  },
                  textInputType: TextInputType.visiblePassword,
                  pass: _isPassHidden),
              SizedBox(height: 20),
              formTextTitle("Confirm Password"),
              SizedBox(height: 20),
              buildPasswordTextFormField(
                text: "Confirm Password",
                onSave: (newValue) => _confirmPassword = newValue,
                togglePasswordView: () {
                  setState(
                    () {
                      _isConfirmPassHidden = !_isConfirmPassHidden;
                    },
                  );
                },
                textInputType: TextInputType.visiblePassword,
                pass: _isConfirmPassHidden,
                onChange: (String) {},
                validate: (String) {},
              ),
              SizedBox(
                height: 24,
              ),
              FormError(errors: errors),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: buttonWidget(
                  buttonText: "Create Account",
                  buttonColor: Colors.blue,
                  buttonAction: () {},
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      child: SignIn(),
                      direction: AxisDirection.left,
                    ),
                  );
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Have an account?',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff999999),
                              letterSpacing: 1),
                        ),
                        TextSpan(
                          text: (' Sign In'),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                imageAdded
                    ? new ListTile(
                  leading: new Icon(Icons.cancel),
                  title: new Text('Remove Image'),
                  onTap: () {
                    removeImage();
                    Navigator.of(context).pop();
                  },
                )
                    : ListTile(),
              ],
            ),
          ),
        );
      },
    );
  }

}

// log().debug(response);
