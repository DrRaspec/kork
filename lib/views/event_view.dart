import 'package:flutter/material.dart';
import 'package:get/get.dart';

part '../controllers/event_controller.dart';
part '../bindings/event_binding.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}
