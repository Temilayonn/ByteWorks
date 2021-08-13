import 'package:byteinc/screens/sign_in.dart';
import 'package:byteinc/screens/sign_up.dart';
import 'package:byteinc/utilities/constants.dart';
import 'package:byteinc/utilities/onboarding_data.dart';
import 'package:byteinc/utilities/transformers/transformer.dart';
import 'package:byteinc/widgets/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);
  final String title, subtitle, image;
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  late String bgImg;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final TransformerPageController controller =
    //     TransformerPageController(initialPage: 0);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: TransformerPageView(
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        transformer: Transformer(),
        scrollDirection: Axis.horizontal,
        // pageController: controller,
        curve: Curves.easeInBack,
        itemCount: Data.subtitle.length,
        itemBuilder: (context, index) {
          final title = Data.title[index];
          final subTitle = Data.subtitle[index];
          final urlImage = Data.image[index];
          return Container(
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey[900],
              image: DecorationImage(
                image: AssetImage(urlImage),
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    Data.subtitle.length,
                    (index) => buildDot(
                      index: index,
                      isActive: null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white70,
                  ),
                  // textAlign: TextAlign.left,
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: buttonWidget(
                          buttonText: "Get Started",
                          buttonColor: Colors.blue,
                          buttonAction: () {
                            Navigator.pushReplacement(
                              context,
                              CustomPageRoute(
                                child: SignUp(),
                                direction: AxisDirection.left,
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
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
                                text: 'Have an account already?',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              TextSpan(
                                text: (' Sign In '),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AnimatedContainer buildDot({int? index, bool? isActive}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 2),
      margin: EdgeInsets.only(right: 9),
      // duration: kAnimationDuration,
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
