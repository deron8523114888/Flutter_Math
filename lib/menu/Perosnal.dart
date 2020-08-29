import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Personal extends Container{
  @override
  Color get color => Color(0xFFD3BA92);
  @override
  Widget get child {
    return Center(
      child: Image.asset('assets/images/rank_2.png',
      width: 150,
      height: 150)
    );
  }
}
