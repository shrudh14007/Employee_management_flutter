import 'package:crud_flutter_todo/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final usersProvider = Provider<List<User>>((ref) {
//   return users;
// });

class UsersNotifier extends Notifier<List<User>>{
  @override

  //to initialize state 
  List<User>build(){
    return users;
  }


void addUser(String name, String profession){
  state = [
    ...state, User(name,profession)
  ];
}

void deleteUser(int index){
  final newUsers=[...state];
  newUsers.removeAt(index);
  state = newUsers;
}

void updateUsers(int index, String name, String profession){
  final newUsers = [...state];
  newUsers[index] = User(name,profession);
  state = newUsers;
}

}
final usersProvider = NotifierProvider<UsersNotifier, List<User>>(
  UsersNotifier.new
);