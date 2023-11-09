import 'package:equatable/equatable.dart';

ErrorModel mapToErrorModel(dynamic error) {
  try {
    final errorModel = ErrorModel.fromJson(error.response?.data);
    return errorModel;
  } catch (e) {
    return const ErrorModel(
      message: 'Что-то пошло не так',
    );
  }
}

class ErrorModel extends Equatable {
  const ErrorModel({
    required this.message,
    this.status,
  });

  final bool? status;
  final String message;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json['status'],
        message: json['message'],
      );

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
