import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:temp_app/colors/colors.dart';
import 'package:temp_app/model/current_weather_model.dart';
import 'package:temp_app/model/hours_weather_model.dart';
import 'package:temp_app/pages/animation.dart';
import 'package:temp_app/services/api_services.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    ApiService apiService = Provider.of<ApiService>(context, listen: false);

    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: apiService.getCurrentWeather(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            WeatherData data = snapshot.data;
            var sunriseMillisecond =
                DateTime.fromMillisecondsSinceEpoch(data.sys.sunrise * 1000);
            var sunsetMillisecond =
                DateTime.fromMillisecondsSinceEpoch(data.sys.sunset * 1000);

            var d12rise = DateFormat('hh:mm a').format(sunriseMillisecond);
            var d12set = DateFormat('hh:mm a').format(sunsetMillisecond);

            double tempnum = data.main.temp - 273.15;
            double tempmin = data.main.tempMin - 273.15;
            double tempmax = data.main.tempMax - 273.15;
            double tempfeel = data.main.feelsLike - 273.15;

            return CustomScrollView(
                physics: const RangeMaintainingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: bgcolor,
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    "${tempnum.toStringAsFixed(tempnum.truncateToDouble() == tempnum ? 0 : 0)}°C",
                                    style: TextStyle(
                                        fontSize: 84,
                                        color: black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    data.weather[0].main,
                                    style:
                                        TextStyle(fontSize: 32, color: black),
                                  ),
                                  Text(
                                    data.weather[0].description,
                                    style:
                                        TextStyle(fontSize: 24, color: black),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 4,
                              width: width / 2.5,
                              child: Center(
                                child: animationwidget(data),
                              ),
                            ),
                          ],
                        ),
                      ),
                      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                      title: Text(
                        textAlign: TextAlign.start,
                        "${data.name} \n ${tempmin.toStringAsFixed(tempnum.truncateToDouble() == tempnum ? 0 : 0)}° / ${tempmax.toStringAsFixed(tempnum.truncateToDouble() == tempnum ? 0 : 0)}° Feels Like ${tempfeel.toStringAsFixed(tempnum.truncateToDouble() == tempnum ? 0 : 0)}°",
                        style: TextStyle(fontSize: 14, color: black),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: bgcolor),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Daily Forecast",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: height / 3,
                            decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: FutureBuilder(
                              future:apiService.getHoursWeather(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  WeatherDataHours datahours = snapshot.data;

                                  return Column(
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Generally clear highs 37 to 39 C and lows 21 to 23 C",
                                        style: TextStyle(
                                            fontSize: 16, color: bgcolor),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: 5,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: ((context, index) {
                                              String formattedDate =
                                                  DateFormat('hh:mm a').format(
                                                      datahours
                                                          .list[index].dtTxt);

                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      formattedDate,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: bgcolor),
                                                    ),
                                                    CircleAvatar(
                                                      radius: 24,
                                                      backgroundImage: NetworkImage(
                                                          "https://openweathermap.org/img/wn/${datahours.list[index].weather[0].icon}@2x.png"),
                                                    ),
                                                    Text(
                                                      "${datahours.list[index].main.temp}°",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: bgcolor),
                                                    )
                                                  ],
                                                ),
                                              );
                                            })),
                                      )
                                    ],
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Container(
                            padding: const EdgeInsets.all(24),
                            height: height / 4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.air,
                                      color: bgcolor,
                                      size: 32,
                                    ),
                                    Text(
                                      "${data.wind.speed} km/h",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: bgcolor),
                                    ),
                                    Text(
                                      "wind",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: bgcolor),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.air,
                                      color: bgcolor,
                                      size: 32,
                                    ),
                                    Text(
                                      "${data.main.humidity}%",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: bgcolor),
                                    ),
                                    Text(
                                      "humidity",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: bgcolor),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      color: bgcolor,
                                      size: 32,
                                    ),
                                    Text(
                                      "${(data.visibility / 1000).toStringAsFixed(0)} KM ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: bgcolor),
                                    ),
                                    Text(
                                      "visibility",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: bgcolor),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            height: height / 3,
                            decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      "SunRise \n $d12rise",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: bgcolor),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "SunSet \n $d12set",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: bgcolor),
                                    )
                                  ],
                                ),
                                Lottie.asset("assets/sunrise_sunset.json",
                                    height: 125)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Weekly Forecast",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                          SizedBox(
                            height: height / 4.5,
                            width: double.infinity,
                            child: FutureBuilder(
                                future:apiService.getHoursWeather(),
                                builder: ((BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    WeatherDataHours forcast5day =
                                        snapshot.data;
                                    return ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: forcast5day.list.length,
                                        itemBuilder: (context, index) {

                                          return Container(
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: black, width: 3)),
                                            padding: const EdgeInsets.all(4),
                                            width: 60,
                                            height: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  DateFormat("EEE").format(
                                                      forcast5day
                                                          .list[index].dtTxt),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${forcast5day.list[index].clouds.all}%",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      "https://openweathermap.org/img/wn/${forcast5day.list[index].weather[0].icon}@2x.png"),
                                                ),
                                                Text(
                                                  "${forcast5day.list[index].main.temp}°",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                })),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
