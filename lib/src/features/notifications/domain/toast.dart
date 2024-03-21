part of notifications;

@immutable
class Toast extends Equatable {
  Toast({
    required this.type,
    required this.title,
    this.subtitle,
    this.onTap,
    this.debug = false,
    this.closeOnTap = true,
    DateTime? dateTime,
    Duration? dismissDelay,
  })  : dateTime = dateTime ?? DateTime.now(),
        dismissDelay = (type == ToastType.error) ? null : dismissDelay ?? (const Duration(milliseconds: 5000));
  final ToastType type;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final DateTime dateTime;
  final Duration? dismissDelay;
  final bool debug;
  final bool closeOnTap;

  @override
  List<Object?> get props {
    return <Object?>[
      type,
      title,
      subtitle,
      onTap,
      dateTime,
      dismissDelay,
    ];
  }

  void show([BuildContext? context]) {
    ToastManager().add(this, context: context);
  }

  /// Utility function for handling generic errors.
  /// Only useful as a debugging tool, as errors will not be shown in release mode.
  static void debugShowError(Object error, StackTrace stackTrace, [BuildContext? context]) {
    if (!kDebugMode) {
      return;
    }
    if (error is HttpErrorResponse) {
      final BaseRequest? request = error.rawResponse.request;
      final Response response = error.rawResponse;
      Toast(
        debug: true,
        type: ToastType.http,
        title: '${error.runtimeType}',
        subtitle: '${response.statusCode}: ${request?.method.toUpperCase()} ${request?.url.path}\n'
            '${error.message}.',
      ).show(context);
    } else if (error is HttpError<HttpRequestBase>) {
      final HttpRequestBase request = error.request;

      Toast(
        debug: true,
        type: ToastType.http,
        title: '${error.runtimeType}',
        subtitle: '${request.method.name.toUpperCase()} ${request.url.path}\n'
            '${error.cause}.\n'
            'Click to copy stacktrace.',
        onTap: () {
          Clipboard.setData(ClipboardData(text: stackTrace.toString()));
        },
      ).show(context);
    } else {
      Toast(
        debug: true,
        type: ToastType.dev,
        title: '${error.runtimeType}',
        subtitle: 'Click to copy stacktrace.',
        onTap: () {
          Clipboard.setData(ClipboardData(text: stackTrace.toString()));
        },
      ).show(context);
    }
  }
}
