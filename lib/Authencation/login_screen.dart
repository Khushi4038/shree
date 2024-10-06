import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // For showing toast messages
import 'package:khushi_flutter_practice/Screens/home_screen.dart'; // Import your home screen
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // For JSON encoding/decoding

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  String? _errorMessage; // Variable to hold error messages
  bool _isLoading = false; // Variable to track loading state

  // Method to handle API login
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Show loading spinner
      _errorMessage = null; // Clear previous error message
    });

    // Simulating an API call to your backend
    // Replace the URL with your actual API endpoint
    const String apiUrl = 'https://example.com/api/login'; // Change this to your API URL

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // If login is successful, navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        // If the response indicates an error, show an error message
        setState(() {
          _errorMessage = 'Email or Password is incorrect'; // Update error message
        });
      }
    } catch (e) {
      // Handle any errors that occur during the request
      setState(() {
        _errorMessage = 'Failed to login. Please try again.'; // Update error message
      });
    }

    setState(() {
      _isLoading = false; // Hide loading spinner
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Make the body scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            // Centered logo
            Center(
              child: Image.asset(
                'assets/img/turtle.jpg', // Replace with your logo asset path
                width: 150,
              ),
            ),
            const SizedBox(height: 20),
            // Title text
            const Text(
              "Turtle's Wonderland",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // Email input field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _errorMessage != null ? Colors.red : Colors.grey,
                  ),
                ),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 16),
            // Password input field
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _errorMessage != null ? Colors.red : Colors.grey,
                  ),
                ),
                hintText: 'Enter your password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            // "Forgot Password?" text button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Navigate to the Forgot Password screen
                },
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 40),
            // Display error message if there is one
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            // Login button
            ElevatedButton(
              onPressed: _isLoading ? null : _login, // Disable button if loading
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),
            // Custom divider with text
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(' or '),
                ),
                const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 20),
            // Social login options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Apple login button
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(Icons.apple, color: Colors.white),
                    onPressed: () {
                      // TODO: Handle Apple login
                    },
                  ),
                ),
                // Google login button
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: const Icon(Icons.g_translate, color: Colors.white),
                    onPressed: () {
                      // TODO: Handle Google login
                    },
                  ),
                ),
                // Facebook login button
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.white),
                    onPressed: () {
                      // TODO: Handle Facebook login
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // RichText for signup prompt
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'signup',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Fluttertoast.showToast(
                        msg: "Not Ready Yet",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 16.0,
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
