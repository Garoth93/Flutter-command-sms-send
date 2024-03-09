import 'package:flutter/material.dart';
import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/command.dart';
import 'package:test4/domain/repository/abstract_command_repository.dart';
import 'package:test4/domain/use_case/command/save_commands_use_case.dart';

class InsertCommandPage extends StatefulWidget {
  const InsertCommandPage({super.key});

  @override
  State<StatefulWidget> createState() => InsertCommandState();
}

class InsertCommandState extends State<InsertCommandPage> {
  late TextEditingController _descriptionController;
  late TextEditingController _commandController;
  late TextEditingController _phoneNumberController;

  final SaveCommandUseCase _saveCommandUseCase = SaveCommandUseCase();

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _commandController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _commandController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserisci nuovo comando'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrizione',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _commandController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Comando',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Numero telefonico',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () async {
                      final description = _descriptionController.text;
                      final command = _commandController.text;
                      final phoneNumber = _phoneNumberController.text;
                      final newCommand = CommandEntity(
                          phoneNumber: phoneNumber,
                          description: description,
                          command: command);
                      await _saveCommandUseCase.saveCommand(newCommand);
                      Navigator.pop(context);
                    },
                    child: const Text('Conferma'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
