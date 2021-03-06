import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'subscription.dart';

class CompressMixin {
  final compressProgress$ = ObservableBuilder<double>();
  final _channel = const MethodChannel('video_compress');

  // @protected
  // void initProcessCallback() {
  //   _channel.setMethodCallHandler(_progressCallback);
  // }

  MethodChannel get channel => _channel;

  bool _isCompressing = false;

  bool get isCompressing => _isCompressing;

  @protected
  void setProcessingStatus(bool status) {
    _isCompressing = status;
  }

  // Future<void> _progressCallback(MethodCall call) async {
  //   switch (call.method) {
  //     case 'updateProgress':
  //       final progress = double.tryParse(call.arguments.toString());
  //       if (progress != null) compressProgress$.next(progress);
  //       break;
  //   }
  // }

  /// A stream to listen to video compression progress
  static const EventChannel _progressStream =
  EventChannel('video_compress/stream');

  Stream<double>? _onProgressUpdated;

  /// Fires whenever the uploading progress changes.
  Stream<double> get onProgressUpdated {
    _onProgressUpdated ??= _progressStream
        .receiveBroadcastStream()
        .map<double>((dynamic result) => result != null ? result : 0);
    return _onProgressUpdated!;
  }
}
