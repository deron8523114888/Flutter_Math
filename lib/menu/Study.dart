import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Study extends Container{
  @override
  Color get color => Colors.orange;
  @override
  Widget get child => Center(
    child: Icon(Icons.laptop_chromebook),
  );
}