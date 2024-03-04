// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDAOInstance;

  CommandDao? _commandDAOInstance;

  ChronologyDao? _chronologyDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`username` TEXT NOT NULL, `password` TEXT NOT NULL, PRIMARY KEY (`username`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `comandi` (`id` INTEGER, `phoneNumber` TEXT NOT NULL, `description` TEXT NOT NULL, `command` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `chronology` (`id` INTEGER, `phoneNumber` TEXT NOT NULL, `description` TEXT NOT NULL, `command` TEXT NOT NULL, `date` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDAO {
    return _userDAOInstance ??= _$UserDao(database, changeListener);
  }

  @override
  CommandDao get commandDAO {
    return _commandDAOInstance ??= _$CommandDao(database, changeListener);
  }

  @override
  ChronologyDao get chronologyDAO {
    return _chronologyDAOInstance ??= _$ChronologyDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (UserModel item) => <String, Object?>{
                  'username': item.username,
                  'password': item.password
                }),
        _userModelDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['username'],
            (UserModel item) => <String, Object?>{
                  'username': item.username,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  final DeletionAdapter<UserModel> _userModelDeletionAdapter;

  @override
  Future<List<UserModel>> getUsers() async {
    return _queryAdapter.queryList('SELECT * FROM user',
        mapper: (Map<String, Object?> row) => UserModel(
            username: row['username'] as String,
            password: row['password'] as String));
  }

  @override
  Future<UserModel?> getByUsername(String username) async {
    return _queryAdapter.query('SELECT * FROM user where username = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            username: row['username'] as String,
            password: row['password'] as String),
        arguments: [username]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM user');
  }

  @override
  Future<void> insertUser(UserModel user) async {
    await _userModelInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(UserModel user) async {
    await _userModelDeletionAdapter.delete(user);
  }
}

class _$CommandDao extends CommandDao {
  _$CommandDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _commandModelInsertionAdapter = InsertionAdapter(
            database,
            'comandi',
            (CommandModel item) => <String, Object?>{
                  'id': item.id,
                  'phoneNumber': item.phoneNumber,
                  'description': item.description,
                  'command': item.command
                }),
        _commandModelUpdateAdapter = UpdateAdapter(
            database,
            'comandi',
            ['id'],
            (CommandModel item) => <String, Object?>{
                  'id': item.id,
                  'phoneNumber': item.phoneNumber,
                  'description': item.description,
                  'command': item.command
                }),
        _commandModelDeletionAdapter = DeletionAdapter(
            database,
            'comandi',
            ['id'],
            (CommandModel item) => <String, Object?>{
                  'id': item.id,
                  'phoneNumber': item.phoneNumber,
                  'description': item.description,
                  'command': item.command
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CommandModel> _commandModelInsertionAdapter;

  final UpdateAdapter<CommandModel> _commandModelUpdateAdapter;

  final DeletionAdapter<CommandModel> _commandModelDeletionAdapter;

  @override
  Future<List<CommandModel>> getCommands() async {
    return _queryAdapter.queryList('SELECT * FROM comandi',
        mapper: (Map<String, Object?> row) => CommandModel(
            id: row['id'] as int?,
            phoneNumber: row['phoneNumber'] as String,
            description: row['description'] as String,
            command: row['command'] as String));
  }

  @override
  Future<CommandModel?> getById(int id) async {
    return _queryAdapter.query('SELECT * FROM comandi where id = ?1',
        mapper: (Map<String, Object?> row) => CommandModel(
            id: row['id'] as int?,
            phoneNumber: row['phoneNumber'] as String,
            description: row['description'] as String,
            command: row['command'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM comandi');
  }

  @override
  Future<void> insertCommand(CommandModel command) async {
    await _commandModelInsertionAdapter.insert(
        command, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCommand(CommandModel command) async {
    await _commandModelUpdateAdapter.update(command, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCommand(CommandModel command) async {
    await _commandModelDeletionAdapter.delete(command);
  }
}

class _$ChronologyDao extends ChronologyDao {
  _$ChronologyDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _chronologyModelInsertionAdapter = InsertionAdapter(
            database,
            'chronology',
            (ChronologyModel item) => <String, Object?>{
                  'id': item.id,
                  'phoneNumber': item.phoneNumber,
                  'description': item.description,
                  'command': item.command,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ChronologyModel> _chronologyModelInsertionAdapter;

  @override
  Future<List<ChronologyModel>> getChronology() async {
    return _queryAdapter.queryList('SELECT * FROM chronology',
        mapper: (Map<String, Object?> row) => ChronologyModel(
            id: row['id'] as int?,
            phoneNumber: row['phoneNumber'] as String,
            description: row['description'] as String,
            command: row['command'] as String,
            date: row['date'] as String));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM chronology');
  }

  @override
  Future<void> insertChronology(ChronologyModel chronology) async {
    await _chronologyModelInsertionAdapter.insert(
        chronology, OnConflictStrategy.abort);
  }
}
