import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:update_checker/src/repositories/firebase_base.dart';

/// Firebase Remote Config repository will help to fetch the update information from
/// the firebase database.
class FirebaseRemoteConfigRepository implements FireBaseBase {
  /// Initializes the Firebase Database repository
  const FirebaseRemoteConfigRepository();

  static const String _versionControlKey = 'p2p_in_app_dialog';

  /// Fetches the update information from the database.
  @override
  Future<String> fetchUpdateData() async {
    final RemoteConfigValue remoteConfigValue =
        FirebaseRemoteConfig.instance.getValue(_versionControlKey);
    return remoteConfigValue.asString();
  }
}
