class BackendEndpoints {
  static const String pets = 'pets';
  static String petById(String id) => '$pets/$id';

  static const String match = 'match';
  static String matchById(String id) => '$match/$id';

  static const String chat = 'chat';
  static const String debug = 'debug';
}
