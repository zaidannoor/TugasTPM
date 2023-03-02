import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPM Login',
      home: LoginPage(),
      routes: {
        '/calculator': (BuildContext context) => CalculatorPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // TODO: Replace the following code with your own authentication logic
      // Check if the email and password match the hardcoded values
      if (emailController.text == 'zaidan@gmail.com' &&
          passwordController.text == 'qwertyuiop') {
        // If the email and password match, log the user in and navigate to the home page
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
      } else {
        // If the email and password don't match, show an error message
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Incorrect email or password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TPM Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TPM Home'),
        ),
        body: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                Center(
                    child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text("Data Kelompok",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                )),
                Center(
                    child: Column(children: [
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Zaidan Noor Irfan 123200066",
                      )),
                  Container(
                      child: Text(
                    "Muhammad Mi'raj Rizky 123200080",
                  )),
                ]))
              ],
            )),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            'Home',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/calculator');
                      },
                      child: Container(
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            'Calculator',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController _firstNumberController = TextEditingController();
  TextEditingController _secondNumberController = TextEditingController();
  int _result = 0;

  void _addNumbers() {
    setState(() {
      int firstNumber = int.parse(_firstNumberController.text);
      int secondNumber = int.parse(_secondNumberController.text);
      _result = firstNumber + secondNumber;
    });
  }

  void _subtractNumbers() {
    setState(() {
      int firstNumber = int.parse(_firstNumberController.text);
      int secondNumber = int.parse(_secondNumberController.text);
      _result = firstNumber - secondNumber;
    });
  }

  void _clearResult() {
    setState(() {
      _result = 0;
      _firstNumberController.clear();
      _secondNumberController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _firstNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter first number',
                      ),
                    ),
                    TextField(
                      controller: _secondNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter second number',
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _addNumbers,
                          child: Text('+'),
                        ),
                        ElevatedButton(
                          onPressed: _subtractNumbers,
                          child: Text('-'),
                        ),
                        ElevatedButton(
                          onPressed: _clearResult,
                          child: Text('Clear'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Result: $_result',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            'Home',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/calculator');
                      },
                      child: Container(
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            'Calculator',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
