part of http_client;

/// HTTP error object.
/// Represents errors tied to an HTTP request, but not originating from it.
///
/// Example: JSON parsing
@immutable
class HttpError<HttpRequestBase> implements Exception {
  const HttpError(
    this.request,
    this.cause,
  );
  final HttpRequestBase request;
  final Object cause;

  @override
  String toString() {
    return 'HttpError($cause)';
  }
}
