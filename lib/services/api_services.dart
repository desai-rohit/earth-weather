import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:temp_app/model/current_weather_model.dart';
import 'package:temp_app/model/hours_weather_model.dart';

class ApiService extends ChangeNotifier {
  PermissionStatus? status;
  getCurrentWeather() async {
    status = await Permission.location.request();
    if (status!.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      var res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=b089354793bcf9126c5c11c3e24e1734"));
      if (res.statusCode == 200) {
        var data = weatherDataFromMap(res.body.toString());
        notifyListeners();
        return data;
      }else{
        print("error");
      }
    } else if (status!.isDenied) {
      await Permission.location.request();
    } else if (status!.isPermanentlyDenied) {
      openAppSettings().then((value) => getCurrentWeather());
    }
  }

  getHoursWeather() async {

  if (status!.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=b089354793bcf9126c5c11c3e24e1734"));
    if (res.statusCode == 200) {
      var data = weatherDataHoursFromMap(res.body.toString());

      return data;
    }
  } else if (status!.isDenied) {
    await Permission.location.request();
  } else{
    openAppSettings();
  } 
}
}

