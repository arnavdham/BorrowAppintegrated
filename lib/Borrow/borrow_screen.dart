import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:postmandummyrepo/Borrow/borrow_view_model.dart';
import 'package:postmandummyrepo/HamMenu/hamburger_menu.dart';
import 'package:postmandummyrepo/HamMenu/hamburger_menu_viewmodel.dart';
import '../Lend/lend_request_card.dart';
import 'borrow_request_card.dart';
class BorrowScreen extends StatefulWidget {
  const BorrowScreen({Key? key}) : super(key: key);

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final SideBarViewModel viewModel = SideBarViewModel();
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          drawer: SideBar(viewModel: viewModel),
          appBar: AppBar(
            title: Text(
              "Borrow Requests",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, color: Colors.white),
            ),
            backgroundColor: const Color(0xFF144272),
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => ChatsList()),
                    );
                  },
                  icon: SvgPicture.asset('assets/chats.svg')),
            ],
          ),
          body: Container(
            color: const Color(0xFF0A2647),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchBorrowObjectList(),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No Lend Requests available.');
                }

                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = snapshot.data[index];
                    return BorrowRequestCard(
                      imagePath: item['Image_Path'],
                      title: item['Title'],
                      description: item['Description'],
                      isAvailable: item['Is_Available'],
                    );
                  },
                );
              },
            )
          ),
          bottomNavigationBar: BottomNavBar(
              currentIndex: 2,
              onTap: (index) {
                if (index == 1) {
                  // Navigate to PostScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => PostScreen()),
                  );
                } else if (index == 0) {
                  // Navigate to BorrowScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LendScreen()),
                  );
                }
              }),
        );
      }),
    );
  }
}
