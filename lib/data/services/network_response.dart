class NetworkResponse {
  final bool isSuccess;
  final String? message;
  final int statusCode;
  final Map<String, dynamic>? data;

  NetworkResponse({
    required this.isSuccess,
    this.message = 'Something Went Wrong!',
    required this.statusCode,
    this.data,
  });
}