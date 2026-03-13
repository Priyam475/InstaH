import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/post.dart';
import '../providers/post_provider.dart';
import 'pinch_to_zoom.dart';
import 'custom_snackbar.dart';

class PostCard extends ConsumerStatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(widget.post.user.profileImageUrl),
          ),
          title: Text(
            widget.post.user.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
        // Image Carousel with Pinch to Zoom
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              PageView.builder(
                itemCount: widget.post.imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return PinchToZoom(
                    child: CachedNetworkImage(
                      imageUrl: widget.post.imageUrls[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
                },
              ),
              if (widget.post.imageUrls.length > 1)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_currentImageIndex + 1}/${widget.post.imageUrls.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  widget.post.isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                  color: widget.post.isLiked ? Colors.red : Colors.black,
                ),
                onPressed: () => ref.read(postsProvider.notifier).toggleLike(widget.post.id),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.comment),
                onPressed: () => showCustomSnackBar(context, 'Comments not implemented yet'),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.paperPlane),
                onPressed: () => showCustomSnackBar(context, 'Share not implemented yet'),
              ),
              const Spacer(),
              if (widget.post.imageUrls.length > 1)
                Row(
                  children: List.generate(
                    widget.post.imageUrls.length,
                    (index) => Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentImageIndex == index ? Colors.blue : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  widget.post.isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                ),
                onPressed: () => ref.read(postsProvider.notifier).toggleSave(widget.post.id),
              ),
            ],
          ),
        ),
        // Likes & Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.post.likes} likes',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: '${widget.post.user.username} ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: widget.post.caption),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'View all 10 comments',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                '${widget.post.createdAt.hour} hours ago',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
