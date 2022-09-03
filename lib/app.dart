// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';
import 'package:widgetbook_challenge/feedback_snackbar.dart';

/// The app.
class App extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  /// Creates a new instance of [App].
  App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = WidgetbookApi();
    final regExp = RegExp('[a-zA-Z]');
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Interview Challenge'),
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello Flutter enthusiast!'),
                SizedBox(height: 30),
                Center(
                  child: TextFormField(
                    controller: nameController,
                    validator: ValidationBuilder()
                        .regExp(regExp, nameController.text)
                        .build(),
                    onChanged: (value) {
                      debugPrint(nameController.text);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF7F7F7),
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(fontSize: 14),
                      prefixIcon: Icon(Icons.abc_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (regExp.hasMatch(nameController.text)) {
                      try {
                        final response = await api.welcomeToWidgetbook(
                          message: nameController.text,
                        );
                        showFeedback(context, response, Colors.green);
                      } catch (e) {
                        showFeedback(context, e.toString(), Colors.red);
                      }
                      debugPrint('you are a go!');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Invalid input, name cannot contain numbers or symbols',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 15,
                              ),
                            ),
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      debugPrint('Invalid input');
                    }
                  },
                  child: Text('Submit name'),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
