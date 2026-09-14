import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crud_flutter_todo/models/task.dart';
import 'package:crud_flutter_todo/services/database_service.dart';

class TaskNotifier extends AsyncNotifier<List<Task>>{
    @override
    Future<List<Task>> build() async{
        final tasks = await DatabaseService.instance.getTasks();
        return tasks ?? [];
    }
    // Future<void>addTask(String content) async{
    //     final db = await database;
    //     await db.insert(
    //         _tasksTableName,
    //         {
    //             _tasksContentColumnName: content,
    //             _tasksStatusColumnName: 0,
    //         },
    //     );
    // }
    Future<void> addTask(String content) async{
        await DatabaseService.instance.addTask(content);
        ref.invalidateSelf();
    }

    Future<void> deleteTask(int id) async{
        await DatabaseService.instance.deleteTask(id);
        ref.invalidateSelf();
    }

    Future<void> updateTask(int id, String content) async{
        await DatabaseService.instance.updateTask(id,content);
    
        ref.invalidateSelf();
    }
}

final taskProvider = AsyncNotifierProvider<TaskNotifier, List<Task>>(
    TaskNotifier.new,
);