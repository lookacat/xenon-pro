import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'app.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xenon',
      theme: ThemeData(
          fontFamily: "Inter",
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(
              const Color(0xff777777),
            ),
          )),
      home: const MainApp(),
    );
  }
}
