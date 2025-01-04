import 'package:flutter/material.dart';
import 'package:restaurant_app/app/app.dart';

void main() {
  // runApp() is a function that takes a widget and makes it the root of the widget tree
  runApp(MyApp());
}

// https://www.youtube.com/watch?v=mHVEErSjMD0 Singleton design pattern in dart

// https://www.youtube.com/watch?v=4siYxQVLNb8 Dart Factory Constructor

// https://www.youtube.com/watch?v=LmQNheAUzfE Dart extension methods

// https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4 Hexadecimal color code for transparency

// https://app.wiremock.cloud/mock-apis/wm9ok/stubs/57183709-c191-4152-9e2b-01c6d8a46e04

// StreamController improves stream management between view and view model

// StreamController =  sink + stream

// sink is the input of StreamController

// stream is the output of StreamController

// At the end of the stream we need to close the stream controller to avoid memory leak

// At the end of the stream may be there is a lot of listeners or 1 listener

// in dart private attribute can access if it is in the same file