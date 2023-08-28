import 'e2_client.dart';

class E2ListenerFilters {
  static bool Function(dynamic data) filterByBox(String boxName) {
    return (dynamic data) {
      final message = data as Map<String, dynamic>;
      final extractedName = E2Client.getBoxName(message);
      return boxName == extractedName;
    };
  }

  static bool Function(dynamic data) excludeBoxes(List<String> boxNames) {
    return (dynamic data) {
      final message = data as Map<String, dynamic>;
      final extractedName = E2Client.getBoxName(message);
      return !boxNames.contains(extractedName);
    };
  }

  static bool Function(dynamic data) excludeNameContains(String filter) {
    return (dynamic data) {
      final message = data as Map<String, dynamic>;
      final extractedName = E2Client.getBoxName(message);
      return !extractedName.contains(filter);
    };
  }

  static bool Function(dynamic data) acceptAll() {
    return (dynamic data) {
      return true;
    };
  }
}
