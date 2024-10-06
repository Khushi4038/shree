import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the fluttertoast package
import 'package:khushi_flutter_practice/Authencation/login_screen.dart';
import 'package:khushi_flutter_practice/Authencation/phone_login_screen.dart';
import 'package:khushi_flutter_practice/Authencation/signup_screen.dart';

// SplashScreen widget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea( // Wrap the Scaffold in a SafeArea
      child: Scaffold(
        // Scaffold provides a basic material design layout
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the logo and buttons
          children: [
            // Empty spacer to push the logo to the center
            const Spacer(),
            // Centered logo
            Center(
              child: Image.asset(
                'assets/img/turtle.jpg', // Replace with your logo asset path
                width: 150, // Width of the logo
              ),
            ),
            const Spacer(), // Spacer to keep the logo in the center
            // Row to hold the buttons
            Row(
              children: [
                // Login button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Set background color to black
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // No border radius for rectangular shape
                      ),
                      padding: EdgeInsets.zero, // No padding for full-width button
                    ),
                    onPressed: () {
                      // Navigate to Login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PhoneLoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)), // Button text
                  ),
                ),
                // Vertical Divider
                const VerticalDivider(
                  width: 1, // Width of the divider
                  color: Colors.white, // Color of the divider
                  thickness: 1, // Thickness of the divider
                ),
                // Signup button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Set background color to black
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // No border radius for rectangular shape
                      ),
                      padding: EdgeInsets.zero, // No padding for full-width button
                    ),
                    onPressed: () {
                      // Show toast message when signup button is pressed
                      Fluttertoast.showToast(
                        msg: "Not Ready Yet", // Message to show
                        toastLength: Toast.LENGTH_SHORT, // Duration of the toast
                        gravity: ToastGravity.BOTTOM, // Position of the toast
                        backgroundColor: Colors.black54, // Background color of the toast
                        textColor: Colors.white, // Text color of the toast
                        fontSize: 16.0, // Font size
                      );

                      // Uncomment the following lines to enable navigation to Signup screen
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                      */
                    },
                    child: const Text('Signup', style: TextStyle(fontSize: 18, color: Colors.white)), // Button text
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
