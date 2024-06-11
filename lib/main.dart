
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
              final user = FirebaseAuth.instance.currentUser;
              if(user?.emailVerified ?? false){
                print('you are a verified user');
              }
              else {
                print('you need to verify your email first');
              }
              print(user);
              return const Text('Done');
        default : return const Text('Loading...');
          }
         },
      )
    );
  }
}





