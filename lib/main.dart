import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/app/myroutine_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyRoutineApp(),
    ),
  );
}
