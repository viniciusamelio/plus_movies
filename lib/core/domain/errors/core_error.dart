abstract class CoreError implements Exception {
  CoreError({
    required this.message,
    this.code,
    this.stacktrace,
  });

  final String message;
  final int? code;
  final String? stacktrace;
}
