import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:test4/domain/entity/user.dart';
import 'package:test4/domain/use_case/command/delete_all_commands_use_case.dart';
import 'package:test4/domain/use_case/user/delete_all_users_use_case.dart';
import 'package:test4/domain/use_case/user/get_users_by_username_use_case.dart';
import 'package:test4/domain/use_case/user/get_users_use_case.dart';
import 'package:test4/presentation/command/command_page.dart';
import 'package:test4/presentation/login/insert_user_page.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  late bool isInsertButtonVisible = false;

  DeleteAllCommandsUseCase _deleteAllCommandsUseCase =
      DeleteAllCommandsUseCase();
  DeleteAllUsersUseCase _deleteAllUsersUseCase = DeleteAllUsersUseCase();
  GetUsersUseCase _getUsersUseCase = GetUsersUseCase();
  GetUsersByUsernameUseCase _getUsersByUsernameUseCase =
      GetUsersByUsernameUseCase();

  void initPage() {
    init();
  }

  void init() {
    _getUsersUseCase.getUsers().then((users) {
      setState(() {
        isInsertButtonVisible = users.isEmpty;
      });
    });
  }

  void deleteAllData() async {
    try {
      await _deleteAllUsersUseCase.deleteAllUser();
      await _deleteAllCommandsUseCase.deleteAllCommand();
    } catch (error) {}
  }

  Future<bool> isValidUser(String username, String password) async {
    try {
      UserEntity? loadUser =
          await _getUsersByUsernameUseCase.getUserByUsername(username);
      if (loadUser == null) return false;
      return loadUser.password == password;
    } catch (error) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    initPage();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _floatingSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      spacing: 6,
      children: [
        if (isInsertButtonVisible)
          SpeedDialChild(
              child: const Icon(Icons.add),
              label: 'Aggiungi',
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InsertUserPage()),
                ).then((_) {
                  initPage();
                });
              }),
        SpeedDialChild(
            child: const Icon(Icons.delete),
            label: 'Reset dati applicazione',
            onTap: () async {
              deleteAllData();
              init();
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: TextField(
                controller: _userController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () async {
                  if (await isValidUser(
                      _userController.text, _passwordController.text))
                    context.go(CommandPage.route);
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Errore combinazione utente passowrd non valida'),
                        duration: Duration(
                            seconds: 2), // Imposta la durata del messaggio
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _floatingSpeedDial(),
    );
  }
}
