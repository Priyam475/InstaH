import 'dart:async';
import '../models/post.dart';
import '../models/user.dart';

class PostRepository {
  final List<Post> _mockPosts = [
    Post(
      id: '1',
      user: User(
        id: 'u1',
        username: 'flutter_dev',
        profileImageUrl: 'https://picsum.photos/id/1012/200/200',
      ),
      imageUrls: [
        'https://picsum.photos/id/1015/600/600',
        'https://picsum.photos/id/1016/600/600',
      ],
      caption: 'Loving the Flutter UI challenge! #flutter #dart #uiux',
      likes: 1250,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Post(
      id: '2',
      user: User(
        id: 'u2',
        username: 'design_master',
        profileImageUrl: 'https://picsum.photos/id/1027/200/200',
      ),
      imageUrls: [
        'https://picsum.photos/id/1035/600/600',
      ],
      caption: 'Minimalist architecture is the way to go.',
      likes: 843,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Post(
      id: '3',
      user: User(
        id: 'u3',
        username: 'travel_bug',
        profileImageUrl: 'https://picsum.photos/id/1062/200/200',
      ),
      imageUrls: [
        'https://picsum.photos/id/1039/600/600',
        'https://picsum.photos/id/1043/600/600',
        'https://picsum.photos/id/1050/600/600',
      ],
      caption: 'Exploring the hidden gems of the world. 🌍',
      likes: 2100,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  Future<List<Post>> getPosts({int page = 0, int limit = 10}) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // In a real app, we'd fetch from an API based on page/limit
    // For mock, just return the list repeatedly or a subset
    return _mockPosts;
  }

  Stream<List<Post>> getPostsStream() async* {
    await Future.delayed(const Duration(milliseconds: 1500));
    yield _mockPosts;
  }
}
