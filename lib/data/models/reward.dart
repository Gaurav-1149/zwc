class RewardBadge {
  const RewardBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.unlocked,
    required this.requiredPoints,
  });

  final String id;
  final String title;
  final String description;
  final String icon;
  final bool unlocked;
  final int requiredPoints;
}

class EcoChallenge {
  const EcoChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.progress,
  });

  final String id;
  final String title;
  final String description;
  final int points;
  final double progress;
}
