import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends Container{
  @override
  Color get color => Colors.blue;
  @override
  Widget get child => Center(
    child: Icon(Icons.settings),
  );
}