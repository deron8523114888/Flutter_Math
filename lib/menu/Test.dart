import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends Container{
  @override
  Color get color => Colors.green;
  @override
  Widget get child => Center(
    child: Icon(Icons.book),
  );
}