import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/pages/loginpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreedToPolicy = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                     border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Username ',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Username.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password.';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password.';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
                CheckboxListTile(
                  title: const Text(
                      'I agree to the terms of service and privacy policy.'),
                  value: _agreedToPolicy,
                  onChanged: (value) {
                    setState(() {
                      _agreedToPolicy = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Sign up the user
                    }
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(300, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFF8721D)),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
