import 'package:flutter/material.dart';
import 'package:smart_switch_team13/features/weather/Services/weather_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_switch_team13/features/weather/Models/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('29c4c450a7de447fa235f88c06b596dc');
  Weather? _weather;
  String? _city;
  String _date = '';
  bool _isLoading = true;
  int _fetchAttempts = 0;
  static const int _maxFetchAttempts = 3;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle it gracefully
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied, handle it gracefully
        return;
      }

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
          _fetchAttempts = 0; // Reset fetch attempts on success
        });
      }
    } catch (e) {
      print("Error fetching position or weather: $e");
      _fetchAttempts++;
      if (_fetchAttempts < _maxFetchAttempts) {
        // Retry fetching weather data if attempts are within limit
        _fetchWeather();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFA58BFF),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10),
            child: _isLoading
                ? _buildLoadingUI()
                : _buildWeatherUI(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Row(
      children: [
        Lottie.asset(
          'images/loadImage.json',
          width: 100,
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loading...',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              _city ?? 'Unknown',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            Text(
              _date,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
              width: 70,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _weather?.mainCondition ?? 'Unknown',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _city ?? 'Unknown',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _date,
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
          alignment: Alignment.centerRight,
          child: Text(
            '${_weather?.temperature ?? 0}°',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
