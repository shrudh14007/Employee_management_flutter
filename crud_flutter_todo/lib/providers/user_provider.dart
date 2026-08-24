import 'package:crud_flutter_todo/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersProvider = Provider<List<User>>((ref) {
  return users;
});