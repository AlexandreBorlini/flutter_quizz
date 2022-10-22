import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz/domain/pergunta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../util/Utils.dart';

class ControlePersistenciaPerguntas {
  late User user;

  ControlePersistenciaPerguntas(this.user);

  CollectionReference<Map<String, dynamic>> get _collection_perguntas =>
      FirebaseFirestore.instance.collection('perguntas');

  Stream<QuerySnapshot> get stream => _collection_perguntas.where("id_usuario", isEqualTo: user.uid).snapshots();


  List<Pergunta>? perguntas;

  Future<void> save(BuildContext context, Pergunta pergunta) async {
    var pergunta_json = pergunta.toMap();

    var snapShot = await _collection_perguntas
        .where("id_usuario", isEqualTo: pergunta.idUsuario)
        .where("tema", isEqualTo: pergunta.tema)
        .where("pergunta", isEqualTo: pergunta.pergunta)
        .get();

    if (snapShot.size > 0) {
      var documentId = snapShot.docChanges.first.doc.id;
      await _collection_perguntas
          .doc(documentId)
          .update(pergunta_json)
          .then((value) =>
              snackbarSuccess(context, "Sucesso ao atualizar pergunta!"))
          .onError((error, stackTrace) =>
              snackbarError(context, "Falha ao atualizar pergunta! \n $error"));
    } else {
      await _collection_perguntas
          .doc()
          .set(pergunta_json)
          .then(
              (value) => snackbarSuccess(context, "Sucesso ao criar pergunta!"))
          .onError((error, stackTrace) =>
              snackbarError(context, "Falha ao criar pergunta! \n $error"));
    }
  }

  Future<void> delete(BuildContext context, Pergunta pergunta) async {
    var snapShot = await _collection_perguntas
        .where("id_usuario", isEqualTo: pergunta.idUsuario)
        .where("tema", isEqualTo: pergunta.tema)
        .where("pergunta", isEqualTo: pergunta.pergunta)
        .get();
    if (snapShot.size > 0) {
      var documentId = snapShot.docChanges.first.doc.id;
      await _collection_perguntas
          .doc(documentId)
          .delete()
          .then((value) =>
              snackbarSuccess(context, "Sucesso ao deletar pergunta!"))
          .onError((error, stackTrace) =>
              snackbarError(context, "Falha ao deletar pergunta! \n $error"));
    } else {
      snackbarError(context, "Pergunta inexistente!");
    }
  }

  void recuperarPerguntas(QuerySnapshot data){
    var perguntas_docs = data.docs;

    perguntas = perguntas_docs.map((DocumentSnapshot  document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return Pergunta.fromMap(data);
    }).toList();
  }
}
