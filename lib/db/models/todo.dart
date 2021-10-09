// Table name is database
final String tableTodos = 'todos';

// Fields in the table
class ToDoFields {
  static final List<String> values = [
    // Add all fields
    id, isCompleted, description, createdTime, deadlineTime
  ];
  static const String id = '_id';
  static const String isCompleted = 'isCompleted';
  static const String description = 'description';
  static const String createdTime = 'createdTime';
  static const String deadlineTime = 'deadlineTime';
}

// Model for ToDo
class ToDo {
  final int? id;
  final bool isCompleted;
  final String description;
  final DateTime createdTime;
  final DateTime deadlineTime;

  // Copies the current instance of todo and modifies required field
  ToDo copy(
          {int? id,
          bool? isCompleted,
          String? description,
          DateTime? createdTime,
          DateTime? deadlineTime}) =>
      ToDo(
          id: id ?? this.id,
          isCompleted: isCompleted ?? this.isCompleted,
          description: description ?? this.description,
          deadlineTime: deadlineTime ?? this.deadlineTime,
          createdTime: createdTime ?? this.createdTime);

  const ToDo({
    this.id,
    required this.isCompleted,
    required this.description,
    required this.createdTime,
    required this.deadlineTime,
  });

  // Converts JSON to todo object
  static ToDo fromJson(Map<String, Object?> json) => ToDo(
      id: json[ToDoFields.id] as int?,
      isCompleted: json[ToDoFields.isCompleted] == 1 ? true : false,
      description: json[ToDoFields.description] as String,
      createdTime: DateTime.parse(json[ToDoFields.createdTime] as String),
      deadlineTime: DateTime.parse(json[ToDoFields.deadlineTime] as String));

  // Converts todo object to JSON
  Map<String, Object?> toJson() => {
        ToDoFields.id: id,
        ToDoFields.isCompleted: isCompleted ? 1 : 0,
        ToDoFields.description: description,
        ToDoFields.createdTime: createdTime.toIso8601String(),
        ToDoFields.deadlineTime: deadlineTime.toIso8601String(),
      };
}
