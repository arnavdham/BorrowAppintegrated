import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class BorrowRequestCard extends StatefulWidget {
  final String imagePath;
  //final String username;
  final String title;
  final String description;
  final bool isAvailable;

  BorrowRequestCard({
    Key? key,
    required this.imagePath,
    //required this.username,
    required this.title,
    required this.description,
    required this.isAvailable,
  }) : super(key: key);

  @override
  _BorrowRequestCardState createState() => _BorrowRequestCardState();
}

class _BorrowRequestCardState extends State<BorrowRequestCard> {
  bool isSaved = false;
  bool showFullText = false;
  final user = FirebaseAuth.instance.currentUser!;

  // void _handleSendButtonPress() async {
  //   String currentUserId = user.uid;
  //   String receiverUserId = widget.userId;
  //
  //   bool roomExists = await checkIfRoomExists(currentUserId, receiverUserId);
  //
  //   if (!roomExists && (currentUserId != receiverUserId)) {
  //     await createRoom(currentUserId, receiverUserId);
  //   }
  //
  //   if (currentUserId != receiverUserId) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ChatPage(
  //           senderUserId: currentUserId,
  //           receiverUserId: receiverUserId,
  //         ),
  //       ),
  //     );
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF144272),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(''),
                ),
              ),
              const SizedBox(width: 8.0),
              // Text(
              //   widget.username,
              //   style: GoogleFonts.poppins(color: Colors.white),
              // ),
            ],
          ),
          Stack(
            children: [
              Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                right: 16.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text('<Required',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF5AF5FF),
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.description,
                        maxLines: showFullText ? null : 2,
                        overflow: showFullText ? null : TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showFullText = !showFullText;
                          });
                        },
                        child: Text(showFullText ? 'Read Less' : 'Read More',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  // setState(() {
                  //   isSaved = !isSaved;
                  // });
                },
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {
                  //_handleSendButtonPress();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
