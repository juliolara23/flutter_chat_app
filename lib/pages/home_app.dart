import 'package:auth_firebase_app/controller/chat_controller.dart';
import 'package:auth_firebase_app/controller/chats_controller.dart';
import 'package:auth_firebase_app/controller/firestore_controller.dart';
import 'package:auth_firebase_app/model/fire_auth.dart';
import 'package:auth_firebase_app/model/validator.dart';
import 'package:auth_firebase_app/pages/firebase_central.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class MyApp extends StatelessWidget {
  // Se inicializa el contexto de firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // Constructor
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Chat',
      theme: ThemeData(
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 24.0,
            ),
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 46.0,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w500,
          ),
          bodyText1: const TextStyle(fontSize: 18.0),
        ),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            logError("error ${snapshot.error}");
            return const Wrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Get.lazyPut<Validator>(() => Validator());
            Get.lazyPut<FireAuth>(() => FireAuth());
            Get.lazyPut<FirebaseController>(() => FirebaseController());
            Get.lazyPut<ChatController>(() => ChatController());
            Get.lazyPut<ChatsController>(() => ChatsController());
            return const FirebaseCentral();
          }
          return const Loading();
        },
      )),
    );
  }
}

class Wrong extends StatelessWidget {
  const Wrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Ocurrio un error!"));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
