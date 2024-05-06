import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/weather/Services/weather_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_switch_team13/features/weather/Models/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('29c4c450a7de447fa235f88c06b596dc');
  Weather? _weather;
  String? _city;
  String _date = '';
  bool _isLoading = true;

  _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        _city = placemarks[0].locality ?? "Unknown City";
        _date = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
      });

      if (_city != null) {
        final weather = await _weatherService.getWeather(_city!);
        setState(() {
          _weather = weather;
        });
      }
    } catch (e) {
      print("Error fetching position or weather: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'images/cloud.json'; // Default animation
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'images/cloud.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'thunderstorm':
        return 'images/rain.json';

      case 'clear':
        return 'images/sun.json';

      case 'few clouds':
        return 'images/sunCloud.json';

      default:
        return 'images/cloud.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 342,
          height: 120,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFA58BFF), // Background color for the box
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10), // Increased padding
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align elements to the start
              children: [
                if (_isLoading)
                  Row(
                    children: [
                      Lottie.asset(
                        'images/loadImage.json', // Loading animation
                        width: 100, // Animation on the left
                      ),
                      SizedBox(width: 15), // Space between animation and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Loading...', // Default text
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Text in white
                            ),
                          ),
                          Text(
                            'Unknown', // City name
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 17,
                              color: Colors.white, // Text in white
                            ),
                          ),
                          Text(
                            'Loading...', // Date
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // New
                    children: [
                      Row(
                        children: [
                          Lottie.asset(
                            getWeatherAnimation(
                                _weather?.mainCondition), // Weather condition
                            width: 70, // Animation on the left
                          ),
                          SizedBox(
                              width: 15), // Space between animation and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align elements to the start
                            children: [
                              Text(
                                _weather?.mainCondition ??
                                    'Unknown', // Weather condition text
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Text in white
                                ),
                              ),
                              Text(
                                '${_city ?? "Unknown"}', // City name
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 17,
                                  color: Colors.white, // Text in white
                                ),
                              ),
                              Text(
                                '$_date', // Date
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment
                            .centerRight, // Align temperature to the right
                        child: Text(
                          '${_isLoading ? '0' : _weather?.temperature ?? 0}°', // Temperature text
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28, // Font size for temperature
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text in white
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}