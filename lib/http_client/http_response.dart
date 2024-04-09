part of http_client;

/// HTTP response object returned by [HttpClient] API calls.
@immutable
class HttpResponse<T> {
  const HttpResponse({
    required this.body,
    required this.rawResponse,
  });

  /// Parse a http library [http.Response] object into [HttpClient] instance.
  /// If the status code is in the range of 300-500, a [HttpErrorResponse] instance is retuned instead.
  factory HttpResponse.fromResponse({
    required http.Response response,
    FromJson<T>? fromJson,
  }) {
    final dynamic json = jsonDecode(response.body);
    if (response.statusCode >= 300) {
      throw HttpErrorResponse(
        body: json,
        rawResponse: response,
      );
    }
    return HttpResponse<T>(
      body: (fromJson?.call(json) ?? json) as T,
      rawResponse: response,
    );
  }

  final T body;
  final http.Response rawResponse;

  HttpResponse<T> copyWith({
    T? body,
    http.Response? rawResponse,
  }) =>
      HttpResponse<T>(
        body: body ?? this.body,
        rawResponse: rawResponse ?? this.rawResponse,
      );
}

extension FutureHttpResponse<T> on Future<HttpResponse<T>> {
  /// Strips the response data from a future response and only returns the body.
  Future<T> thenBody() => then((HttpResponse<T?> value) => value.body!);
}
