class ApiEndpoints {
  static const String pets = 'pets';
  static String petById(String id) => '$pets/$id';

  static const String match = 'match';
  static String matchById(String id) => '$match/$id';
  static String newMatchForId(String id) => '$match/new/$id';

  static const String chat = 'chat';
  static const String debug = 'debug';
}
