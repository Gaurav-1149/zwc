class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorImage,
    required this.text,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.tags,
  });

  final String id;
  final String authorName;
  final String authorImage;
  final String text;
  final String imageUrl;
  final int likes;
  final int comments;
  final DateTime createdAt;
  final List<String> tags;
}
