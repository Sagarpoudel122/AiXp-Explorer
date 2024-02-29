part of http_client;

/// HTTP response object returned by [HttpClient] API calls.
@immutable
class HttpRequestBase {
  /// Create a new instance from [HttpClientOptions] and other parameters.
  factory HttpRequestBase.from({
    required HttpClientOptions options,
    required HttpMethod method,
    required String path,
    required JsonMap queryParameters,
  }) =>
      HttpRequestBase._(
        method: method,
        url: Uri.parse(options.baseUrl).replace(
          path: path,
          queryParameters: queryParameters.isNotEmpty
              ? queryParameters.map((String key, dynamic value) => MapEntry<String, dynamic>(key, value.toString()))
              : null,
        ),
        headers: options.headers,
      );

  const HttpRequestBase._({
    required this.method,
    required this.url,
    required this.headers,
  });
  final HttpMethod method;
  final Uri url;
  final JsonMap headers;

  HttpRequestBase copyWith({
    HttpMethod? method,
    Uri? url,
    JsonMap? headers,
  }) =>
      HttpRequestBase._(
        method: method ?? this.method,
        url: url ?? this.url,
        headers: headers ?? this.headers,
      );
}

class HttpRequestWithBody<RequestBodyType> extends HttpRequestBase {
  /// Create a new instance from [HttpClientOptions] and other parameters.
  factory HttpRequestWithBody.from({
    required HttpClientOptions options,
    required HttpMethod method,
    required String path,
    required JsonMap queryParameters,
    required RequestBodyType body,
  }) =>
      HttpRequestWithBody<RequestBodyType>._(
        method: method,
        url: Uri.parse(options.baseUrl).replace(
          path: path,
          queryParameters: queryParameters.isNotEmpty
              ? queryParameters.map((String key, dynamic value) => MapEntry<String, dynamic>(key, value.toString()))
              : null,
        ),
        headers: options.headers,
        body: body,
      );

  const HttpRequestWithBody._({
    required super.method,
    required super.url,
    required super.headers,
    required this.body,
  }) : super._();
  final RequestBodyType body;

  @override
  HttpRequestWithBody<RequestBodyType> copyWith({
    HttpMethod? method,
    Uri? url,
    JsonMap? headers,
    RequestBodyType? body,
  }) =>
      HttpRequestWithBody<RequestBodyType>._(
        method: method ?? this.method,
        url: url ?? this.url,
        headers: headers ?? this.headers,
        body: body ?? this.body,
      );
}
