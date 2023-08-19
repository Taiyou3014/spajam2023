import 'package:flutter/material.dart';

import 'app.dart';
<<<<<<< HEAD
import 'kasokudo.dart';

void main() {
  runApp(MyApp());
=======
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  
>>>>>>> 550044107527615ac8f6f8e54ccfcdd61e4b78e7
}


