import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget animationwidget(data) {
  return Lottie.asset(
      data.weather[0].icon == "01d"
          ? "assets/sun.json"
          : data.weather[0].icon == "02d"
              ? "assets/suncloud.json"
              : data.weather[0].icon == "03d"
                  ? "assets/clouds.json"
                  : data.weather[0].icon == "04d"
                      ? "assets/high_clouds.json"
                      : data.weather[0].icon == "09d"
                          ? "assets/raining.json"
                          : data.weather[0].icon == "10d"
                              ? "assets/sun-and-rain.json.json"
                              : data.weather[0].icon == "11d"
                                  ? "assets/thunderstorm.json"
                                  : data.weather[0].icon == "13d"
                                      ? "assets/snow.json"
                                      : data.weather[0].icon == "50d"
                                          ? "assets/shape-layers-lottie-animation.json"
                                          : data.weather[0].icon == "01n"
                                              ? "assets/sun.json"
                                              : data.weather[0].icon == "02n"
                                                  ? "assets/suncloud.json"
                                                  : data.weather[0].icon ==
                                                          "03n"
                                                      ? "assets/suncloud.json"
                                                      : data.weather[0].icon ==
                                                              "04n"
                                                          ? "assets/suncloud.json"
                                                          : data.weather[0]
                                                                      .icon ==
                                                                  "09n"
                                                              ? "assets/suncloud.json"
                                                              : data.weather[0]
                                                                          .icon ==
                                                                      "10n"
                                                                  ? "assets/suncloud.json"
                                                                  : data.weather[0].icon ==
                                                                          "11n"
                                                                      ? "assets/suncloud.json"
                                                                      : data.weather[0].icon ==
                                                                              "12n"
                                                                          ? "assets/suncloud.json"
                                                                          : data.weather[0].icon == "13n"
                                                                              ? "assets/suncloud.json"
                                                                              : data.weather[0].icon == "14n"
                                                                                  ? "assets/suncloud.json"
                                                                                  : data.weather[0].icon == "50n"
                                                                                      ? "assets/suncloud.json"
                                                                                      : "assets/suncloud.json",
      width: 200,
      height: 200);
}
