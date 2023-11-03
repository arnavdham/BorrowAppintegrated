import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postmandummyrepo/HamMenu/hamburger_menu.dart';
import 'package:postmandummyrepo/HamMenu/hamburger_menu_viewmodel.dart';
import 'package:postmandummyrepo/Lend/lend_request_card.dart';
import 'package:postmandummyrepo/Lend/lend_view_model.dart';
import 'package:provider/provider.dart';

import '../Borrow/borrow_request_card.dart';
import '../Borrow/borrow_screen.dart';
import '../Post/post_screen.dart';

class LendScreen extends StatefulWidget {
  const LendScreen({Key? key}) : super(key: key);

  @override
  State<LendScreen> createState() => _LendScreenState();
}

class _LendScreenState extends State<LendScreen> {
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
            backgroundColor: const Color(0xFF144272),
            title:  Text("Lend Requests",style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: Colors.white),),
            leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white,),
                    onPressed: () {Scaffold.of(context).openDrawer();  },
                  );
                }
            ),
            actions: <Widget>[
              IconButton(onPressed: (){Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => ChatsList()),
              );}, icon: SvgPicture.asset('assets/chats.svg')),
            ],
          ),
          body: Container(
            color: const Color(0xFF0A2647),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchLendObjectList(),
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
                    return LendRequestCard(
                      imagePath: item['Image'],
                      days: item['Days'],
                      price: item['Price'],
                      creatorName: item['CreatorName'],
                      title: item['Title'],
                      description: item['Description'],
                      createdAt: item['CreatedAt'],
                    );
                  },
                );
              },
            )
          ),
          bottomNavigationBar: BottomNavBar(currentIndex: 0, onTap: (index) {
            if (index == 1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => PostScreen()),
              );
            } else if (index == 2) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => BorrowScreen()),
              );
            }
          }),
        );
      }),
    );
  }
}
