import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fi = FirebaseFirestore.instance;

//FR - firestore reference

final userFR = fi.collection('users');
final newsFR = fi.collection('news');
final jobsFR = fi.collection('jobs');
final postsFR = fi.collection('posts');

//Reference get firebaseStorage => FirebaseStorage.instanceFor(bucket: 'gs://huong-nghiep.appspot.com').ref();
FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
