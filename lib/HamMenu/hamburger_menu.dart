import 'package:flutter/material.dart';
import 'hamburger_menu_viewmodel.dart';

class SideBar extends StatelessWidget {
  final SideBarViewModel viewModel;

  const SideBar({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF144272),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Hi Username!'),
            accountEmail: Text(viewModel.userEmail),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: FutureBuilder<String?>(
                  future: viewModel.getUserPhoto(),
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.done) {
                      final String? photoUrl = snapshot.data;
                      print(photoUrl);
                      return Image.network(
                        photoUrl ??'',
                        fit: BoxFit.cover,
                      );
                    }
                    else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF144272),
            ),
          ),
          menuitems(
            text: 'My Posts',
            pic: Image.asset('assets/Vector.jpg'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.bookmark, color: Colors.white),
            title: Text('Bookmarked Posts', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          menuitems(
            text: 'Feedback',
            pic: Image.asset('assets/feedback.jpg'),
            onTap: () {},
          ),
          menuitems(
            text: 'Donate',
            pic: Image.asset('assets/donate.jpg'),
            onTap: () {},
          ),
          menuitems(
            text: 'Developers',
            pic: Image.asset('assets/developers.jpg'),
            onTap: () {},
          ),
          menuitems(
            text: 'Sign Out',
            pic: Image.asset('assets/signout.jpg'),
            onTap: () {
              viewModel.signOut(context);
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}

class menuitems extends StatelessWidget {
  final String text;
  final Image pic;
  final VoidCallback onTap;

  const menuitems({required this.text, required this.pic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: pic,
      title: Text(text, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}

