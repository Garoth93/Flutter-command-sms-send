import 'package:flutter/material.dart';
import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/user.dart';
import 'package:test4/domain/repository/abstract_user_repository.dart';

class InsertUserPage extends StatefulWidget {
  const InsertUserPage({super.key});

  @override
  State<StatefulWidget> createState() => InsertUserPageState();
}

class InsertUserPageState extends State<InsertUserPage> {
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  final UserRepository _userRepository = injector<UserRepository>();

  @override
  void initState() {
    super.initState();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> addNewUser(UserEntity user) async {
    try {
      await _userRepository.save(user);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _userController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
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
                      final user = _userController.text;
                      final password = _passwordController.text;
                      final newUser =
                          UserEntity(username: user, password: password);
                      bool success = await addNewUser(newUser);
                      if (success) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Errore durante l\'aggiunta dell\'utente'),
                            duration: Duration(
                                seconds: 2), // Imposta la durata del messaggio
                          ),
                        );
                      }
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
