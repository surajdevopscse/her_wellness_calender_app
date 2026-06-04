class OnboardingStatusModel {
  const OnboardingStatusModel({
    required this.isCompleted,
    this.goal,
    this.completedAtUtc,
  });

  final bool isCompleted;
  final String? goal;
  final DateTime? completedAtUtc;

  factory OnboardingStatusModel.fromJson(Map<String, dynamic> json) {
    final completedAt = json['completedAtUtc'] as String?;
    return OnboardingStatusModel(
      isCompleted: json['isCompleted'] as bool? ?? false,
      goal: json['goal'] as String?,
      completedAtUtc: completedAt == null ? null : DateTime.parse(completedAt),
    );
  }
}
