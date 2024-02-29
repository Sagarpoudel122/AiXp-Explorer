part of http_client;

class HttpJsonParseError<HttpRequestBase> extends HttpError<HttpRequestBase> {
  const HttpJsonParseError(
    super.request,
    super.cause,
  );

  @override
  String toString() {
    return 'HttpJsonParseError($cause)';
  }
}
