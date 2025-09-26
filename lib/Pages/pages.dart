import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isLargeScreen = constraints.maxWidth > 1200;
            final bool isMediumScreen = constraints.maxWidth > 600 && constraints.maxWidth <= 1200;
            final bool isSmallScreen = constraints.maxWidth <= 600;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue.shade400,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildStatsGrid(isSmallScreen, isMediumScreen, isLargeScreen),
                    SizedBox(height: isSmallScreen ? 24 : 32),
                    _buildContentGrid(isSmallScreen, isMediumScreen, isLargeScreen),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatsGrid(bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    int crossAxisCount;
    if (isLargeScreen) {
      crossAxisCount = 4;
    } else if (isMediumScreen) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: isSmallScreen ? 12 : 16,
      mainAxisSpacing: isSmallScreen ? 12 : 16,
      childAspectRatio: isSmallScreen ? 2.5 : 2.0,
      children: [
        _buildStatCard('Total Users', '1,234', Icons.people, Colors.blue, isSmallScreen),
        _buildStatCard('Revenue', '\$12,456', Icons.attach_money, Colors.green, isSmallScreen),
        _buildStatCard('Orders', '567', Icons.shopping_cart, Colors.orange, isSmallScreen),
        _buildStatCard('Growth', '+12.5%', Icons.trending_up, Colors.purple, isSmallScreen),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: isSmallScreen ? 20 : 24),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 4 : 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentGrid(bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 300,
            maxHeight: isSmallScreen ? maxHeight * 0.8 : maxHeight,
          ),
          child: GridView.count(
            crossAxisCount: isLargeScreen ? 2 : 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: isSmallScreen ? 12 : 16,
            mainAxisSpacing: isSmallScreen ? 12 : 16,
            childAspectRatio: _calculateChildAspectRatio(isSmallScreen, isMediumScreen, isLargeScreen),
            children: [
              _buildRecentActivityCard(isSmallScreen),
              _buildQuickActionsCard(isSmallScreen),
            ],
          ),
        );
      },
    );
  }

  double _calculateChildAspectRatio(bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    if (isLargeScreen) {
      return 1.2;
    } else if (isMediumScreen) {
      return 1.5;
    } else {
      return 1.3;
    }
  }

  Widget _buildRecentActivityCard(bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 4 : 8,
                    vertical: isSmallScreen ? 2 : 4,
                  ),
                  leading: CircleAvatar(
                    radius: isSmallScreen ? 16 : 20,
                    backgroundColor: Colors.lightBlue.shade100,
                    child: Icon(Icons.person, size: isSmallScreen ? 14 : 20),
                  ),
                  title: Text(
                    'User ${index + 1} activity',
                    style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                  ),
                  subtitle: Text(
                    '2 hours ago',
                    style: TextStyle(fontSize: isSmallScreen ? 10 : 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard(bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3,
                children: [
                  _buildActionButton('Add User', Icons.person_add, isSmallScreen),
                  _buildActionButton('Upload', Icons.cloud_upload, isSmallScreen),
                  _buildActionButton('Export', Icons.file_download, isSmallScreen),
                  _buildActionButton('Settings', Icons.settings, isSmallScreen),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, bool isSmallScreen) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: isSmallScreen ? 14 : 16),
      label: Text(
        text,
        style: TextStyle(fontSize: isSmallScreen ? 10 : 12),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue.shade50,
        foregroundColor: Colors.lightBlue.shade400,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 12,
          vertical: isSmallScreen ? 8 : 12,
        ),
      ),
    );
  }
}

// class AnalyticsPage extends StatelessWidget {
//   const AnalyticsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Analytics Page',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Settings Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
