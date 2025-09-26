import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int _selectedTimeFilter = 0; // 0: Weekly, 1: Monthly, 2: Yearly
  int _selectedMetric = 0; // 0: Revenue, 1: Users, 2: Orders

  final List<String> _timeFilters = ['Weekly', 'Monthly', 'Yearly'];
  final List<String> _metrics = ['Revenue', 'Users', 'Orders'];

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
                    _buildFiltersSection(isSmallScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildStatsGrid(isSmallScreen, isMediumScreen, isLargeScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildChartsSection(isSmallScreen, isMediumScreen, isLargeScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildDataTablesSection(isSmallScreen, isMediumScreen, isLargeScreen),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.analytics_outlined,
              color: Colors.lightBlue.shade400,
              size: isSmallScreen ? 24 : 32,
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Text(
              'Analytics Dashboard',
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue.shade400,
              ),
            ),
          ],
        ),
        if (!isSmallScreen) _buildExportButton(isSmallScreen),
      ],
    );
  }

  Widget _buildExportButton(bool isSmallScreen) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.download, size: isSmallScreen ? 14 : 16),
      label: Text(isSmallScreen ? 'Export' : 'Export Report'),
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

  Widget _buildFiltersSection(bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            isSmallScreen ? _buildFiltersMobile() : _buildFiltersDesktop(isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersMobile() {
    return Column(
      children: [
        _buildFilterChips('Time Range', _timeFilters, _selectedTimeFilter, (index) {
          setState(() => _selectedTimeFilter = index);
        }, true),
        SizedBox(height: 12),
        _buildFilterChips('Metrics', _metrics, _selectedMetric, (index) {
          setState(() => _selectedMetric = index);
        }, true),
        SizedBox(height: 12),
        _buildExportButton(true),
      ],
    );
  }

  Widget _buildFiltersDesktop(bool isSmallScreen) {
    return Row(
      children: [
        Expanded(
          child: _buildFilterChips('Time Range', _timeFilters, _selectedTimeFilter, (index) {
            setState(() => _selectedTimeFilter = index);
          }, isSmallScreen),
        ),
        SizedBox(width: 20),
        Expanded(
          child: _buildFilterChips('Metrics', _metrics, _selectedMetric, (index) {
            setState(() => _selectedMetric = index);
          }, isSmallScreen),
        ),
        SizedBox(width: 20),
        _buildExportButton(isSmallScreen),
      ],
    );
  }

  Widget _buildFilterChips(String title, List<String> options, int selected, Function(int) onSelected, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(options.length, (index) {
            return FilterChip(
              label: Text(options[index]),
              selected: selected == index,
              onSelected: (bool value) => onSelected(index),
              selectedColor: Colors.lightBlue.shade100,
              checkmarkColor: Colors.lightBlue.shade400,
              labelStyle: TextStyle(
                color: selected == index ? Colors.lightBlue.shade400 : Colors.grey.shade700,
                fontSize: isSmallScreen ? 10 : 12,
              ),
            );
          }),
        ),
      ],
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

    double childAspectRatio = isSmallScreen ? 1.3 : 1.8;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: isSmallScreen ? 8 : 16,
      mainAxisSpacing: isSmallScreen ? 8 : 16,
      childAspectRatio: childAspectRatio,
      children: [
        _buildAnalyticsStatCard('Total Revenue', '\$12,456', '+12.5%', Icons.attach_money, Colors.green, true),
        _buildAnalyticsStatCard('Active Users', '1,234', '+8.2%', Icons.people, Colors.blue, true),
        _buildAnalyticsStatCard('Total Orders', '567', '+15.3%', Icons.shopping_cart, Colors.orange, true),
        _buildAnalyticsStatCard('Conversion Rate', '4.2%', '+2.1%', Icons.trending_up, Colors.purple, false),
      ],
    );
  }

  Widget _buildAnalyticsStatCard(String title, String value, String change, IconData icon, Color color, bool isPositive) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.green.shade50 : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 12,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 4),
                      Text(
                        change,
                        style: TextStyle(
                          fontSize: 10,
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartsSection(bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    if (isLargeScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildLineChartCard(isSmallScreen),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: _buildPieChartCard(isSmallScreen),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildLineChartCard(isSmallScreen),
          SizedBox(height: isSmallScreen ? 12 : 16),
          _buildPieChartCard(isSmallScreen),
        ],
      );
    }
  }

  Widget _buildLineChartCard(bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Revenue Trend',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.grey.shade600, size: 20),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: isSmallScreen ? 200 : 300,
              child: _buildLineChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartCard(bool isSmallScreen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Traffic Sources',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: isSmallScreen ? 200 : 300,
              child: _buildPieChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    // Mock data for line chart
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.show_chart, size: 40, color: Colors.lightBlue.shade400),
            SizedBox(height: 8),
            Text(
              'Interactive Chart',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            Text(
              'Would display revenue trends here',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    // Mock data for pie chart
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pie_chart, size: 40, color: Colors.lightBlue.shade400),
            SizedBox(height: 8),
            Text(
              'Pie Chart',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            Text(
              'Would display traffic sources here',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTablesSection(bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
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
            SizedBox(height: 16),
            isSmallScreen ? _buildMobileDataTable() : _buildDesktopDataTable(isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileDataTable() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User ${index + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(index).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatus(index),
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(index),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text('Purchase: \$${(index + 1) * 250}', style: TextStyle(fontSize: 12)),
              Text('Date: ${_getDate(index)}', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopDataTable(bool isSmallScreen) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) => Colors.lightBlue.shade50,
        ),
        columns: [
          DataColumn(label: Text('User', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Activity', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: List.generate(5, (index) => DataRow(
          cells: [
            DataCell(Text('User ${index + 1}')),
            DataCell(Text('Purchase')),
            DataCell(Text('\$${(index + 1) * 250}')),
            DataCell(Text(_getDate(index))),
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(index).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _getStatus(index),
                  style: TextStyle(
                    color: _getStatusColor(index),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  String _getStatus(int index) {
    List<String> statuses = ['Completed', 'Pending', 'Processing', 'Completed', 'Failed'];
    return statuses[index % statuses.length];
  }

  Color _getStatusColor(int index) {
    List<Color> colors = [Colors.green, Colors.orange, Colors.blue, Colors.green, Colors.red];
    return colors[index % colors.length];
  }

  String _getDate(int index) {
    List<String> dates = ['2024-01-15', '2024-01-14', '2024-01-13', '2024-01-12', '2024-01-11'];
    return dates[index % dates.length];
  }
}