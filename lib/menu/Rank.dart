import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rank extends Container{
  @override
  Color get color => Colors.yellow;
  @override
  Widget get child => Center(
    child: Icon(Icons.school),
  );
}