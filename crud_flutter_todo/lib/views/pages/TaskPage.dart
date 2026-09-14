import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crud_flutter_todo/providers/task_provider.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(taskProvider.notifier).addTask('Learn Riverpod');
        },
        child: const Icon(Icons.add),
      ),

      body: tasks.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

        error: (error, stack) {
          return Center(
            child: Text('Error: $error'),
          );
        },

        data: (taskList) {
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              final task = taskList[index];

              return ListTile(
                title: Text(task.content),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // EDIT BUTTON
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final controller = TextEditingController(
                              text: task.content,
                            );

                            return AlertDialog(
                              title: const Text('Edit Task'),

                              content: TextField(
                                controller: controller,
                                decoration: const InputDecoration(
                                  labelText: 'Task',
                                ),
                              ),

                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(taskProvider.notifier)
                                        .updateTask(
                                          task.id,
                                          controller.text,
                                        );

                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(taskProvider.notifier)
                            .deleteTask(task.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}