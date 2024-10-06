import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // For showing toast messages
import 'package:khushi_flutter_practice/Screens/home_screen.dart'; // Import your home screen
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // For JSON encoding/decoding

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _errorMessage; // Variable to hold error messages
  bool _isLoading = false; // Variable to track loading state

  // Method to handle API call for sign up
  Future<void> _signup() async {
    setState(() {
      _isLoading = true; // Show the loading spinner
      _errorMessage = null; // Clear any previous error message
    });

    // Replace with your actual API endpoint for signup
    const String apiUrl = 'https://example.com/api/signup'; // Change this to your API URL

    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match'; // Update error message
      });
      setState(() {
        _isLoading = false; // Hide loading spinner
      });
      return;
    }

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // If sign up is successful, navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        // If the response indicates an error, show an error message
        setState(() {
          _errorMessage = 'Failed to sign up. Please try again.'; // Update error message
        });
      }
    } catch (e) {
      // Handle any errors that occur during the request
      setState(() {
        _errorMessage = 'Failed to sign up. Please try again.'; // Update error message
      });
    }

    setState(() {
      _isLoading = false; // Hide loading spinner
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
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
            // Name input field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                hintText: 'Enter your name', // Hint text for the input
              ),
            ),
            const SizedBox(height: 16), // Space between fields
            // Email input field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                hintText: 'Enter your email', // Hint text for the input
              ),
            ),
            const SizedBox(height: 16), // Space between fields
            // Password input field
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                hintText: 'Enter your password', // Hint text for the input
              ),
              obscureText: true, // Hide password text
            ),
            const SizedBox(height: 16), // Space between fields
            // Confirm Password input field
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                hintText: 'Re-enter your password', // Hint text for the input
              ),
              obscureText: true, // Hide password text
            ),
            const SizedBox(height: 10), // Space before the forgot password button
            // "Forgot Password?" text button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Navigate to the Forgot Password screen
                  // Implement your navigation here
                },
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 40), // Space before the Sign Up button
            // Display error message if there is one
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red), // Style for the error message
                ),
              ),
            // Sign Up button
            ElevatedButton(
              onPressed: _isLoading ? null : _signup, // Disable button if loading
              child: _isLoading
                  ? const CircularProgressIndicator() // Loader while signing up
                  : const Text('Sign Up'), // Button text
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15), // Vertical padding for the button
                minimumSize: const Size.fromHeight(50), // Minimum button height
              ),
            ),
            const SizedBox(height: 20), // Space before social login options
            // Social login options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Apple login button
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(Icons.apple, color: Colors.white), // Apple icon
                    onPressed: () {
                      // TODO: Handle Apple login
                      // Implement your Apple login logic here
                    },
                  ),
                ),
                // Google login button
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: const Icon(Icons.g_translate, color: Colors.white), // Google icon
                    onPressed: () {
                      // TODO: Handle Google login
                      // Implement your Google login logic here
                    },
                  ),
                ),
                // Facebook login button
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.white), // Facebook icon
                    onPressed: () {
                      // TODO: Handle Facebook login
                      // Implement your Facebook login logic here
                    },
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
