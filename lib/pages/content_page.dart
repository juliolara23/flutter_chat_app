// Widget para el manejo principal si tengo sesion o debo iniciar sesion
import 'package:auth_firebase_app/model/fire_auth.dart';
import 'package:auth_firebase_app/pages/chat_page.dart';
import 'package:auth_firebase_app/pages/chats_page.dart';
import 'package:auth_firebase_app/pages/firestore_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  // Atributo
  int _selectIndex = 0;
  // Controlador de autenticacion
  FireAuth authenticationController = Get.find();
  // Listado de Widgets a mostrar
  static final List<Widget> _widgets = <Widget>[
    const FireStorePage(),
    const ChatPage(),
    const ChatsPage()
  ];

  // Metodo para realizar cambio de Widget
  _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  // Metodo para finalizar sesion
  _logout() async {
    try {
      await authenticationController.logOut();
    } catch (e) {
      logError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authenticationController.userEmail()),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: _widgets.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Datos"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
