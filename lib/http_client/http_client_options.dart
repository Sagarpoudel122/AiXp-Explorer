part of http_client;

class HttpClientOptions extends Equatable {
  const HttpClientOptions({
    this.baseUrl = '',
    this.headers = const <String, dynamic>{},
    this.tokenFactory,
  });
  final String baseUrl;
  final JsonMap headers;
  final FutureOr<String?> Function()? tokenFactory;

  @override
  List<Object?> get props => <Object?>[
        baseUrl,
        headers,
        tokenFactory,
      ];

  HttpClientOptions copyWith({
    String? baseUrl,
    JsonMap? headers,
    Nullable<String? Function()>? tokenFactory,
  }) =>
      HttpClientOptions(
        baseUrl: baseUrl ?? this.baseUrl,
        headers: headers ?? this.headers,
        tokenFactory: tokenFactory != null ? tokenFactory.value : this.tokenFactory,
      );
}
