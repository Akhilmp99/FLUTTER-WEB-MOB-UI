import 'package:flutter/material.dart';
import 'package:webtemplate/Pages/Analytics.dart';
import 'package:webtemplate/Pages/pages.dart';
import 'package:webtemplate/Pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Sample pages for navigation
  final List<Widget> _pages = [
    const DashboardPage(),
    const AnalyticsPage(),
    const SettingsPage(),
    const  ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: MediaQuery.of(context).size.width < 600 ? _buildDrawer() : null,
      body: Row(
        children: [
          // Sidebar for larger screens
          if (MediaQuery.of(context).size.width >= 600) _buildDesktopSidebar(),
          // Main content
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.dashboard,
            color: Colors.white,
          ),
          SizedBox(width: 12),
          Text(
            'Responsive Web App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        _buildProfileButton(),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildProfileButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person,
          color: Colors.lightBlue.shade400,
        ),
      ),
    );
  }

  Widget _buildDesktopSidebar() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSidebarHeader(),
          Expanded(
            child: _buildSidebarMenu(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          _buildSidebarHeader(),
          Expanded(
            child: _buildSidebarMenu(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue.shade400,
            Colors.lightBlue.shade200,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.lightBlue.shade400,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'John Doe',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'admin@example.com',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarMenu() {
    final menuItems = [
      {'icon': Icons.dashboard, 'title': 'Dashboard', 'index': 0},
      {'icon': Icons.analytics, 'title': 'Analytics', 'index': 1},
      {'icon': Icons.settings, 'title': 'Settings', 'index': 2},
      {'icon': Icons.person, 'title': 'Profile', 'index': 3},
    ];

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20),
      children: menuItems.map((item) {
        return _buildMenuItem(
          icon: item['icon'] as IconData,
          title: item['title'] as String,
          index: item['index'] as int,
        );
      }).toList(),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.lightBlue.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(
          color: Colors.lightBlue.shade200,
          width: 1,
        ) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.lightBlue.shade400 : Colors.grey.shade600,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.lightBlue.shade400 : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
          // Close drawer if on mobile
          if (MediaQuery.of(context).size.width < 600) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}