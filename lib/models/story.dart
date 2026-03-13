import 'user.dart';

class Story {
  final String id;
  final User user;
  final bool isSeen;

  Story({
    required this.id,
    required this.user,
    this.isSeen = false,
  });
}
