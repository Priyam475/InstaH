import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'providers/post_provider.dart';
import 'widgets/post_card.dart';
import 'widgets/shimmer_post.dart';
import 'widgets/stories_tray.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const InstagramHome(),
    );
  }
}

class InstagramHome extends ConsumerStatefulWidget {
  const InstagramHome({super.key});

  @override
  ConsumerState<InstagramHome> createState() => _InstagramHomeState();
}

class _InstagramHomeState extends ConsumerState<InstagramHome> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      ref.read(postsProvider.notifier).fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instagram',
          style: GoogleFonts.grandHotel(
            fontSize: 32,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.heart),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.commentDots),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postsProvider.notifier).fetchPosts(),
        child: postsAsync.when(
          data: (posts) => ListView.builder(
            controller: _scrollController,
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const StoriesTray();
              }
              final post = posts[index - 1];
              return PostCard(post: post);
            },
          ),
          loading: () => ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              if (index == 0) return const StoriesTray();
              return const ShimmerPost();
            },
          ),
          error: (err, stack) => Center(
            child: Text('Error: $err'),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library_outlined), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
