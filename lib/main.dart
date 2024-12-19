import 'package:flutter/material.dart';
import 'package:restaurant_app/app/app.dart';

void main() {
  runApp(MyApp());
}
// https://www.youtube.com/watch?v=mHVEErSjMD0 Singleton design pattern in dart

// https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4 Hexadecimal color code for transparency


// StreamController improves stream management between view and view model

// StreamController =  sink + stream

// sink is the input of StreamController

// stream is the output of StreamController

// At the end of the stream we need to close the stream controller to avoid memory leak

// At the end of the stream may be there is a lot of listeners or 1 listener

// in dart private attribute can access if it is in the same file
