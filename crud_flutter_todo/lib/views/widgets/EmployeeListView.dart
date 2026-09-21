  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:crud_flutter_todo/providers/user_provider.dart';

  class Employeelistview extends ConsumerWidget {
    const Employeelistview({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final userList = ref.watch(usersProvider);

      final isActionLoading = ref.watch(employeeActionLoadingProvider);

      final employeeCount = userList.when(
        loading: () => 0,
        error: (error, stackTrace) => 0,
        data: (users) => users.length,
      );

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.white,
          title: Text(
            'EMPLOYEES: $employeeCount',
          ),
          centerTitle: true,
        ),

        body: userList.when(
          // 1. SQLite is loading
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },

          // 2. Something went wrong
          error: (error, stackTrace) {
            return Center(
              child: Text(
                'Error: $error',
              ),
            );
          },

          // 3. SQLite returned the employees
          data: (users) {
            return ListView.separated(
              itemCount: users.length,

              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
  title: Text(user.name),
  subtitle: Text(user.profession),

  trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        final nameController = TextEditingController(
          text: user.name,
        );

        final professionController = TextEditingController(
          text: user.profession,
        );

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Edit Employee'),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextField(
                    controller: professionController,
                    decoration: const InputDecoration(
                      labelText: 'Profession',
                    ),
                  ),
                ],
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(usersProvider.notifier)
                        .updateUser(
                          user.id,
                          nameController.text.trim(),
                          professionController.text.trim(),
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

      onPressed: () async {
        await ref
            .read(usersProvider.notifier)
            .deleteUser(user.id);
      },
    ),
  ],
),
);
              },

              separatorBuilder: (context, index) {
                return const Divider(height: 1);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
    onPressed: () {
      final nameController = TextEditingController();
      final professionController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Employee'),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),

                TextField(
                  controller: professionController,
                  decoration: const InputDecoration(
                    labelText: 'Profession',
                  ),
                ),
              ],
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),

              ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(usersProvider.notifier)
                      .addUser(
                        nameController.text.trim(),
                        professionController.text.trim(),
                      );

                  Navigator.pop(context);
                },
                child: isActionLoading
              ? const CircularProgressIndicator()
              : const Text('Save'),
              ),
            ],
          );
        },
      );
    },
    child: const Icon(Icons.add),
  ),
      );
    }
  }