import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:supportpro/Screens/Home/home_page.dart';
import 'package:supportpro/Screens/Login/components/background.dart';
import 'package:supportpro/Screens/Myprofile/myprofile.dart';
import 'package:supportpro/Screens/Signup/signup_screen.dart';
import 'package:supportpro/components/already_have_an_account_acheck.dart';
import 'package:supportpro/components/rounded_button.dart';
import 'package:supportpro/components/rounded_input_field.dart';
import 'package:supportpro/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supportpro/globals.dart';
import 'package:http/http.dart' as http;

class PasswordLoginPage extends StatefulWidget {
  const PasswordLoginPage({
    Key key,
  }) : super(key: key);

  @override
  _PasswordLoginPageState createState() => _PasswordLoginPageState();
}

class _PasswordLoginPageState extends State<PasswordLoginPage> {
  String username, password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                username = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () => verifyUser(username, password),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController textController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final requiredValidator =
      RequiredValidator(errorText: 'This field is Required');

  verifyUser(String username, String password) async {
    print(username);
    print(password);
    setState(() {
      Loader.show(context,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ));
    });
    var url = Global.server + '/method/login';
    Map data = {'usr': username, 'pwd': password};

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };
    var response = await http.post(url, body: data, headers: requestHeaders);
    print(response.body);
    // navigateToHome(response);
    Loader.hide();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ProfilePage();
        },
      ),
    );
  }
}
