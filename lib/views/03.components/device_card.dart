import 'dart:convert';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import '../../domain/entities/device_entities.dart';
import '../controller/cubit.dart';
import 'status_component.dart';

class DeviceCard extends StatelessWidget {
  Device device;
  Widget widget;
  DevicesCubit cubit;
  int index;
  DeviceCard({
    required this.cubit,
    required this.index,
    required this.widget,
    required this.device,
  });
  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                StatusComponent(
                  status:cubit.status["${device.deviceCode}"]?? "Active",
                ),
                Spacer(),
               widget
              ]),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Image.memory(
                 base64Decode( device.imageURL! ),
                  gaplessPlayback: true,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                device.deviceName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                device.deviceCode,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.black38,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    device.department,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "room:#${device.roomNumber}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );

  }
}
