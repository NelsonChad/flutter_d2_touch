import 'package:d2_touch/modules/auth/models/login-response.model.dart';
import 'package:dhis2_flutter/main.dart';
import 'package:dhis2_flutter/ui/home.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String username = '';
  String password = '';
  String url = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  bool authenticating = false;
  bool showPassWord = false;
  bool loggedIn = true;
  bool errorLoginIn = false;
  late String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: "URL",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  login2(
                    usernameController.text,
                    passwordController.text,
                    urlController.text,
                  );
                },
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login2(String username, String password, String url) async {
    setState(() {
      authenticating = true;
    });
    // ignore: unused_local_variable
    LoginResponseStatus? onlineLogIn;

    try {
      onlineLogIn = await d2repository.authModule
          .logIn(username: username, password: password, url: url)
          .then(
        (value) {
          if (value == LoginResponseStatus.ONLINE_LOGIN_SUCCESS) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
          }
        },
      );

      print("LOGIN::: $onlineLogIn");
    } catch (error) {
      onlineLogIn = null;

      setState(() {
        errorLoginIn = true;
        authenticating = false;
      });
    }
  }
}


  /*return TextFormField(
    enabled: isEnabled ?? true,
    obscureText: isPassword ?? false,
    controller: nameController,
    keyboardType: Keytype,
    //focusNode: focusNode,
    textAlign: textAlign ?? TextAlign.left,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      labelText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      fillColor: Colors.grey[200],
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
    ),
    inputFormatters: maskFormatter != null ? [maskFormatter] : [],
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor preencha o campo correctamente.';
      }
      return null;
    },
  );
}*/