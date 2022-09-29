import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../models/navigation_bar_item.dart';
import '../store/navigator/navigator_store.dart';

class NavigationBarItem extends StatefulWidget {
  final ModelNavigationBarItem model;
  const NavigationBarItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<NavigationBarItem> createState() => _NavigationBarItemState();
}

class _NavigationBarItemState extends State<NavigationBarItem> {
  @override
  void initState() {
    super.initState();
  }

  void onItemTap(BuildContext context) {
    HapticFeedback.heavyImpact();
    NavigatorStore.store.changeRoute(widget.model.target);
  }

  Widget buildIcon() {
    return Container(
      width: 50,
      height: 30,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Icon(
        widget.model.icon,
        color: widget.model.target == NavigatorStore.store.route
            ? Color.fromARGB(255, 248, 185, 185)
            : Color(0xff696969),
        size: 25,
      ),
    );
  }

  Widget buildLabel() {
    return Text(
      widget.model.title,
      style: TextStyle(
        color: widget.model.target == NavigatorStore.store.route
            ? Colors.white
            : Color(0xff696969),
        fontSize: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTap(context),
      child: Container(
        width: 90,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Observer(
          builder: (_) => Column(
            children: <Widget>[
              buildIcon(),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: widget.model.target == NavigatorStore.store.route
                    ? const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 240, 106, 22),
                            Color.fromARGB(255, 249, 35, 35),
                          ],
                        ),
                      )
                    : const BoxDecoration(),
                child: buildLabel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
