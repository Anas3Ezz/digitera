import 'package:digitira/core/di/service_locator.dart';
import 'package:digitira/wash_app.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await setUpGetIt();
  runApp(const MyApp());
}
