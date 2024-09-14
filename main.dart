import 'dart:io';

class Task {
  String name;
  bool isCompleted;

  Task(this.name, {this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}

class ToDoList {
  List<Task> tasks = [];

  void addTask(String taskName) {
    tasks.add(Task(taskName));
    print('Task "$taskName" added.');
  }

  void displayTasks() {
    if (tasks.isEmpty) {
      print('No tasks in the list.');
    } else {
      print('To-Do List:');
      for (int i = 0; i < tasks.length; i++) {
        var status = tasks[i].isCompleted ? '[✓]' : '[ ]';
        print('${i + 1}. $status ${tasks[i].name}');
      }
    }
  }

  void completeTask(int taskNumber) {
    if (taskNumber <= 0 || taskNumber > tasks.length) {
      print('Invalid task number.');
    } else {
      tasks[taskNumber - 1].toggleCompleted();
      print('Task "${tasks[taskNumber - 1].name}" marked as completed.');
    }
  }

  void deleteTask(int taskNumber) {
    if (taskNumber <= 0 || taskNumber > tasks.length) {
      print('Invalid task number.');
    } else {
      var removedTask = tasks.removeAt(taskNumber - 1);
      print('Task "${removedTask.name}" deleted.');
    }
  }
}

void main() {
  var toDoList = ToDoList();

  while (true) {
    print('\nWhat would you like to do?');
    print('1. Add a task');
    print('2. View tasks');
    print('3. Mark a task as completed');
    print('4. Delete a task');
    print('5. Exit');

    stdout.write('Choose an option: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter the task: ');
        var taskName = stdin.readLineSync();
        if (taskName != null && taskName.isNotEmpty) {
          toDoList.addTask(taskName);
        } else {
          print('Task name cannot be empty.');
        }
        break;

      case '2':
        toDoList.displayTasks();
        break;

      case '3':
        toDoList.displayTasks();
        stdout.write('Enter the task number to mark as completed: ');
        var taskNumber = int.tryParse(stdin.readLineSync() ?? '');
        if (taskNumber != null) {
          toDoList.completeTask(taskNumber);
        } else {
          print('Invalid input.');
        }
        break;

      case '4':
        toDoList.displayTasks();
        stdout.write('Enter the task number to delete: ');
        var taskNumberToDelete = int.tryParse(stdin.readLineSync() ?? '');
        if (taskNumberToDelete != null) {
          toDoList.deleteTask(taskNumberToDelete);
        } else {
          print('Invalid input.');
        }
        break;

      case '5':
        print('Exiting...');
        exit(0);

      default:
        print('Invalid choice, please choose a valid option.');
    }
  }
}
