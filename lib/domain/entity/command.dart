class CommandEntity {
  final int? id;
  final String phoneNumber;
  final String description;
  final String command;

  const CommandEntity({
    this.id,
    required this.phoneNumber,
    required this.description,
    required this.command,
  });
}
