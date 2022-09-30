import 'package:flutter/material.dart';

class ConnectionStatus extends StatelessWidget {
  final bool connected;

  const ConnectionStatus({
    Key? key,
    required this.connected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: connected ? 0 : 21,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: connected ? Colors.green : Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            spreadRadius: 4,
            blurRadius: 18,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Text(
          connected ? 'GoPro connected' : 'No GoPro connected',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
