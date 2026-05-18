import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:milkman/app/di/di.dart';
import 'package:milkman/firebase_options.dart';

typedef AppBuilder =
    Widget
    Function(); // Defing custom dataType for A zero-parameter function which return a widget
Future<void> bootStrap(AppBuilder builder) async {
  runZonedGuarded(
    //creating a protected execution zone, any handled async/future/stream error is handled here
    () async {
      WidgetsFlutterBinding.ensureInitialized(); // To ensure app is initialized completely before performing any operation(e.g. Initializing firebase)

      FlutterError.onError = (error) {
        //catches flutter framework error

        FlutterError.presentError(error); //display them

        // TODO: forward to Crashlytics when you add it
      };

      await Firebase.initializeApp(
        //initializing firebase
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await configureDependencies();

      runApp(builder());
    },
    (error, stackTrace) {
      if (kDebugMode) {
        print('Uncaught error: $error\n$stackTrace');
      }

      // TODO: forward to Crashlytics when you add it
    },
  );
}
