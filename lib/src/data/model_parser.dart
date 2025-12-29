import 'dart:convert';

class ModelParser {
  static T parseObject<T>(
    dynamic jsonOrString,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final dynamic decoded =
        (jsonOrString is String) ? jsonDecode(jsonOrString) : jsonOrString;

    if (decoded is! Map<String, dynamic>) {
      throw FormatException('Expected a JSON object (Map) for $T');
    }

    return fromJson(decoded);
  }

  static List<T> parseList<T>(
    dynamic jsonOrString,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final dynamic decoded =
        (jsonOrString is String) ? jsonDecode(jsonOrString) : jsonOrString;

    if (decoded is! List) {
      throw FormatException('Expected a JSON array (List) for List<$T>');
    }

    return decoded
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  ///  usage:
  ///    final user =ModelParser. parseObject<User>(data, User.fromJson);

  ///   final users =ModelParser. parseList<User>(data,User.fromJson);
}
