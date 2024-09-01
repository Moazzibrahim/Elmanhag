
import 'package:flutter/material.dart';

class ComplaintsSuggestionsScreen extends StatefulWidget {
  const ComplaintsSuggestionsScreen({super.key});

  @override
  State<ComplaintsSuggestionsScreen> createState() =>
      _ComplaintsSuggestionsScreenState();
}

class _ComplaintsSuggestionsScreenState
    extends State<ComplaintsSuggestionsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints and Suggestions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'We value your feedback. Please let us know your complaints or suggestions.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _feedbackController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your complaint or suggestion here...',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your feedback';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle the feedback submission logic
                        final feedback = _feedbackController.text;
                        // For now, we'll just show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Feedback submitted: $feedback'),
                          ),
                        );
                        // Clear the text field after submission
                        _feedbackController.clear();
                      }
                    },
                    child: const Text('Submit'),
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
