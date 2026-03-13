import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import '../services/post_repository.dart';

final postRepositoryProvider = Provider((ref) => PostRepository());

final postsProvider = StateNotifierProvider<PostNotifier, AsyncValue<List<Post>>>((ref) {
  return PostNotifier(ref.watch(postRepositoryProvider));
});

class PostNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  final PostRepository _repository;
  int _currentPage = 0;
  bool _isFetchingMore = false;

  PostNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final posts = await _repository.getPosts(page: _currentPage);
      state = AsyncValue.data(posts);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> fetchMore() async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;
    _currentPage++;
    
    try {
      final newPosts = await _repository.getPosts(page: _currentPage);
      final currentPosts = state.asData?.value ?? [];
      state = AsyncValue.data([...currentPosts, ...newPosts]);
    } catch (e) {
      // Handle error
    } finally {
      _isFetchingMore = false;
    }
  }

  void toggleLike(String postId) {
    if (state.hasValue) {
      final posts = state.asData!.value;
      state = AsyncValue.data([
        for (final post in posts)
          if (post.id == postId)
            post.copyWith(isLiked: !post.isLiked)
          else
            post,
      ]);
    }
  }

  void toggleSave(String postId) {
    if (state.hasValue) {
      final posts = state.asData!.value;
      state = AsyncValue.data([
        for (final post in posts)
          if (post.id == postId)
            post.copyWith(isSaved: !post.isSaved)
          else
            post,
      ]);
    }
  }
}
