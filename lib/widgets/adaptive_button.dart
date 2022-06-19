import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final VoidCallback handler;
  final String btnText;
  const AdaptiveButton({Key? key, required this.handler, required this.btnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              btnText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ))
        : TextButton(
            style:
                TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            onPressed: handler,
            child: Text(btnText),
          );
  }
}
