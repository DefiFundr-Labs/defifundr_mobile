import 'dart:ui';

class WorkspaceCardModel {
  final String title;
  final String description;
  final String iconPath;
  final VoidCallback onTap;

  const WorkspaceCardModel({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.onTap,
  });
}
