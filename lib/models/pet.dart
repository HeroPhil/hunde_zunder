import 'package:uuid/uuid.dart';

class Pet {
  // Mocked
  late final String id;
  final String name;
  final String imageUrl;

  Pet({
    required this.name,
    required this.imageUrl,
  }) {
    id = Uuid().v4();
  }
}
