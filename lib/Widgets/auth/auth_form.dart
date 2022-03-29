import 'package:flutter/material.dart';

enum AuthMode { signUp, logIn }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final _emailUser = TextEditingController();
    final _usernameUser = TextEditingController();
    final _passwordUser = TextEditingController();
    var _isLoading = false;
    AuthMode _authMode = AuthMode.logIn;
    Map<String, String> _authData = {
      'email': '',
      'username': '',
      'password': '',
    };

    Future<void> _submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
    }

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Text(
            "Inicia Sesion",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
          ),
          margin: const EdgeInsets.only(bottom: 20),
        ),
        CircleAvatar(
          radius: 40,
          child: Icon(
            Icons.person,
            size: 44,
            color: Theme.of(context).colorScheme.primary,
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        Card(
          color: Theme.of(context).colorScheme.onPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _emailUser,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value!;
                      },
                      decoration: InputDecoration(
                        label: const Text("Email"),
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _usernameUser,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill this field.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['username'] = value!;
                      },
                      decoration: InputDecoration(
                        label: const Text("Username"),
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordUser,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill this field.';
                        } else if (value.length < 6) {
                          return 'Create a password with at least 6 chareacters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value!;
                      },
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Log in"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
