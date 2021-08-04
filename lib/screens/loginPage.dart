import 'package:events_app/auth/authentication_service.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/screens/homePage.dart';
import 'package:events_app/screens/registerPage.dart';
import 'package:events_app/widgets/botttomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.black87,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('Login',
                    style: GoogleFonts.merriweather()
                        .copyWith(color: Colors.white, fontSize: 30)),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder()),
                      validator: (value) =>
                          isEmail(value!) ? null : "Please enter a valid email",
                      onChanged: (value) => setState(() => _email = value)),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: Icon(Icons.visibility_outlined),
                        border: OutlineInputBorder()),
                    onChanged: (value) => setState(() => _password = value),
                  ),
                  SizedBox(
                    height: 40,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.black87),
                        onPressed: () {
                          context
                              .read<AuthenticationService>()
                              .signIn(email: _email, password: _password);
                          //  \

                          //   User _firebaseUser = context.watch<User>();
                          changeScreen(
                              context,
                              BottomNavBar(
                                useremail: _email,
                              ));
                        },
                        child: Text('Login')),
                  ),
                  Divider(),
                  SizedBox(
                      height: 40,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black87),
                          onPressed: () {},
                          child: Text('Login Gmail'))),
                  SizedBox(
                    height: 40,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.black87),
                        onPressed: () {},
                        child: Text('Login FaceBook')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?'),
                      TextButton(
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              ),
                          child: Text('SignUp'))
                    ],
                  ),
                  Text('Forgot Password')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
