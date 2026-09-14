import 'dart:async';

import 'package:flutter/foundation.dart';

/// Notifies GoRouter when an auth stream emits.
///
/// Keeps router guards reactive without importing flutter_bloc in the router.
final class GoRouterRefreshStream extends ChangeNotifier {
  /// Subscribes to [stream].
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
