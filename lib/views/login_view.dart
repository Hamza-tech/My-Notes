// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;


  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context,snapshot) { 
          switch(snapshot.connectionState){
            
            // case ConnectionState.none:
            //   break;
            //   case ConnectionState.waiting:
            //   break;
            //   case ConnectionState.active:
            //   break;
              case ConnectionState.done:
              return Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                hintText: 'Enter Your Email'
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter Your Password'
              ),
            ),
            TextButton(
               onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                // ignore: unused_local_variable
                final userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

                } on FirebaseAuthException catch (e) {
                  if(e.code == 'user-not-found'){
                    // ignore: avoid_print
                    print('No user found for that email.');
                  }
                  else {
                    // ignore: avoid_print
                    print('something else happened');
                    // ignore: avoid_print
                    print(e.code);
                  }
                }
                // catch (e) {
                //   print('something bad happen');
                //   print(e);
                // }
               },
               child: const Text('Login'),
               ),
          ],
        );
        default : return const Text('Loading...');
          }
         },
      )
    );
  }

  
}