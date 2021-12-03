import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FireAuth extends GetxController {
  Future<User?> registerUsingEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("El password que coloco es inseguro");
      } else if (e.code == 'email-already-in-use') {
        print("El email proporcionado ya esta en uso");
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<User?> singIngUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    User? user;
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("El email proporcionado no fue encontrado");
      } else if (e.code == 'wrong-password') {
        print("El email proporcionado esta incorrecto");
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  // Metodo encargado de retornar el email del usuario conectado
  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }

  // Metodo encargado de retornar el identificador unico del usuario conectado
  String getUid() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
  }

  // Metodo encargado de cerrar la sesion
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
