import 'package:flutter/material.dart';

class OnboardingQuestionScreen extends StatelessWidget {
  const OnboardingQuestionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           const  TextField(
              maxLines: 6,
              maxLength: 600,
              decoration: InputDecoration(
                labelText: 'Describe your experience',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle recording logic here
              },
              child: Text('Record Audio'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle recording logic here
              },
              child: Text('Record Video'),
            ),
            // Add animation and other buttons here
          ],
        ),
      ),
    );
  }
}
