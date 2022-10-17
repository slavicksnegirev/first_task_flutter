// import 'package:flutter/material.dart';
// import 'pages/main_page.dart';
// //import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

// void main() {
//   //debugPaintSizeEnabled = true;
//   return runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Конвертер файлов',
//       home: HomePage(),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:first_task_flutter/pages/mobile_ui.dart';
import 'package:first_task_flutter/pages/desktop_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ConverterApp());
}

class ConverterApp extends StatelessWidget {
  const ConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: determinePlatform());
  }
}

Widget determinePlatform() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    return const DesktopLayout();
  } else {
    return const MobileLayout();
  }
}

