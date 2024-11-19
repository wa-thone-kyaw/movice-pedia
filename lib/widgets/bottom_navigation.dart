import 'package:flutter/material.dart';
import '../screens/profile_screen.dart'; // Import the ProfileScreen
import '../screens/downloads_screen.dart'; // Import the DownloadsScreen

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 4) {
            // Navigate to ProfileScreen when "Me" is tapped (index 4)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          } else if (index == 3) {
            // Navigate to DownloadsScreen when "Download" is tapped (index 3)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DownloadsScreen()),
            );
          } else {
            // Use the passed callback to handle other navigation logic
            onTabSelected(index);
          }
        },
        backgroundColor: Colors.transparent, // Make background transparent
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.white70, // Unselected item color
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold), // Bold selected label
        unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal), // Normal unselected label
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0, // Remove shadow
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Save',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Download',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
