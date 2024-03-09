import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/chronology.dart';
import 'package:test4/domain/repository/abstract_chronology_repository.dart';
import 'package:test4/domain/use_case/chronology/get_chronology_use_case.dart';

class ChronologyPage extends StatefulWidget {
  const ChronologyPage({super.key});

  @override
  State<StatefulWidget> createState() => ChronologyPageState();
}

class ChronologyPageState extends State<ChronologyPage> {
  GetChronologyUseCase getChronologyCommand = GetChronologyUseCase();

  late List<ChronologyEntity> _data = [];
  late List<ChronologyEntity> _filteredData = [];

  DateTime? _startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? _endDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadChronology().then((_) {
      _filterDateTime();
      _filterData;
    });
  }

  Future<void> _loadChronology() async {
    setState(() {
      _isLoading = true;
    });
    List<ChronologyEntity> data = await getChronologyCommand.getChronology();
    _data = data;
    _filteredData = data;
    _isLoading = false;
    setState(() {});
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = _data
          .where((a) =>
              (a.command.toLowerCase().contains(query.toLowerCase()) ||
                  a.description.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  void _filterDateTime() async {
    setState(() {
      _filteredData = _data
          .where((a) => (DateTime.fromMillisecondsSinceEpoch(int.parse(a.date))
                  .isAfter(_startDate!) &&
              DateTime.fromMillisecondsSinceEpoch(int.parse(a.date))
                  .isBefore(_endDate!)))
          .toList();
    });
  }

  void _goBack() {
    Navigator.pop(context);
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _filteredData.length,
      itemBuilder: (context, index) {
        final item = _filteredData[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text(item.description),
                subtitle: Text(
                    'Numero: ${item.phoneNumber} \nData ora: ${DateTime.fromMillisecondsSinceEpoch(int.parse(item.date)).toString()}'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronologia'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: _filterData,
                    decoration: InputDecoration(
                      labelText: 'Da data',
                      hintText: 'Seleziona data',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != _startDate) {
                        setState(() {
                          _startDate = picked;
                          _filterDateTime();
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'A data',
                      hintText: 'Seleziona data',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _endDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != _endDate) {
                        setState(() {
                          _endDate = picked.add(Duration(days: 1));
                          _filterDateTime();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: _listView(),
                ),
        ],
      ),
    );
  }
}
