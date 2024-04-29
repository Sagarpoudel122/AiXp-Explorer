part of http_client;

/// HTTP error response object.
/// Represents an HTTP response with an error status code.
@immutable
class HttpErrorResponse extends HttpResponse<dynamic> implements Exception {
  HttpErrorResponse({
    required super.body,
    required super.rawResponse,
  }) {
    if (body is JsonMap) {
      message = (body as JsonMap)['message'].toString();
    } else {
      message = '';
    }
  }
  late final String message;

  @override
  HttpErrorResponse copyWith({
    dynamic body,
    http.Response? rawResponse,
  }) =>
      HttpErrorResponse(
        body: body ?? this.body,
        rawResponse: rawResponse ?? this.rawResponse,
      );
}
