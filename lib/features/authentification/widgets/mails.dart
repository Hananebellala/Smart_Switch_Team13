import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Mails extends StatefulWidget {
  const Mails({super.key});

  @override
  State<Mails> createState() => _MailsState();
}

class _MailsState extends State<Mails> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Mail',
            labelText: 'Mail',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final Email email = Email(
              subject: 'Subject of the email',
              recipients: ['example@example.com'],
              body: 'Body of the message',
            );

            try {
              await FlutterEmailSender.send(email);
              print('Email sent successfully');
            } catch (error) {
              print('Error sending email: $error');
            }
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}