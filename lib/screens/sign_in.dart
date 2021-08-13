import 'package:another_flushbar/flushbar.dart';
import 'package:byteinc/screens/home_screen.dart';
import 'package:byteinc/screens/sign_up.dart';
import 'package:byteinc/utilities/constants.dart';
import 'package:byteinc/widgets/custom_page_route.dart';
import 'package:byteinc/widgets/form_errors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isPassHidden = true;
  final emailControllerr = TextEditingController();
  final passwordController = TextEditingController();
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

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

  @override
  Widget build(BuildContext context) {
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
                    "Sign in \nto your account",
                    style: TextStyle(
                      // letterSpacing: 1.5,
                      fontSize: 24,
                      color: Color(0xFF10151A),
                      fontWeight: FontWeight.w700,
                    ),
                    //  textAlign: TextAlign.center,
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xffecf5ec),
                    child: Icon(
                      Icons.person,
                      size: 27,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 48,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    formTextTitle("Email Address"),
                    SizedBox(height: 20),
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
                      onChange: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            errors.add(kEmailNullError);
                          });
                          return "Please enter valid email";
                        }
                      },
                      onSave: (newValue) => _email = newValue,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    formTextTitle("Password"),
                    SizedBox(height: 20),
                    buildPasswordTextFormField(
                        text: "Enter Password",
                        onSave: (newValue) => _password = newValue,
                        onChange: (value) =>
                            value.isEmpty ? 'Please enter password' : null,
                        validate: (value) =>
                            value.isEmpty ? 'Please enter password' : null,
                        togglePasswordView: () {
                          setState(() {
                            _isPassHidden = !_isPassHidden;
                          });
                        },
                        textInputType: TextInputType.visiblePassword,
                        pass: _isPassHidden),
                    FormError(
                      errors: errors,
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   CustomPageRoute(
                          //     child: ResetPassword(),
                          //     direction: AxisDirection.up,
                          //   ),
                          // );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF819272),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: buttonWidget(
                        buttonText: "Login",
                        buttonColor: Colors.blue,
                        buttonAction: () { Navigator.push(
                          context,
                          CustomPageRoute(
                            child: HomeScreen(),
                            direction: AxisDirection.down
                            ,
                          ),
                        );},
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            child: SignUp(),
                            direction: AxisDirection.right,
                          ),
                        );
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Don\'t have an account?',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff999999),
                                    letterSpacing: 1),
                              ),
                              TextSpan(
                                text: (' Sign Up'),
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
            ],
          ),
        ),
      ),
    );
  }
}
