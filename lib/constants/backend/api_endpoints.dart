class ApiEndpoints {
  static const String pets = 'pets';
  static String petById(String id) => '$pets/$id';

  static const String match = 'match';
  static String matchById(String id) => '$match/$id';
  static String newMatchForId(String id) => '$match/new/$id';

  static const String chat = 'chat';
  static String allMatchesForPet(String id) => '$chat/all/$id';
  static String allMessagesForMatch(String id) => "$chat/$id";
  static String sendMessage(String id) => "$chat/$id";

  static const String debug = 'debug';
}
