import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('../assets/images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: buildLoginBody(context),
      ),
    );
  }

  Widget buildLoginBody(BuildContext context) {
    return Stack(
      children: [
        buildWelcomeText(),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              right: 35,
              left: 35,
              top: MediaQuery.of(context).size.height * 0.5,
            ),
            child: Column(
              children: [
                buildEmailTextField(),
                SizedBox(height: 30),
                buildPasswordTextField(),
                SizedBox(height: 40),
                buildSignInButton(),
                SizedBox(height: 40),
                buildOtherOptions(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWelcomeText() {
    return Container(
      padding: const EdgeInsets.only(left: 35, top: 80),
      child: const Text(
        "Welcome\nBack",
        style: TextStyle(color: Colors.white, fontSize: 33),
      ),
    );
  }

  Widget buildEmailTextField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildSignInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Sign In',
          style: TextStyle(
            color: Color(0xff4c505b),
            fontSize: 27,
            fontWeight: FontWeight.w700,
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xff4c505b),
          child: IconButton(
            color: Colors.white,
            onPressed: () {
              signInWithEmailAndPassword();
            },
            icon: Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }

  Widget buildOtherOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'register');
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
              color: Color(0xff4c505b),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // Implement forgot password functionality
            Navigator.pushNamed(context, 'reset_password');
          },
          child: Text(
            'Forgot Password',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
              color: Color(0xff4c505b),
            ),
          ),
        ),
      ],
    );
  }

  void signInWithEmailAndPassword() async {
  try {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Authentication successful
      print('Sign in successful');

      // navigate to the next screen
      Navigator.pushNamed(context, 'home');
      
    } else {
      // Display an error message or handle empty email/password fields
    }
  } catch (e) {
    // Display an error message or handle the authentication error
    print('Sign in failed: $e');
  }
}
}