import 'package:bytebank/models/contact.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full name',
              ),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: _accountNumberController,
                decoration: const InputDecoration(
                  labelText: 'Account number',
                ),
                style: const TextStyle(
                  fontSize: 24,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    final String name = _nameController.text;
                    final int? accountNumber =
                        int.tryParse(_accountNumberController.text);

                    if (accountNumber == null) {
                      return;
                    }

                    final Contact newContact = Contact(0, name, accountNumber);

                    await dependencies.contactDao.save(newContact);

                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
