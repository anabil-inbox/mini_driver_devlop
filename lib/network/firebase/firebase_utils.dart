import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirebaseUtils {
  FirebaseUtils._();
  static final FirebaseUtils instance = FirebaseUtils._();
  factory FirebaseUtils() => instance;



  //todo this for block app manually
  Future<bool> isBlockedApp()async{
    var documentReference = FirebaseFirestore.instance.collection("condition").doc("condition");
    var documentSnapshot = await documentReference.get();
    var data = documentSnapshot.data();
    Logger().d(data);
    return data?["show_d_subscriptions"]??false;
  }



}