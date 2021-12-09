
import 'package:flutter/material.dart';
import 'package:lembra_do_remedio/helpers/platform_slider.dart';

class UserSlider extends StatelessWidget {
  final Function handler;
  final int semanas;
  UserSlider(this.handler,this.semanas);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: PlatformSlider(
              divisions: 11,
              min: 1,
              max: 10,
              value: semanas,
              color: Theme.of(context).primaryColor,
              handler:  this.handler,)),
      ],
    );
  }
}
