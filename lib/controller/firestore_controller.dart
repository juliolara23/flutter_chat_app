// Controlador para manejo de datos
import 'dart:async';

import 'package:auth_firebase_app/model/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class FirebaseController extends GetxController {
  // Variable reactiva
  final _records = <Record>[].obs;
  // Instancia de base de datos
  final CollectionReference baby =
      FirebaseFirestore.instance.collection('baby');
  // Instancia de manejo de base de datos
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('baby').snapshots();
  // Subscripcion cambio de objetos
  late StreamSubscription<Object?> streamSubscription;
  // Getters
  List<Record> get entries => _records;

  // Metodo para sensar cambios en los datos subscritos
  suscribeUpdates() async {
    logInfo('Inicio de subscripciones');
    streamSubscription = _usersStream.listen((event) {
      logInfo('Se obtuvo un nuevo registro de fireStore');
      _records.clear();
      for (var element in event.docs) {
        _records.add(Record.fromSnapshot(element));
      }
      logInfo('Se obtuvieron ${_records.length} registros');
    });
  }

  // Metodo para detener subscripciones
  unsuscribeUpdates() {
    streamSubscription.cancel();
  }

  // Metodo para crear un nuevo registro
  addEntry(name) {
    baby
        .add({'name': name, 'votes': 0})
        .then((value) => logInfo("Bebe adicionado"))
        .catchError(
            (onError) => logError("Fallo al agregar un nuevo bebe $onError"));
  }

  // Metodo para actualizar un registro
  updateEntry(Record record) {
    record.reference.update({'votes': record.votes + 1});
  }

  // Metodo para eliminar un registro
  deleteEntry(Record record) {
    record.reference.delete();
  }
}
