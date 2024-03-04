class ChronologyEntity {
  final int? id;
  final String phoneNumber;
  final String description;
  final String command;
  final String date;

  const ChronologyEntity({
    this.id,
    required this.phoneNumber,
    required this.description,
    required this.command,
    required this.date,
  });
}
