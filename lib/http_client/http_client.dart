part of http_client;

/// HTTP wrapper responsible for communicating with a REST API.
///
/// Ensure that the client is configured using `HttpClient.initialize()` before making any requests.
///
/// The client automatically converts json-objects to json-formatted strings before sending them to the API.
/// The request/response bodies are one of the following types:
///  - `JsonMap` (shorthand for `Map<String, dynamic>`)
///  - `JsonList` (shorthand for `List<dynamic>`)
///  - `JsonSet` (shorthand for `Set<dynamic>`)
///  - Primitive types (`String`, `int`, `bool`, etc.)
///
/// Using the `<method>Obj` functions is preferred as error handling will take JSON conversions in consideration.
/// If the `responseFromJson` parameter is set when calling request methods, the client automatically runs `responseFromJson` on the received json-object.
/// Setting `responseFromJson` is prefered as parsing errors will be tied to the API request and automatically logged in greater detail.
///
/// NOTE: Even though the `responseFromJson` function takes a `dynamic` object as parameter, the runtime type is always one of the json-object types previously mentioned.
///
///
/// Example (2 variants):
/// ```dart
/// class Person {
///   ...
///
///   JsonMap toJson() => {...};
///
///   factory Person.fromMap(JsonMap map) => Person(...);
/// }
///
/// Future<Person> updatePersonV1(Person person) async {
///   final response = await HttpClient.instance.patchObj<Person, Person>(
///     path: '/persons/$id',
///     body: person,
///     requestToJson: (person) => person.toJson(),
///     responseFromJson: (json) => Person.fromMap(json as JsonMap) // Roughly safe to assume json-object type
///   );
///   return response.data;
/// }
///
/// Future<Person> updatePersonV2(Person person) async {
///   final response = await HttpClient.instance.patchObj<dynamic, Person>(
///     path: '/persons/$id',
///     body: person.toJson(),
///     responseFromJson: (json) => Person.fromMap(json as JsonMap) // Roughly safe to assume json-object type
///   );
///   return response.data;
/// }
/// ```
@immutable
class HttpClient extends http.BaseClient {
  HttpClient._({
    required this.options,
    required this.onError,
  });

  static late final HttpClient instance;

  final http.Client _inner = http.Client();
  // final Logger logger = LoggerUtils.defaultLogger;
  final HttpClientOptions options;
  final void Function(Object error, StackTrace stackTrace)? onError;

  /// Initializes the static `instance` field with default values.
  static void initialize({
    HttpClientOptions? options,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    instance = HttpClient._(
      options: options ?? const HttpClientOptions(),
      onError: onError,
    );
  }

  // HttpClient copyWith({
  //   HttpClientOptions? options,
  //   Logger? logger,
  // }) =>
  //     HttpClient._(
  //       options: options ?? const HttpClientOptions(),
  //       onError: onError,
  //     );

  Future<http.Response> getForPath({
    required String path,
    JsonMap queryParameters = const <String, dynamic>{},
    bool callOnError = true,
  }) {
    return sendRequest(
      request: HttpRequestBase.from(
        options: options,
        method: HttpMethod.GET,
        path: path,
        queryParameters: queryParameters,
      ),
      callOnError: callOnError,
    );
  }

  Future<HttpResponse<ResponseBodyType>> getTyped<ResponseBodyType>({
    required String path,
    JsonMap queryParameters = const <String, dynamic>{},
    FromJson<ResponseBodyType>? responseFromJson,
    bool callOnError = true,
  }) {
    return sendTypedOutput<ResponseBodyType>(
      request: HttpRequestBase.from(
        options: options,
        method: HttpMethod.GET,
        path: path,
        queryParameters: queryParameters,
      ),
      responseFromJson: responseFromJson,
      callOnError: callOnError,
    );
  }

  Future<HttpResponse<ResponseBodyType>> postTyped<RequestBodyType, ResponseBodyType>({
    required String path,
    required RequestBodyType body,
    JsonMap queryParameters = const <String, dynamic>{},
    ToJson<RequestBodyType>? requestToJson,
    FromJson<ResponseBodyType>? responseFromJson,
    bool callOnError = true,
    JsonMap? headerOverrides,
  }) {
    var request = HttpRequestWithBody<RequestBodyType>.from(
      options: options,
      method: HttpMethod.POST,
      path: path,
      queryParameters: queryParameters,
      body: body,
    );
    if (headerOverrides != null) {
      request = request.copyWith(headers: headerOverrides);
    }
    return sendTypedRequest<RequestBodyType, ResponseBodyType>(
      request: request,
      requestToJson: requestToJson,
      responseFromJson: responseFromJson,
      callOnError: callOnError,
    );
  }

  Future<http.Response> postTypedInput<RequestBodyType>({
    required String path,
    required RequestBodyType body,
    JsonMap queryParameters = const <String, dynamic>{},
    ToJson<RequestBodyType>? requestToJson,
    bool callOnError = true,
    JsonMap? headerOverrides,
  }) {
    var request = HttpRequestWithBody<RequestBodyType>.from(
      options: options,
      method: HttpMethod.POST,
      path: path,
      queryParameters: queryParameters,
      body: body,
    );
    if (headerOverrides != null) {
      request = request.copyWith(headers: headerOverrides);
    }
    return sendTypedInput<RequestBodyType>(
      request: request,
      requestToJson: requestToJson,
      callOnError: callOnError,
    );
  }

  Future<HttpResponse<ResponseBodyType>> postTypedOutput<ResponseBodyType>({
    required String path,
    JsonMap queryParameters = const <String, dynamic>{},
    FromJson<ResponseBodyType>? responseFromJson,
    bool callOnError = true,
  }) {
    return sendTypedOutput<ResponseBodyType>(
      request: HttpRequestBase.from(
        options: options,
        method: HttpMethod.POST,
        path: path,
        queryParameters: queryParameters,
      ),
      responseFromJson: responseFromJson,
      callOnError: callOnError,
    );
  }

  Future<HttpResponse<ResponseBodyType>> patchTyped<RequestBodyType, ResponseBodyType>({
    required String path,
    required RequestBodyType body,
    JsonMap queryParameters = const <String, dynamic>{},
    ToJson<RequestBodyType>? requestToJson,
    FromJson<ResponseBodyType>? responseFromJson,
    bool callOnError = true,
  }) {
    return sendTypedRequest<RequestBodyType, ResponseBodyType>(
      request: HttpRequestWithBody<RequestBodyType>.from(
        options: options,
        method: HttpMethod.PATCH,
        path: path,
        queryParameters: queryParameters,
        body: body,
      ),
      requestToJson: requestToJson,
      responseFromJson: responseFromJson,
      callOnError: callOnError,
    );
  }

  Future<HttpResponse<ResponseBodyType>> deleteTyped<RequestBodyType, ResponseBodyType>({
    required String path,
    required RequestBodyType body,
    JsonMap queryParameters = const <String, dynamic>{},
    ToJson<RequestBodyType>? requestToJson,
    FromJson<ResponseBodyType>? responseFromJson,
    bool callOnError = true,
  }) {
    return sendTypedRequest<RequestBodyType, ResponseBodyType>(
      request: HttpRequestWithBody<RequestBodyType>.from(
        options: options,
        method: HttpMethod.DELETE,
        path: path,
        queryParameters: queryParameters,
        body: body,
      ),
      requestToJson: requestToJson,
      responseFromJson: responseFromJson,
      callOnError: callOnError,
    );
  }

  Future<http.Response> deleteTypedInput<RequestBodyType>({
    required String path,
    required RequestBodyType body,
    JsonMap queryParameters = const <String, dynamic>{},
    ToJson<RequestBodyType>? requestToJson,
    bool callOnError = true,
  }) {
    return sendTypedInput<RequestBodyType>(
      request: HttpRequestWithBody<RequestBodyType>.from(
        options: options,
        method: HttpMethod.DELETE,
        path: path,
        queryParameters: queryParameters,
        body: body,
      ),
      requestToJson: requestToJson,
      callOnError: callOnError,
    );
  }

  Future<http.Response> patchTypedInput<RequestBodyType>({
    required String path,
    required RequestBodyType body,
    JsonMap queryParameters = const <String, dynamic>{},
    ToJson<RequestBodyType>? requestToJson,
    bool callOnError = true,
  }) {
    return sendTypedInput<RequestBodyType>(
      request: HttpRequestWithBody<RequestBodyType>.from(
        options: options,
        method: HttpMethod.PATCH,
        path: path,
        queryParameters: queryParameters,
        body: body,
      ),
      requestToJson: requestToJson,
      callOnError: callOnError,
    );
  }

  Future<HttpResponse<ResponseBodyType>> putTyped<RequestBodyType, ResponseBodyType>({
    required String path,
    required RequestBodyType body,
    JsonMap queryParameters = const <String, dynamic>{},
    ToJson<RequestBodyType>? requestToJson,
    FromJson<ResponseBodyType>? responseFromJson,
    bool callOnError = true,
  }) {
    return sendTypedRequest<RequestBodyType, ResponseBodyType>(
      request: HttpRequestWithBody<RequestBodyType>.from(
        options: options,
        method: HttpMethod.PUT,
        path: path,
        queryParameters: queryParameters,
        body: body,
      ),
      requestToJson: requestToJson,
      responseFromJson: responseFromJson,
      callOnError: callOnError,
    );
  }

  Future<http.Response> putTypedInput<RequestBodyType>({
    required String path,
    required RequestBodyType body,
    JsonMap queryParameters = const <String, dynamic>{},
    ToJson<RequestBodyType>? requestToJson,
    bool callOnError = true,
  }) {
    return sendTypedInput<RequestBodyType>(
      request: HttpRequestWithBody<RequestBodyType>.from(
        options: options,
        method: HttpMethod.PUT,
        path: path,
        queryParameters: queryParameters,
        body: body,
      ),
      requestToJson: requestToJson,
      callOnError: callOnError,
    );
  }

  Future<http.Response> deleteForPath({
    required String path,
    JsonMap queryParameters = const <String, dynamic>{},
    bool callOnError = true,
  }) {
    return sendRequest(
      request: HttpRequestBase.from(
        options: options,
        method: HttpMethod.DELETE,
        path: path,
        queryParameters: queryParameters,
      ),
      callOnError: callOnError,
    );
  }

  Future<http.Response> sendRequest({
    required HttpRequestBase request,
    Map<String, dynamic>? body,
    bool callOnError = true,
  }) async {
    final http.Request rawRequest = http.Request(request.method.name, request.url)
      ..headers['content-type'] = 'application/json'
      ..body = jsonEncode(body ?? {});

    try {
      final http.StreamedResponse streamedResponse = await send(rawRequest, handleClientError: false);
      // Parse response object.
      final http.Response rawResponse = await http.Response.fromStream(streamedResponse);
      return rawResponse;
    } catch (error, stackTrace) {
      if (error is HttpErrorResponse) {
        // Call onError on error responses
        if (callOnError) {
          onError?.call(error, stackTrace);
        }
        rethrow;
      } else {
        // Calls onError on any random HttpClient errors that may appear.
        // Also logs the error as the send call above is specifically configured to not handle these types of errors.
        // logger.e(
        //   'HTTP Client error at ${request.method} ${request.url}\n'
        //   'Error: $error\n',
        //   null,
        //   kDebugMode ? stackTrace : null,
        // );
        if (callOnError) {
          onError?.call(error, stackTrace);
        }
        Error.throwWithStackTrace(error, stackTrace);
      }
    }
  }

  Future<HttpResponse<ResponseBodyType>> sendTypedRequest<RequestBodyType, ResponseBodyType>({
    required HttpRequestWithBody<RequestBodyType> request,
    ToJson<RequestBodyType>? requestToJson,
    FromJson<ResponseBodyType>? responseFromJson,
    bool callOnError = true,
  }) async {
    assert(
      _isJsonPrimitive<RequestBodyType>() || requestToJson != null,
      'requestToJson must be provided if RequestBodyType is not a json primitive ($RequestBodyType)',
    );
    assert(
      _isJsonPrimitive<ResponseBodyType>() || responseFromJson != null,
      'responseFromJson must be provided if ResponseBodyType is not a json primitive ($ResponseBodyType)',
    );
    try {
      // Build request object.
      final String? body = request.body != null ? jsonEncode(requestToJson?.call(request.body) ?? request.body) : null;
      final http.Request rawRequest = http.Request(request.method.name, request.url)
        ..headers['content-type'] = 'application/json'
        ..body = body ?? '';
      // Send the raw request and do not handle any HttpClientErrors.
      // This ensures we have at max one error per request.
      final http.StreamedResponse streamedResponse = await send(rawRequest, handleClientError: false);
      // Parse response object.
      final http.Response rawResponse = await http.Response.fromStream(streamedResponse);
      if (rawResponse.body.isEmpty) {
        throw HttpJsonParseError<HttpRequestWithBody<RequestBodyType>>(
          request,
          'Received empty body in a typed request',
        );
      }
      try {
        if (ResponseBodyType == String) {
          return HttpResponse<ResponseBodyType>(body: rawResponse.body as ResponseBodyType, rawResponse: rawResponse);
        }
        final HttpResponse<ResponseBodyType> response = HttpResponse<ResponseBodyType>.fromResponse(
          response: rawResponse,
          fromJson: responseFromJson,
        );
        return response;
      } catch (error, stackTrace) {
        if (error is HttpErrorResponse) {
          rethrow;
        }
        Error.throwWithStackTrace(HttpJsonParseError<HttpRequestWithBody<RequestBodyType>>(request, error), stackTrace);
      }
    } catch (error, stackTrace) {
      if (error is HttpErrorResponse) {
        // Call onError on error responses
        if (callOnError) {
          onError?.call(error, stackTrace);
        }
        rethrow;
      } else {
        // Calls onError on any random HttpClient errors that may appear.
        // Also logs the error as the send call above is specifically configured to not handle these types of errors.
        final HttpError<HttpRequestWithBody<RequestBodyType>> httpError =
            error is HttpError<HttpRequestWithBody<RequestBodyType>> ? error : HttpError<HttpRequestWithBody<RequestBodyType>>(request, error);
        // logger.e(
        //   'HTTP Client error at ${request.method} ${request.url}\n'
        //   'Error: $httpError\n',
        //   null,
        //   kDebugMode ? stackTrace : null,
        // );
        if (callOnError) {
          onError?.call(httpError, stackTrace);
        }
        Error.throwWithStackTrace(httpError, stackTrace);
      }
    }
  }

  Future<http.Response> sendTypedInput<RequestBodyType>({
    required HttpRequestWithBody<RequestBodyType> request,
    ToJson<RequestBodyType>? requestToJson,
    bool callOnError = true,
  }) async {
    assert(
      _isJsonPrimitive<RequestBodyType>() || requestToJson != null,
      'requestToJson must be provided if RequestBodyType is not a json primitive ($RequestBodyType)',
    );
    try {
      // Build request object.
      final String? body = request.body != null ? jsonEncode(requestToJson?.call(request.body) ?? request.body) : null;
      final http.Request rawRequest = http.Request(request.method.name, request.url)
        ..headers['content-type'] = 'application/json'
        ..body = body ?? '';
      // Send the raw request and do not handle any HttpClientErrors.
      // This ensures we have at max one error per request.
      final http.StreamedResponse streamedResponse = await send(rawRequest, handleClientError: false);
      // Parse response object.
      final http.Response rawResponse = await http.Response.fromStream(streamedResponse);
      return rawResponse;
    } catch (error, stackTrace) {
      if (error is HttpErrorResponse) {
        // Call onError on error responses
        if (callOnError) {
          onError?.call(error, stackTrace);
        }
        rethrow;
      } else {
        // Calls onError on any random HttpClient errors that may appear.
        // Also logs the error as the send call above is specifically configured to not handle these types of errors.
        final HttpError<HttpRequestWithBody<RequestBodyType>> httpError =
            error is HttpError<HttpRequestWithBody<RequestBodyType>> ? error : HttpError<HttpRequestWithBody<RequestBodyType>>(request, error);
        // logger.e(
        //   'HTTP Client error at ${request.method} ${request.url}\n'
        //   'Error: $httpError\n',
        //   null,
        //   kDebugMode ? stackTrace : null,
        // );
        if (callOnError) {
          onError?.call(httpError, stackTrace);
        }
        Error.throwWithStackTrace(httpError, stackTrace);
      }
    }
  }

  Future<HttpResponse<ResponseBodyType>> sendTypedOutput<ResponseBodyType>({
    required HttpRequestBase request,
    FromJson<ResponseBodyType>? responseFromJson,
    bool callOnError = true,
  }) async {
    assert(
      _isJsonPrimitive<ResponseBodyType>() || responseFromJson != null,
      'responseFromJson must be provided if ResponseBodyType is not a json primitive ($ResponseBodyType)',
    );
    try {
      // Build request object.
      final http.Request rawRequest = http.Request(request.method.name, request.url)
        ..headers['content-type'] = 'application/json'
        ..body = '';
      // Send the raw request and do not handle any HttpClientErrors.
      // This ensures we have at max one error per request.
      final http.StreamedResponse streamedResponse = await send(rawRequest, handleClientError: false);
      // Parse response object.
      final http.Response rawResponse = await http.Response.fromStream(streamedResponse);
      if (rawResponse.body.isEmpty) {
        throw HttpJsonParseError<HttpRequestBase>(
          request,
          'Received empty body in a typed request',
        );
      }
      try {
        if (ResponseBodyType == String) {
          return HttpResponse<ResponseBodyType>(body: rawResponse.body as ResponseBodyType, rawResponse: rawResponse);
        }
        final HttpResponse<ResponseBodyType> response = HttpResponse<ResponseBodyType>.fromResponse(
          response: rawResponse,
          fromJson: responseFromJson,
        );
        return response;
      } catch (error, stackTrace) {
        if (error is HttpErrorResponse) {
          rethrow;
        }
        Error.throwWithStackTrace(HttpJsonParseError<HttpRequestBase>(request, error), stackTrace);
      }
    } catch (error, stackTrace) {
      if (error is HttpErrorResponse) {
        // Call onError on error responses
        if (callOnError) {
          onError?.call(error, stackTrace);
        }
        rethrow;
      } else {
        // Calls onError on any random HttpClient errors that may appear.
        // Also logs the error as the send call above is specifically configured to not handle these types of errors.
        final HttpError<HttpRequestBase> httpError = error is HttpError<HttpRequestBase> ? error : HttpError<HttpRequestBase>(request, error);
        // logger.e(
        //   'HTTP Client error at ${request.method} ${request.url}\n'
        //   'Error: $httpError\n',
        //   null,
        //   kDebugMode ? stackTrace : null,
        // );
        if (callOnError) {
          onError?.call(httpError, stackTrace);
        }
        Error.throwWithStackTrace(httpError, stackTrace);
      }
    }
  }

  @override
  Future<http.StreamedResponse> send(
    http.BaseRequest request, {
    bool handleClientError = true,
  }) async {
    try {
      // Add authorization token to request headers.
      final String? token = await options.tokenFactory?.call();
      // logger.i(token, "token");
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      // Make the actual request.
      final http.StreamedResponse streamedResponse = await _inner.send(request);
      if (streamedResponse.statusCode < 300) {
        // Log successful responses as info.
        // logger.i(
        //   'HTTP Response received ${streamedResponse.statusCode} ${streamedResponse.reasonPhrase?.isNotEmpty ?? false ? '- ${streamedResponse.reasonPhrase}' : ''}'
        //   'from ${request.method} ${request.url}',
        // );
      } else {
        // Log error responses as warnings.
        // logger.w(
        //   'HTTP Error response received ${streamedResponse.statusCode} ${streamedResponse.reasonPhrase?.isNotEmpty ?? false ? '- ${streamedResponse.reasonPhrase}' : ''}'
        //   'from ${request.method} ${request.url}',
        // );
      }
      return streamedResponse;
    } catch (error, stackTrace) {
      // Log any random HttpClient errors.
      if (handleClientError) {
        // logger.e(
        //   'HTTP Client error at ${request.method} ${request.url}\n'
        //   'Error: $error\n',
        //   null,
        //   kDebugMode ? stackTrace : null,
        // );

        onError?.call(error, stackTrace);
      }
      rethrow;
    }
  }
}
