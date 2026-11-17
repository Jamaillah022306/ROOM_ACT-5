import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'logout_helper.dart';

class _Task {
  final String title;
  bool done;

  _Task(this.title, {this.done = false});
}

class HomeScreen extends StatefulWidget {
  final void Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final taskController = TextEditingController();

  final List<_Task> tasks = [
    _Task('Finish Lab Act 6'),
    _Task('Review Flutter navigation'),
    _Task('Submit assignment', done: true),
  ];

  static const List<String> quotes = [
    'Small steps every day lead to big results.',
    'Progress, not perfection.',
    'Every bug you fix makes you a better developer.',
    'Start where you are. Use what you have.',
    'Consistency beats motivation.',
    'Great apps start with a single widget.',
    'Learn a little today, build a lot tomorrow.',
  ];

  static const List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  String get todayText {
    final now = DateTime.now();
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  String get quoteOfTheDay {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    return quotes[dayOfYear % quotes.length];
  }

  int get doneCount => tasks.where((t) => t.done).length;

  void addTask() {
    final title = taskController.text.trim();
    if (title.isEmpty) return;

    setState(() {
      tasks.add(_Task(title));
    });
    taskController.clear();
  }

  void toggleTask(_Task task, bool? value) {
    setState(() {
      task.done = value ?? false;
    });
  }

  void removeTask(_Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  Widget buildGreeting() {
    // First name of the student (same person shown in the Profile screen)
    const name = 'Jamaillah';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: const BoxDecoration(
            color: AppColors.maroonLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.home, size: 60, color: AppColors.maroon),
        ),
        const SizedBox(height: 16),
        Text(
          '$greeting, $name!',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.maroon,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          todayText,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        ),
      ],
    );
  }

  Widget buildQuoteCard() {
    return Card(
      color: AppColors.maroon,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const Icon(Icons.format_quote, color: Colors.white, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'QUOTE OF THE DAY',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    quoteOfTheDay,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTodoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.checklist, color: AppColors.maroon),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'My To-Do List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.maroon,
                    ),
                  ),
                ),
                Text(
                  '$doneCount of ${tasks.length} done',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (tasks.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: Text('No tasks yet. Add one below!')),
              ),
            for (final task in tasks)
              Row(
                children: [
                  Checkbox(
                    value: task.done,
                    activeColor: AppColors.maroon,
                    onChanged: (value) => toggleTask(task, value),
                  ),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15,
                        decoration:
                            task.done ? TextDecoration.lineThrough : null,
                        color: task.done ? Colors.grey : null,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => removeTask(task),
                    icon: const Icon(Icons.close, size: 20),
                    tooltip: 'Remove task',
                  ),
                ],
              ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    onSubmitted: (_) => addTask(),
                    decoration: const InputDecoration(
                      hintText: 'Add a new task...',
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: addTask,
                  icon: const Icon(Icons.add_circle),
                  color: AppColors.maroon,
                  iconSize: 32,
                  tooltip: 'Add task',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: logoutActions(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const SizedBox(height: 12),
                buildGreeting(),
                const SizedBox(height: 20),
                buildQuoteCard(),
                const SizedBox(height: 8),
                buildTodoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}