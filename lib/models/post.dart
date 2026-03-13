import 'user.dart';

class Post {
  final String id;
  final User user;
  final List<String> imageUrls;
  final String caption;
  final int likes;
  final DateTime createdAt;
  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.user,
    required this.imageUrls,
    required this.caption,
    required this.likes,
    required this.createdAt,
    this.isLiked = false,
    this.isSaved = false,
  });

  Post copyWith({
    bool? isLiked,
    bool? isSaved,
  }) {
    return Post(
      id: id,
      user: user,
      imageUrls: imageUrls,
      caption: caption,
      likes: likes,
      createdAt: createdAt,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
