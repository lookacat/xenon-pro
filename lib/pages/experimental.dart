import 'package:flutter/material.dart';

class ExperimentalPage extends StatefulWidget {
  const ExperimentalPage({Key? key}) : super(key: key);

  @override
  State<ExperimentalPage> createState() => _ExperimentalPageState();
}

class _ExperimentalPageState extends State<ExperimentalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  Material buildMaterialApp() {
    return const Material(
      child: Text(
        "hallo",
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
