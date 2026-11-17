import 'package:flutter/material.dart';
import 'create_post_sheet.dart';
import 'post.dart';
import 'post_card.dart';

class SocialMediaPage extends StatefulWidget {
  final String username;

  const SocialMediaPage({
    super.key,
    required this.username,
  });

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  final List<Post> posts = [
    const Post(
      username: 'maria.santos',
      caption: 'Beach day with good vibes only 🌊☀️',
      imageUrl: 'https://picsum.photos/id/14/600/600',
    ),
    const Post(
      username: 'carlo.reyes',
      caption: 'Chasing sunsets in the mountains 🏔️',
      imageUrl: 'https://picsum.photos/id/29/600/600',
    ),
  ];

  Future<void> openCreatePostSheet() async {
    final Post? newPost = await showModalBottomSheet<Post>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return CreatePostSheet(
          username: widget.username,
        );
      },
    );

    if (!mounted || newPost == null) {
      return;
    }

    setState(() {
      posts.insert(0, newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media'),
      ),
      body: posts.isEmpty
          ? const Center(
              child: Text('No posts yet. Create one!'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return PostCard(
                  key: ObjectKey(post),
                  post: post,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openCreatePostSheet,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        tooltip: 'Create Post',
        child: const Icon(Icons.add),
      ),
    );
  }
}