import 'package:flutter/material.dart';
import 'post.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocus = FocusNode();

  final List<String> comments = [];

  bool isLiked = false;

  void likePost() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void addComment() {
    final String comment = commentController.text.trim();

    if (comment.isEmpty) {
      return;
    }

    setState(() {
      comments.add(comment);
    });

    commentController.clear();
  }

  @override
  void dispose() {
    commentController.dispose();
    commentFocus.dispose();
    super.dispose();
  }

  Widget buildAvatar(String username) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFFFEDA77),
            Color(0xFFF58529),
            Color(0xFFDD2A7B),
            Color(0xFF8134AF),
            Color(0xFF515BD4),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
        ),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.green,
          child: Text(
            username.isEmpty ? '?' : username[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.post.username.trim();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 470),
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 20),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: avatar + username
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
                child: Row(
                  children: [
                    buildAvatar(username),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ],
                ),
              ),

              // Square photo
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  widget.post.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 70,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Action row: like, comment, share
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: likePost,
                      tooltip: isLiked ? 'Unlike' : 'Like',
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : null,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      onPressed: () => commentFocus.requestFocus(),
                      tooltip: 'Comment',
                      icon: const Icon(Icons.mode_comment_outlined, size: 26),
                    ),
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Share',
                      icon: const Icon(Icons.send_outlined, size: 26),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        isLiked ? 'Liked' : 'Like',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isLiked ? Colors.red : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Caption: bold username + text
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontSize: 15),
                    children: [
                      TextSpan(
                        text: '$username ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: widget.post.caption),
                    ],
                  ),
                ),
              ),

              // Comment count
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
                child: Text(
                  '${comments.length} Comments',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),

              // Comments list
              for (final String comment in comments)
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 2, 14, 2),
                  child: Text(comment),
                ),

              const Divider(height: 16),

              // Add a comment
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 4, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        focusNode: commentFocus,
                        onSubmitted: (_) => addComment(),
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: addComment,
                      icon: const Icon(Icons.send),
                      color: Colors.green,
                      tooltip: 'Send comment',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}