import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CenterLoading extends StatelessWidget {
  final double size;
  CenterLoading({this.size});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SpinKitChasingDots(
        size: size ?? 25,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
