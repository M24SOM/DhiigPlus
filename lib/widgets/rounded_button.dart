import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  String? title;
  Function()? onPressed;

  RoundedButton({Key? key, required title, required onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
