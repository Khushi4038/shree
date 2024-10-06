import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // For showing toast messages
import 'package:http/http.dart' as http; // Import the http package
import 'package:khushi_flutter_practice/Authencation/otp_verification.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:khushi_flutter_practice/Screens/home_screen.dart'; 

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorMessage; // Variable to hold error messages
  bool _isLoading = false; // Variable to track loading state

  // Method to handle API call for phone number login
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Show the loading spinner
      _errorMessage = null; // Clear any previous error message
    });

    // Replace with your actual API endpoint for phone number login
    const String apiUrl = 'https://example.com/api/login'; // Change this to your API URL

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': _phoneController.text,
        }),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // If login is successful, navigate to the OTP screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OtpVerification(),
          ),
        );
      } else {
        // If the response indicates an error, show an error message
        setState(() {
          _errorMessage = 'Failed to log in. Please try again.'; // Update error message
        });
      }
    } catch (e) {
      // Handle any errors that occur during the request
      setState(() {
        _errorMessage = 'Failed to log in. Please try again.'; // Update error message
      });
    }

    setState(() {
      _isLoading = false; // Hide loading spinner
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Login"), // Title for the AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView( // Add SingleChildScrollView
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: MediaQuery.of(context).size.height * 0.1), // Responsive padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered logo
            Center(
              child: Image.asset(
                'assets/img/turtle.jpg', // Replace with your logo asset path
                width: 150, // Width of the logo
              ),
            ),
            const SizedBox(height: 20), // Space between logo and title
            // Title text
            const Text(
              "Turtle's Wonderland",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Title style
            ),
            const SizedBox(height: 40), // Space between title and input fields
            // Phone input field
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                hintText: 'Enter your phone number', // Hint text for the input
              ),
              keyboardType: TextInputType.phone, // Phone number keyboard
            ),
            const SizedBox(height: 10), // Space before the error message
            // Display error message if there is one
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red), // Style for the error message
                ),
              ),
            const SizedBox(height: 40), // Space before the login button
            // Login button
            ElevatedButton(
              onPressed: _isLoading ? null : _login, // Disable button if loading
              child: _isLoading
                  ? const CircularProgressIndicator() // Loader while logging in
                  : const Text('Verify'), // Button text
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15), // Vertical padding for the button
                minimumSize: const Size.fromHeight(50), // Minimum button height
              ),
            ),
            const SizedBox(height: 20), // Space before signup prompt
            // RichText for signup prompt
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(color: Colors.black), // Default text color
                children: <TextSpan>[
                  TextSpan(
                    text: 'signup',
                    style: const TextStyle(color: Colors.blue), // Signup text color
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Fluttertoast.showToast(
                        msg: "Not Ready Yet", // Message to show
                        toastLength: Toast.LENGTH_SHORT, // Duration of the toast
                        gravity: ToastGravity.BOTTOM, // Position of the toast
                        backgroundColor: Colors.black54, // Background color of the toast
                        textColor: Colors.white, // Text color of the toast
                        fontSize: 16.0, // Font size
                      );

                      // Uncomment the following line to enable navigation to Signup screen
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                      */
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
