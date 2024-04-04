import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class PairingSmartSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blur Background Example',
      home: BlurBackgroundDemo(),
    );
  }
}

class BlurBackgroundDemo extends StatefulWidget {
  @override
  _BlurBackgroundDemoState createState() => _BlurBackgroundDemoState();
}

class _BlurBackgroundDemoState extends State<BlurBackgroundDemo> {
  bool shouldBlur = false;
  bool showBox = false;

  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        shouldBlur = true;
        showBox = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    double ffem = 1.0;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Content
            Center(
              child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xfffff9f9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 40 * fem, 0 * fem, 34 * fem),
                          child: Text(
                            'Pairing smart switch',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 30 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1 * ffem / fem,
                              letterSpacing: 0.15 * fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 20 * fem, 0 * fem, 30 * fem),
                          constraints: BoxConstraints(
                            maxWidth: 347 * fem,
                          ),
                          child: Text(
                            'We found these on your local network',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.5145893097 * ffem,
                              fontWeight: FontWeight.w300,
                              height: 1 * ffem / fem,
                              letterSpacing: 0.0925729465 * fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 30 * fem, 0 * fem, 0 * fem),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                  width: 301 * fem,
                                  height: 237 * fem,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 241, 168, 1.0),
                                    borderRadius:
                                        BorderRadius.circular(50 * fem),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 0.1 * fem,
                                        offset: Offset(2 * fem, 3 * fem),
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 0.1 * fem,
                                        offset: Offset(-1 * fem, 3 * fem),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            child: Image.asset(
                                              'images/Bluetooth.png',
                                              width: 30 * fem,
                                              height: 40 * fem,
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            child: Image.asset(
                                              'images/simple-icons_esphome.png',
                                              width: 47 * fem,
                                              height: 47 * fem,
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF7FF),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      22 * fem),
                                              border: Border.all(
                                                color: Color(0xFF000000),
                                                width: 0.5 * fem,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF7FF),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      22 * fem),
                                              border: Border.all(
                                                color: Color(0xFF000000),
                                                width: 0.5 * fem,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                        ],
                                      ),
                                      SizedBox(height: 20 * fem),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF7FF),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      22 * fem),
                                              border: Border.all(
                                                color: Color(0xFF000000),
                                                width: 0.5 * fem,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF7FF),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      22 * fem),
                                              border: Border.all(
                                                color: Color(0xFF000000),
                                                width: 0.5 * fem,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF7FF),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      22 * fem),
                                              border: Border.all(
                                                color: Color(0xFF000000),
                                                width: 0.5 * fem,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF7FF),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      22 * fem),
                                              border: Border.all(
                                                color: Color(0xFF000000),
                                                width: 0.5 * fem,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                        ],
                                      ),
                                      SizedBox(height: 20 * fem),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 10 * fem),
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF7FF),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      22 * fem),
                                              border: Border.all(
                                                color: Color(0xFF000000),
                                                width: 0.5 * fem,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                          Container(
                                            width: 44 * fem,
                                            height: 44 * fem,
                                            margin: EdgeInsets.only(
                                                left: 22 * fem, top: 3 * fem),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF7FF),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      22 * fem),
                                              border: Border.all(
                                                color: Color(0xFF000000),
                                                width: 0.5 * fem,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5 * fem),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        13.96 * fem, 53.2 * fem, 17 * fem, 0 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // Aligns children to the left
                      children: [
                        Container(
                          width: 85 * fem,
                          height: 39 * fem,
                          margin: EdgeInsets.only(
                              right: 45 *
                                  fem), // Adjust right margin to control button position

                          decoration: BoxDecoration(
                            color: Color(0xff6900ff),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Finish',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1 * ffem / fem,
                                letterSpacing: 0.09 * fem,
                                color: Color(0xfffff9f9),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10 * fem),
                        Center(
                          child: Image.asset(
                            'images/Online world-bro 1.png',
                            width: 230 * fem,
                            height: 230 * fem,
                            fit: BoxFit
                                .cover, // Added fit property to ensure image covers the container
                          ),
                        ) // Add some space between the button and the image
                      ],
                    ),
                  ),
                ],
              ),
              ),
            ),
            // Blurred overlay
            if (shouldBlur)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            // New box
            if (showBox)
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 5 * fem, // Adjusted blur radius
                            offset: Offset(2 * fem, 3 * fem), // Adjusted offset
                          ),
                        ],
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5 * fem, // Adjusted border width
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15 * fem, 35 * fem,
                            15 * fem, 60 * fem), // Inner padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Enter the smart switch reference',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18 * ffem, // Increased font size
                                fontWeight: FontWeight.w600, // semiBold
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 25 * fem),
                            Text(
                              'You will find it written on the device',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12 * ffem,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 40 * fem),
                            Container(
                              width: double.infinity, // Takes the full width
                              decoration: BoxDecoration(
                                color:
                                    Color(0x80A58BFF), // Grey background color
                                borderRadius: BorderRadius.circular(
                                    15.88 * fem), // Changed border radius
                                border: Border.all(
                                  color: Colors.black, // Thin border color
                                  width: 0.3 * fem, // Thin border width
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none, // Removed border
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15 * fem,
                                      vertical: 10 * fem), // Padding
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Pair extends StatelessWidget {
  const Pair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    double ffem = 1.0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfffff9f9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 34 * fem),
                      child: Text(
                        'Home location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30, // no need to multiply by ffem
                          fontWeight: FontWeight.w400,
                          height: 1, // no need to divide by fem
                          letterSpacing: 0.15,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 10 * fem, 0 * fem, 30 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 347 * fem,
                      ),
                      child: Text(
                        'Setting up your location helps display information like the local weather and use sun-based automations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.51, // no need to multiply by ffem
                          fontWeight: FontWeight.w300,
                          height: 1, // no need to divide by fem
                          letterSpacing:
                              0.0926, // rounded to four decimal places
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 15 * fem, 0 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          10 * fem, 20 * fem, 18 * fem, 9 * fem),
                      width: 340 * fem,
                      height: 55 * fem,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff000000)),
                        color: Color(0xFFFAF7FF),
                        borderRadius: BorderRadius.circular(10 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x70000000),
                            offset: Offset(0 * fem, 2 * fem),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 10 * fem),
                            width: 40 * fem, // Increased size of the image
                            height: 40 * fem, // Increased size of the image
                            child: Image(
                              width: 400 * fem, // Increased size of the image
                              height: 400 * fem, // Increased size of the image
                              image: AssetImage('images/search.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // Added padding to the TextField
                              child: TextField(
                                textAlignVertical: TextAlignVertical
                                    .center, // Centered the hintText vertically
                                decoration: InputDecoration(
                                  hintText: 'Search Address',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.06 * fem,
                                    color: Color(0x99000000),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12 * fem,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.06 * fem,
                                  color: Color(0x99000000),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 377 * fem,
                height: 500 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * fem),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: -80 * fem,
                      bottom: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          heightFactor: 0.9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10 * fem),
                            child: Image.asset(
                              'images/Basemap.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 280,
                      child: Container(
                        width: 200, // Adjusted width (1/4 of Basemap width)
                        height: 200, // Adjusted height (1/4 of Basemap height)
                        child: Image.asset(
                          'images/review-bro.png',
                          width: 200, // Set width to match container width
                          height: 200, // Set height to match container height
                          fit: BoxFit.contain, // Maintain aspect ratio
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20 *
                          fem, // Adjusted right position for the "Next" button
                      top: 330 *
                          fem, // Adjusted bottom position for the "Next" button
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PairingSmartSwitch(),
                            ),
                          );
                        },
                        child: Container(
                          width: 85 * fem,
                          height: 39 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xff6900ff),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1 * ffem / fem,
                                letterSpacing: 0.09 * fem,
                                color: Color(0xfffff9f9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
