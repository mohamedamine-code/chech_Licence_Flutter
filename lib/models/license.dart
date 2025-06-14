class License {
  String name;
  DateTime StartDate;
  DateTime FinDate;
  String path;
  String State;
  String id;
  bool? notified = false;
  License({
    required this.id,
    required this.State,
    required this.path,
    required this.name,
    required this.StartDate,
    required this.FinDate,
  });
}