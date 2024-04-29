extension EnumListUtils<T extends Enum> on Iterable<T> {
  /// Finds the enum value in this list with name [name].
  ///
  /// Goes through this collection looking for an enum with
  /// name [name], as reported by [EnumName.name].
  /// Returns the first value with the given name. If not found, returns null.
  T? byNameOrNull(String name) {
    for (final T value in this) {
      if (value.name == name) {
        return value;
      }
    }
    return null;
  }
}
