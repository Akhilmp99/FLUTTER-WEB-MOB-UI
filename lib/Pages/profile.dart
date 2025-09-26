import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                padding: EdgeInsets.all(isSmallScreen ? 12.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isSmallScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildProfileSection(isSmallScreen, isMediumScreen, isLargeScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildStatsGrid(isSmallScreen, isMediumScreen, isLargeScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildContentSection(isSmallScreen, isMediumScreen, isLargeScreen),
                    if (isSmallScreen) SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmallScreen) {
    return Row(
      children: [
        Icon(
          Icons.person_outline,
          color: Colors.lightBlue.shade400,
          size: isSmallScreen ? 24 : 32,
        ),
        SizedBox(width: isSmallScreen ? 8 : 12),
        Text(
          'My Profile',
          style: TextStyle(
            fontSize: isSmallScreen ? 20 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue.shade400,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 20.0),
        child: isSmallScreen ? _buildProfileSectionMobile() : _buildProfileSectionDesktop(isSmallScreen),
      ),
    );
  }

  Widget _buildProfileSectionMobile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.lightBlue.shade100,
          child: Icon(
            Icons.person,
            size: 40,
            color: Colors.lightBlue.shade400,
          ),
        ),
        SizedBox(height: 16),
        Column(
          children: [
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: [
            _buildProfileChip('Admin', Icons.security, Colors.green, true),
            _buildProfileChip('Verified', Icons.verified, Colors.blue, true),
            _buildProfileChip('Pro Member', Icons.star, Colors.orange, true),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: _buildEditButton(true),
        ),
      ],
    );
  }

  Widget _buildProfileSectionDesktop(bool isSmallScreen) {
    return Row(
      children: [
        CircleAvatar(
          radius: isSmallScreen ? 40 : 60,
          backgroundColor: Colors.lightBlue.shade100,
          child: Icon(
            Icons.person,
            size: isSmallScreen ? 40 : 50,
            color: Colors.lightBlue.shade400,
          ),
        ),
        SizedBox(width: isSmallScreen ? 16 : 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'john.doe@example.com',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildProfileChip('Admin', Icons.security, Colors.green, isSmallScreen),
                  _buildProfileChip('Verified', Icons.verified, Colors.blue, isSmallScreen),
                  _buildProfileChip('Pro Member', Icons.star, Colors.orange, isSmallScreen),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 24),
        _buildEditButton(isSmallScreen),
      ],
    );
  }

  Widget _buildProfileChip(String label, IconData icon, Color color, bool isSmallScreen) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: isSmallScreen ? 10 : 12,
          color: color,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
      avatar: Icon(icon, size: isSmallScreen ? 14 : 16, color: color),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildEditButton(bool isSmallScreen) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.edit, size: isSmallScreen ? 14 : 16),
      label: Text(isSmallScreen ? 'Edit' : 'Edit Profile'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue.shade50,
        foregroundColor: Colors.lightBlue.shade400,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: isSmallScreen ? 8 : 12,
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
      crossAxisCount = 2;
    }

    double childAspectRatio;
    if (isLargeScreen) {
      childAspectRatio = 1.8;
    } else if (isMediumScreen) {
      childAspectRatio = 1.6;
    } else {
      childAspectRatio = 1.4;
    }

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: isSmallScreen ? 8 : 16,
      mainAxisSpacing: isSmallScreen ? 8 : 16,
      childAspectRatio: childAspectRatio,
      children: [
        _buildProfileStatCard('Projects', '24', Icons.work, Colors.blue, isSmallScreen),
        _buildProfileStatCard('Tasks', '18', Icons.task, Colors.green, isSmallScreen),
        _buildProfileStatCard('Completed', '89%', Icons.check_circle, Colors.purple, isSmallScreen),
        _buildProfileStatCard('Member Since', '2022', Icons.calendar_today, Colors.orange, isSmallScreen),
      ],
    );
  }

  Widget _buildProfileStatCard(String title, String value, IconData icon, Color color, bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: isSmallScreen ? 20 : 24),
            ),
            SizedBox(height: isSmallScreen ? 8 : 12),
            Text(
              value,
              style: TextStyle(
                fontSize: isSmallScreen ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: isSmallScreen ? 4 : 6),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: isSmallScreen ? 11 : 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    if (isLargeScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildPersonalInfoCard(isSmallScreen),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: _buildAccountSettingsCard(isSmallScreen),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildPersonalInfoCard(isSmallScreen),
          SizedBox(height: isSmallScreen ? 12 : 16),
          _buildAccountSettingsCard(isSmallScreen),
        ],
      );
    }
  }

  Widget _buildPersonalInfoCard(bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.lightBlue.shade400, size: isSmallScreen ? 18 : 20),
                SizedBox(width: 8),
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildInfoItem('Phone', '+1 (555) 123-4567', Icons.phone, isSmallScreen),
            _buildInfoItem('Location', 'New York, USA', Icons.location_on, isSmallScreen),
            _buildInfoItem('Department', 'Engineering', Icons.business, isSmallScreen),
            _buildInfoItem('Join Date', 'March 15, 2022', Icons.date_range, isSmallScreen),
            _buildInfoItem('Role', 'Senior Developer', Icons.work, isSmallScreen),
            if (isSmallScreen) ...[
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: _buildEditButton(isSmallScreen),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 6.0 : 8.0),
      child: Row(
        children: [
          Icon(icon, size: isSmallScreen ? 14 : 16, color: Colors.grey.shade600),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Expanded(
            flex: isSmallScreen ? 2 : 3,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ),
          Expanded(
            flex: isSmallScreen ? 3 : 4,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettingsCard(bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings_outlined, color: Colors.lightBlue.shade400, size: isSmallScreen ? 18 : 20),
                SizedBox(width: 8),
                Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildSettingOption('Privacy Settings', Icons.privacy_tip, isSmallScreen),
            _buildSettingOption('Security', Icons.security, isSmallScreen),
            _buildSettingOption('Notifications', Icons.notifications, isSmallScreen),
            _buildSettingOption('Theme', Icons.color_lens, isSmallScreen),
            _buildSettingOption('Language', Icons.language, isSmallScreen),
            _buildSettingOption('Help & Support', Icons.help_outline, isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(String title, IconData icon, bool isSmallScreen) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      leading: Container(
        padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: isSmallScreen ? 16 : 18, color: Colors.lightBlue.shade400),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: isSmallScreen ? 14 : 16, color: Colors.grey.shade400),
      onTap: () {},
    );
  }
}