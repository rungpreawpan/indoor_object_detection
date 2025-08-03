import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ObjectDetectionPage extends ConsumerStatefulWidget {
  const ObjectDetectionPage({super.key});

  @override
  ConsumerState<ObjectDetectionPage> createState() => _ObjectDetectionPageState();
}

class _ObjectDetectionPageState extends ConsumerState<ObjectDetectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(

        ),
      ),
    );
  }
}