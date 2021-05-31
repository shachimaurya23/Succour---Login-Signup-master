import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:succour/screens/welcome.dart';
import 'package:succour/widgets/widgets.dart';

class CreateNewAccount extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.4,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.user,
                      hint: 'User',
                      controller:_usernameController,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
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
                      controller: _passwordController,
                      inputAction: TextInputAction.next,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Confirm Password',
                      controller:_repasswordController,
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(buttonName: 'Register'),
                    onPressed: ()async{
                    try{
                      FirebaseUser user = (await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailContoller.text,
                        password: _passwordController.text,)).user;
                      if(user!=null) {
                        UserUpdateInfo updateUser = UserUpdateInfo();
                        updateUser.displayName = _usernameContoller.text;
                        user.updateProfile(updateUser);
                        Navigator.of(context).pushNamed(WelcomePage);
                      }
                    }catch(e){
                      print(e);
                      _usernameController.text="";
                      _passwordContoller.text="";
                      _repasswordController.text="";
                      _emailController.text="";
                    }
                    }
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                          )
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'Login');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
  }
}