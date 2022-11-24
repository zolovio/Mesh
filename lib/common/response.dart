class ApiResponse {
  late bool isSuccess;
  late String message;
  dynamic data;

  ApiResponse.parse(dynamic response) {
    try {
      isSuccess = response['success'] ?? false;
      message = response['message'] ?? '';
      data = response['data'];
    } catch (e) {
      throw const FormatException();
    }
  }
}
