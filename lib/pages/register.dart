import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/register.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.transparent,
        body: buildRegisterBody(context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget buildRegisterBody(BuildContext context) {
    return Stack(
      children: [
        buildCreateAccountText(),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              right: 35,
              left: 35,
              top: MediaQuery.of(context).size.height * 0.27,
            ),
            child: Column(
              children: [
                buildNameTextField(),
                const SizedBox(height: 30),
                buildRoleTextField(),
                const SizedBox(height: 30),
                buildEmailTextField(),
                const SizedBox(height: 30),
                buildPasswordTextField(),
                const SizedBox(height: 40),
                buildSignInButton(),
                const SizedBox(height: 40),
                buildLoginOption(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCreateAccountText() {
    return Container(
      padding: const EdgeInsets.only(left: 35, top: 80),
      child: const Text(
        "Create\nAccount",
        style: TextStyle(color: Colors.white, fontSize: 33),
      ),
    );
  }

  Widget buildNameTextField() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: 'Name',
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildRoleTextField() {
    return TextField(
      controller: _roleController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: 'Role',
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildEmailTextField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: 'Email',
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: 'Password',
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildSignInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.w700,
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xff4c505b),
          child: IconButton(
            color: Colors.white,
            onPressed: () {
              signInWithEmailAndPassword();
              Navigator.pushNamed(context, 'login');
            },
            icon: const Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }

  Widget buildLoginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
          child: const Text(
            'Login',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
              color: Colors.white,
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
      final String nameText = _nameController.text.trim();
      final String roleText = _roleController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Registration successful, save data to CSV
        saveToCSV(nameText, roleText);

        // Navigate to the next screen
        Navigator.pushNamed(context, 'login');
      } else {
        // Display an error message or handle empty email/password fields
      }
    } catch (e) {
      // Display an error message or handle the authentication error
      print('Registration failed: $e');
    }
  }

  void saveToCSV(String name, String role) async {
    try {
      List<List<dynamic>> rows = [];
      rows.add(['Name', 'Role']); // CSV header
      rows.add([name, role]); // Data

      String csvContent = const ListToCsvConverter().convert(rows);

      // Get the directory where the CSV file will be stored
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/user_data.csv';

      // Write the CSV content to the file
      File file = File(filePath);
      await file.writeAsString(csvContent);

      print('CSV file saved: $filePath');
    } catch (e) {
      print('Error saving CSV: $e');
    }
  }
}
