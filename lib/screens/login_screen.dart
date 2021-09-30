import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/round_buttons.dart';
import 'package:flash_chat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';



class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email ;
  String password;
  bool showSpin = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(color: Colors.lightBlueAccent, text: 'Log In', navigate: ()async {
                setState(() {
                  showSpin = true;
                });
                try{
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if (user != null){
                    Navigator.pushNamed(context, ChatScreen.id);
                    setState(() {
                      showSpin = false;
                    });
                  }
                }
                catch(e){
                  setState(() {
                    showSpin = false;
                  });
                  if(e.code == 'user-not-found'){
                    print('Wrong user name');
                  }
                  else if( e.code == 'wrong-passwrod'){
                    print('wrong passwrod for given email');
                  }
                }

              },),
            ],
          ),
        ),
      ),
    );
  }
}
