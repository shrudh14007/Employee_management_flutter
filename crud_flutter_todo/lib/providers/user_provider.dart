import 'package:crud_flutter_todo/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crud_flutter_todo/services/database_service.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService.instance;
});

class UsersNotifier extends AsyncNotifier<List<User>> {
  @override
  Future<List<User>> build() async {
    final database = ref.read(databaseServiceProvider);

    final users = await database.getUsers();

    return users;
  }
   Future<void> addUser(
    String name,
    String profession,
  ) async {
    final database = ref.read(databaseServiceProvider);

    await database.addUser(
      name,
      profession,
    );

    ref.invalidateSelf();
  }
  Future <void> updateUser(int id,String name,String profession ) async{
    final database = ref.read(databaseServiceProvider);
    await database.updateUser(id,name,profession);
    ref.invalidateSelf();

  }

  Future <void> deleteUser(int id) async{
    final database = ref.read(databaseServiceProvider);
    await database.deleteUser(id);
    ref.invalidateSelf();
  }

}

final usersProvider =
    AsyncNotifierProvider<UsersNotifier, List<User>>(
  UsersNotifier.new,
);

final employeeMessageProvider =
    Provider<String>((ref) {
  return 'Employee management system';
});