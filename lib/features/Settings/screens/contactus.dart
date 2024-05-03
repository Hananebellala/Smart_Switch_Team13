import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/helpCenter.dart';
import '../widgets/goBack.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    double ffem = 1.0;
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          // Wrap Column with SingleChildScrollView
          child: Container(
            margin: EdgeInsets.fromLTRB(27, 20, 27, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 57), // Space from top
                const Row(
                  children: [
                    GoBack(previousScreen: HelpCenter()), // GoBack widget
                    SizedBox(
                        width:
                            30), // Space between "Go Back" and "Account Settings"
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600, // SemiBold
                        fontSize: 24.0, // Adjust the font size as needed
                        color: Colors.black, // Black color
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'images/Contact us-bro 1.png',
                    width: 260 * fem,
                    height: 255 * fem,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 80),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigate to Instagram
                        // Replace 'instagram_account_url' with the actual Instagram URL
                        launch('https://www.instagram.com/example/');
                      },
                      child: Image.asset(
                        'images/instagram.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(width: 80),
                    InkWell(
                      onTap: () {
                        // Navigate to Discord
                        // Replace 'discord_invite_url' with the actual Discord invite URL
                        launch('https://discord.gg/example');
                      },
                      child: Image.asset(
                        'images/discord.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigate to Facebook
                        // Replace 'facebook_page_url' with the actual Facebook page URL
                        launch('https://www.facebook.com/example');
                      },
                      child: Image.asset(
                        'images/facebook.png',
                        width: 45,
                        height: 45,
                      ),
                    ),
                    SizedBox(width: 80),
                    InkWell(
                      onTap: () {
                        // Navigate to Gmail
                        // Replace 'gmail_address' with the actual Gmail address
                        launch('mailto:example@gmail.com');
                      },
                      child: Image.asset(
                        'images/gmail.png',
                        width: 55,
                        height: 55,
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
