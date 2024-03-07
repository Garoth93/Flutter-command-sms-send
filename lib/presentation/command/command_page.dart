import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:test4/domain/entity/chronology.dart';
import 'package:test4/domain/entity/command.dart';
import 'package:test4/domain/use_case/command/delete_commands_use_case.dart';
import 'package:test4/domain/use_case/command/get_commands_by_id_use_case.dart';
import 'package:test4/domain/use_case/command/get_commands_use_case.dart';
import 'package:test4/domain/use_case/sms/send_sms_use_case.dart';
import 'package:test4/presentation/chronology/chronology_page.dart';
import 'package:test4/presentation/command/insert_command_page.dart';
import 'package:test4/presentation/command/update_command_page.dart';

import '../../domain/use_case/chronology/save_chronology_use_case.dart';

class CommandPage extends StatefulWidget {
  const CommandPage({super.key});

  static const String route = '/command';

  @override
  State<StatefulWidget> createState() => CommandPageState();
}

class CommandPageState extends State<CommandPage> {
  final GetCommandsUseCase _getCommandsUseCase = GetCommandsUseCase();
  final DeleteCommandsUseCase _deleteCommandsUseCase = DeleteCommandsUseCase();
  final GetCommandByIdUseCase _getCommandByIdUseCase = GetCommandByIdUseCase();
  final SendSmsUseCase _sendSmsUseCase = SendSmsUseCase();
  final GetChronologyUseCase _getChronologyUseCase = GetChronologyUseCase();

  late List<CommandEntity> _data = [];
  late List<CommandEntity> _filteredData = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCommand();
  }

  Future<void> _loadCommand() async {
    setState(() {
      _isLoading = true;
    });
    List<CommandEntity> data = await _getCommandsUseCase.getCommands();
    setState(() {
      _data = data;
      _filteredData = data;
      _isLoading = false;
    });
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = _data
          .where((a) =>
              a.command.toLowerCase().contains(query.toLowerCase()) ||
              a.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<bool> _deleteCommandById(int? id) async {
    if (id == null) return false;
    CommandEntity commandEntity =
        CommandEntity(id: id, phoneNumber: '', description: '', command: '');
    return await _deleteCommandsUseCase.deleteCommand(commandEntity);
  }

  void _goBack() {
    Navigator.pop(context);
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _filteredData.length,
      itemBuilder: (context, index) {
        final item = _filteredData[index];
        return Dismissible(
          key: Key(item.id.toString()),
          onDismissed: (direction) async {
            await _deleteCommandById(item.id);
            _filteredData.removeAt(index);
            setState(() {});
          },
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Conferma operazione'),
                    content: const Text('Conferma Eliminazione'),
                    actions: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Elimina'),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Annulla'),
                          ),
                        ],
                      )
                    ],
                  );
                });
          },
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: GestureDetector(
            onTap: () async {
              _sendSmsUseCase.sendSMS(item.phoneNumber, item.command);
              String dateNow = DateTime.now().millisecondsSinceEpoch.toString();
              ChronologyEntity chronologyEntityInsert = ChronologyEntity(
                  command: item.command,
                  description: item.description,
                  phoneNumber: item.phoneNumber,
                  date: dateNow);
              _getChronologyUseCase.saveChronology(chronologyEntityInsert);
            },
            onLongPress: () async {
              CommandEntity? commandUpdate =
                  await _getCommandByIdUseCase.getCommandById(item.id!);
              if (commandUpdate != null) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UpdateCommandPage(commandUpdate: commandUpdate)),
                );
                await _loadCommand();
              }
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(item.description),
                    subtitle: Text(item.command),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _floatingSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      spacing: 6,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Aggiungi',
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InsertCommandPage()),
              );
              await _loadCommand();
            }),
        SpeedDialChild(
            child: const Icon(Icons.calendar_month),
            label: 'Cronologia comandi',
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChronologyPage()),
              );
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comandi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterData,
              decoration: const InputDecoration(
                labelText: 'Ricerca',
                hintText: 'Ricerca...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: _listView(),
                ),
        ],
      ),
      floatingActionButton: _floatingSpeedDial(),
    );
  }
}
