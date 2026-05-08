import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/community_view_model.dart';
import '../../widgets/eco_scaffold.dart';
import '../../widgets/section_header.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final community = context.watch<CommunityViewModel>();
    return EcoScaffold(
      title: 'Community',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _showPostSheet(context),
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('Share activity'),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filledTonal(
                tooltip: 'Trending posts',
                onPressed: () {},
                icon: const Icon(Icons.local_fire_department_outlined),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'Trending eco posts'),
          ...community.posts.map((post) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: Text(post.authorName.isEmpty ? 'C' : post.authorName.substring(0, 1))),
                      title: Text(post.authorName),
                      subtitle: Text(DateFormat('d MMM, h:mm a').format(post.createdAt)),
                      trailing: const Icon(Icons.more_horiz),
                    ),
                    CachedNetworkImage(
                      imageUrl: post.imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.text),
                          const SizedBox(height: 10),
                          Wrap(spacing: 8, children: post.tags.map((tag) => Chip(label: Text(tag))).toList()),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                              Text('${post.likes}'),
                              const SizedBox(width: 12),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline)),
                              Text('${post.comments}'),
                              const Spacer(),
                              TextButton.icon(onPressed: () {}, icon: const Icon(Icons.flag_outlined), label: const Text('Join challenge')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          const SectionHeader(title: 'Community leaderboard'),
          Card(
            child: Column(
              children: const [
                ListTile(leading: CircleAvatar(child: Text('1')), title: Text('Meera Nair'), trailing: Text('5,420 pts')),
                ListTile(leading: CircleAvatar(child: Text('2')), title: Text('Rohan Das'), trailing: Text('4,960 pts')),
                ListTile(leading: CircleAvatar(child: Text('3')), title: Text('Aarav Sharma'), trailing: Text('2,840 pts')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPostSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(maxLines: 3, decoration: const InputDecoration(labelText: 'What eco activity did you complete?')),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.image_outlined), label: const Text('Image'))),
                const SizedBox(width: 12),
                Expanded(child: FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Post'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
