class BorrowRequest {
  final String id;
  //final String userId;
  //final String username;
  //final String profilePicUrl;
  final String title;
  final String description;
  final String imagePath;
  final bool isAvailable;
  //final String saleOrRent;
  //bool isSaved;
  BorrowRequest({
    required this.id,
    required this.isAvailable,
    //required this.userId,
    //required this.username,
    //required this.profilePicUrl,
    required this.title,
    required this.description,
    required this.imagePath,
   // required this.saleOrRent,
    //this.isSaved = false,
  });
}
