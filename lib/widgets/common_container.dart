// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:myroutine/utils/utils.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    Key? key,
    this.child,
    this.height,
  }) : super(key: key);

  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Container(
      width: deviceSize.width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colorScheme.primaryContainer),
      child: child,
    );
  }
}
