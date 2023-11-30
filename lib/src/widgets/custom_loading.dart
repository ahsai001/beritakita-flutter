import 'package:beritakita/src/widgets/color_loader.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    //return const CircularProgressIndicator();
    return const ColorLoader();
  }
}
