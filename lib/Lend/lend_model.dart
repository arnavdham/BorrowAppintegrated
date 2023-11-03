class LendRequest {
  final String id;
  final double days;
  final String creatorName;
  final double price;
  final String imagePath;
  final String title;
  final String description;
  final String createdAt;

  LendRequest({
    required this.imagePath,
    required this.id,
    required this.days,
    required this.creatorName,
    required this.price,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}