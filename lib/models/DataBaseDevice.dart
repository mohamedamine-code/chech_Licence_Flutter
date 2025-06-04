import 'package:check_license/models/device.dart';
import 'package:flutter/material.dart';

class DatabaseDevices extends ChangeNotifier {
  // local data Base of our device
  List<Device> MyDevice = [
    Device(State: "Valid", name: "imprimante 1", id: "855858888888"),
    Device(State: "Valid", name: "imprimante 2", id: "88885588888"),
    Device(State: "Missing", name: "imprimante 3", id: "8855688888"),
    Device(State: "expired", name: "imprimante 4", id: "888556888"),
    Device(State: "Missing", name: "imprimante 5", id: "8888855888"),
    Device(State: "Missing", name: "imprimante 96", id: "88888555888"),
  ];

  // List of the device selected
  List<Device> Selectdevices = [];

  // get the list of MyDevice
  List<Device> get getMydevices => MyDevice;

  // get the list of selected device
  List<Device> get getSelecDevices => Selectdevices;

  // add a new item to list of selected device
  void addItemToSelectedDevice(Device x) {
    Selectdevices.add(x);
    notifyListeners();
  }

  // add a new item to list of MyDevices
  void addItemToMyDevice(Device x) {
    MyDevice.add(x);
    notifyListeners();
  }

  // remove an item from the list of selected device
  void removeitemSelectedDevices(Device x) {
    Selectdevices.remove(x);
    notifyListeners();
  }

  // remove an item from the list of selected device
  void removeitemMyDevices(Device x) {
    MyDevice.remove(x);
    notifyListeners();
  }
}
