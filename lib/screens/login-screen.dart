import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:succour/screens/screens.dart';
import 'package:succour/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    'Succour',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInputField(
                    icon: FontAwesomeIcons.envelope,
                    hint: 'Email',
                    controller:_emailController,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  PasswordInput(
                    icon: FontAwesomeIcons.lock,
                    hint: 'Password',
                    controller:_passwordController,
                    inputAction: TextInputAction.done,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  RoundedButton(
                    buttonName: 'Login',
                  ),
                  onPressed: () async {
                  try {
                  FirebaseUser user =
                  (await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                  ))
                      .user;
                  if (user != null) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('displayName', user.displayName);
                  Navigator.of(context).pushNamed(WelcomePage);
                  }
                  } catch (e) {
                  print(e);
                  _emailController.text = "";
                  _passwordController.text = "";

                  }
                  SizedBox(
                    height: 45,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
                child: Container(
                  child: Text(
                    'New User ? Create an account',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.5),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        );
  }
}