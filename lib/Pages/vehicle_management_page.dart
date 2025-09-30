// vehicle_management_page.dart
import 'package:flutter/material.dart';
import '../Models/vehicle_model.dart';

class VehicleManagementPage extends StatelessWidget {
  const VehicleManagementPage({super.key});

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
                    _buildHeader(context, isSmallScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildSearchSection(context, isSmallScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildStatsGrid(isSmallScreen, isMediumScreen, isLargeScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildVehicleListSection(context, isSmallScreen, isMediumScreen, isLargeScreen),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.orange.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.local_shipping_outlined,
            color: Colors.white,
            size: isSmallScreen ? 24 : 32,
          ),
        ),
        SizedBox(width: isSmallScreen ? 12 : 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Management',
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Manage your fleet of trucks and vehicles',
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const Spacer(),
        _buildAddButton(context, isSmallScreen),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context, bool isSmallScreen) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.orange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          _showAddVehicleDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 20,
            vertical: isSmallScreen ? 10 : 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: isSmallScreen ? 16 : 18, color: Colors.white),
            SizedBox(width: 6),
            Text(
              isSmallScreen ? 'Add' : 'Add Vehicle',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context, bool isSmallScreen) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.search, color: Colors.orange.shade400, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Find Vehicles',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildSearchAndFilter(isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter(bool isSmallScreen) {
    return Row(
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by vehicle number, driver name...',
                prefixIcon: Icon(Icons.search, color: Colors.orange.shade400),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16 : 20,
                  vertical: isSmallScreen ? 14 : 18,
                ),
                hintStyle: TextStyle(color: Colors.grey.shade500),
              ),
            ),
          ),
        ),
        SizedBox(width: isSmallScreen ? 12 : 16),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // Handle filter
              },
              child: Container(
                padding: EdgeInsets.all(isSmallScreen ? 14 : 18),
                child: Icon(Icons.filter_list_alt, color: Colors.orange.shade400),
              ),
            ),
          ),
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

    double childAspectRatio;
    if (isLargeScreen) {
      childAspectRatio = 1.8;
    } else if (isMediumScreen) {
      childAspectRatio = 1.6;
    } else {
      childAspectRatio = 1.4;
    }

    final vehicles = VehicleData.getVehicles();
    final activeVehicles = vehicles.where((v) => v.isActive).length;
    final totalCapacity = vehicles.fold(0.0, (sum, vehicle) => sum + vehicle.capacity);

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: isSmallScreen ? 8 : 16,
      mainAxisSpacing: isSmallScreen ? 8 : 16,
      childAspectRatio: childAspectRatio,
      children: [
        _buildStatCard('Total Vehicles', '${vehicles.length}', Icons.local_shipping, Colors.orange, isSmallScreen),
        _buildStatCard('Active Vehicles', '$activeVehicles', Icons.check_circle, Colors.green, isSmallScreen),
        _buildStatCard('Total Capacity', '${totalCapacity.toInt()} Tons', Icons.scale, Colors.blue, isSmallScreen),
        _buildStatCard('Avg Capacity', '${(totalCapacity / vehicles.length).toStringAsFixed(1)} Tons', Icons.analytics, Colors.purple, isSmallScreen),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, bool isSmallScreen) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
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
      ),
    );
  }

  Widget _buildVehicleListSection(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Card(
        key: ValueKey('vehicle_list'),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16.0 : 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.directions_car, color: Colors.orange.shade400, size: 20),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Vehicle Fleet',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Spacer(),
                  _buildViewToggle(isSmallScreen),
                ],
              ),
              SizedBox(height: isSmallScreen ? 16 : 20),
              _buildVehicleList(context, isSmallScreen, isMediumScreen, isLargeScreen),
            ],
          ),
        ),
      ),
    ),);
  }

  Widget _buildViewToggle(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Icon(Icons.grid_view, size: 16, color: Colors.orange.shade400),
          ),
          SizedBox(width: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.list, size: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    final vehicles = VehicleData.getVehicles();

    if (isLargeScreen) {
      return _buildDesktopVehicleTable(context, vehicles, isSmallScreen);
    } else {
      return _buildMobileVehicleList(context, vehicles, isSmallScreen);
    }
  }

  Widget _buildDesktopVehicleTable(BuildContext context, List<Vehicle> vehicles, bool isSmallScreen) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.orange.shade50),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade800,
          fontSize: isSmallScreen ? 12 : 14,
        ),
        dataRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.orange.shade50;
            }
            return Colors.transparent;
          },
        ),
        columns: [
          DataColumn(label: _buildTableHeader('Vehicle No.')),
          DataColumn(label: _buildTableHeader('Owner')),
          DataColumn(label: _buildTableHeader('Driver')),
          DataColumn(label: _buildTableHeader('Contact')),
          DataColumn(label: _buildTableHeader('Capacity')),
          DataColumn(label: _buildTableHeader('Type')),
          DataColumn(label: _buildTableHeader('Insurance Expiry')),
          DataColumn(label: _buildTableHeader('Status')),
          DataColumn(label: _buildTableHeader('Actions')),
        ],
        rows: vehicles.map((vehicle) {
          return DataRow(
            cells: [
              DataCell(_buildVehicleNumberCell(vehicle, isSmallScreen)),
              DataCell(_buildTableData(vehicle.ownerName, isSmallScreen)),
              DataCell(_buildTableData(vehicle.driverName, isSmallScreen)),
              DataCell(_buildContactCell(vehicle.driverContact, isSmallScreen)),
              DataCell(_buildCapacityCell(vehicle.capacity, isSmallScreen)),
              DataCell(_buildVehicleTypeChip(vehicle.vehicleType)),
              DataCell(_buildExpiryCell(vehicle.insuranceExpiry, isSmallScreen)),
              DataCell(_buildStatusChip(vehicle.isActive)),
              DataCell(_buildActionButtons(context, isSmallScreen)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVehicleNumberCell(Vehicle vehicle, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          vehicle.vehicleNumber,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 2),
        Text(
          vehicle.insuranceNumber,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCell(String contact, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {
        // Handle call functionality
      },
      child: Row(
        children: [
          Icon(Icons.phone, size: 14, color: Colors.green.shade600),
          SizedBox(width: 4),
          Text(
            contact,
            style: TextStyle(
              color: Colors.green.shade600,
              fontSize: isSmallScreen ? 11 : 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapacityCell(double capacity, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getCapacityColor(capacity).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _getCapacityColor(capacity).withOpacity(0.3)),
      ),
      child: Text(
        '${capacity.toStringAsFixed(1)} Tons',
        style: TextStyle(
          color: _getCapacityColor(capacity),
          fontSize: isSmallScreen ? 11 : 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildVehicleTypeChip(String type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getVehicleTypeColor(type).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _getVehicleTypeColor(type).withOpacity(0.3)),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: _getVehicleTypeColor(type),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildExpiryCell(DateTime expiry, bool isSmallScreen) {
    final daysLeft = expiry.difference(DateTime.now()).inDays;
    Color color = daysLeft > 30 ? Colors.green : daysLeft > 7 ? Colors.orange : Colors.red;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatDate(expiry),
            style: TextStyle(
              color: color,
              fontSize: isSmallScreen ? 10 : 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            '$daysLeft days left',
            style: TextStyle(
              color: color,
              fontSize: isSmallScreen ? 8 : 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    return Chip(
      label: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: isActive ? Colors.green : Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: isActive ? Colors.green.shade50 : Colors.red.shade50,
      side: BorderSide(
        color: isActive ? Colors.green.shade100 : Colors.red.shade100,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Color _getCapacityColor(double capacity) {
    if (capacity >= 20) return Colors.green;
    if (capacity >= 15) return Colors.blue;
    return Colors.orange;
  }

  Color _getVehicleTypeColor(String type) {
    switch (type) {
      case 'Truck':
        return Colors.blue;
      case 'Trailer':
        return Colors.green;
      case 'Dumper':
        return Colors.orange;
      case 'Tipper':
        return Colors.purple;
      case 'Container':
        return Colors.red;
      case 'Tanker':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  Widget _buildTableHeader(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget _buildTableData(String text, bool isSmallScreen) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: isSmallScreen ? 12 : 14,
      ),
    );
  }

  Widget _buildMobileVehicleList(BuildContext context, List<Vehicle> vehicles, bool isSmallScreen) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vehicles.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return _buildMobileVehicleCard(context, vehicle, isSmallScreen);
      },
    );
  }

  Widget _buildMobileVehicleCard(BuildContext context, Vehicle vehicle, bool isSmallScreen) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                _showVehicleDetails(context, vehicle);
              },
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16.0 : 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle.vehicleNumber,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Ins: ${vehicle.insuranceNumber}',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildStatusChip(vehicle.isActive),
                      ],
                    ),
                    SizedBox(height: 12),
                    _buildVehicleDetailItem('Owner', vehicle.ownerName, Icons.person, isSmallScreen),
                    _buildVehicleDetailItem('Driver', vehicle.driverName, Icons.drive_eta, isSmallScreen),
                    _buildVehicleDetailItem('Contact', vehicle.driverContact, Icons.phone, isSmallScreen),
                    _buildVehicleDetailItem('Capacity', '${vehicle.capacity.toStringAsFixed(1)} Tons', Icons.scale, isSmallScreen),
                    _buildVehicleDetailItem('Type', vehicle.vehicleType, Icons.local_shipping, isSmallScreen),
                    _buildVehicleDetailItem('Insurance Expiry', _formatDate(vehicle.insuranceExpiry), Icons.assignment_turned_in, isSmallScreen),
                    _buildVehicleDetailItem('Fitness Expiry', _formatDate(vehicle.fitnessExpiry), Icons.engineering, isSmallScreen),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        _buildVehicleTypeChip(vehicle.vehicleType),
                        SizedBox(width: 8),
                        _buildCapacityCell(vehicle.capacity, isSmallScreen),
                        Spacer(),
                        _buildActionButtons(context, isSmallScreen),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleDetailItem(String label, String value, IconData icon, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: isSmallScreen ? 14 : 16, color: Colors.orange.shade400),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    fontSize: isSmallScreen ? 11 : 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: isSmallScreen ? 12 : 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isSmallScreen) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.visibility, size: isSmallScreen ? 18 : 20),
          color: Colors.orange.shade400,
          onPressed: () {
            // View vehicle details
          },
          padding: EdgeInsets.all(8),
        ),
        IconButton(
          icon: Icon(Icons.edit, size: isSmallScreen ? 18 : 20),
          color: Colors.blue.shade400,
          onPressed: () {
            _showEditVehicleDialog(context);
          },
          padding: EdgeInsets.all(8),
        ),
        IconButton(
          icon: Icon(Icons.delete, size: isSmallScreen ? 18 : 20),
          color: Colors.red.shade400,
          onPressed: () {
            _showDeleteConfirmationDialog(context);
          },
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddVehicleDialog(context);
      },
      backgroundColor: Colors.orange.shade400,
      elevation: 8,
      child: Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  void _showVehicleDetails(BuildContext context, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (context) => _buildVehicleDetailsDialog(context, vehicle),
    );
  }

  Widget _buildVehicleDetailsDialog(BuildContext context, Vehicle vehicle) {
    final insuranceDaysLeft = vehicle.insuranceExpiry.difference(DateTime.now()).inDays;
    final fitnessDaysLeft = vehicle.fitnessExpiry.difference(DateTime.now()).inDays;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.local_shipping, color: Colors.orange.shade400, size: 28),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.vehicleNumber,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 4),
                        _buildStatusChip(vehicle.isActive),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey.shade600),
                  ),
                ],
              ),
              SizedBox(height: 24),
              _buildVehicleDetailRow('Owner Name', vehicle.ownerName, Icons.person),
              _buildVehicleDetailRow('Driver Name', vehicle.driverName, Icons.drive_eta),
              _buildVehicleDetailRow('Driver Contact', vehicle.driverContact, Icons.phone),
              _buildVehicleDetailRow('Capacity', '${vehicle.capacity.toStringAsFixed(1)} Tons', Icons.scale),
              _buildVehicleDetailRow('Vehicle Type', vehicle.vehicleType, Icons.local_shipping),
              _buildVehicleDetailRow('Insurance No.', vehicle.insuranceNumber, Icons.assignment),
              _buildExpiryDetailRow('Insurance Expiry', vehicle.insuranceExpiry, insuranceDaysLeft, Icons.assignment_turned_in),
              _buildExpiryDetailRow('Fitness Expiry', vehicle.fitnessExpiry, fitnessDaysLeft, Icons.engineering),
              _buildVehicleDetailRow('Added Date', _formatDate(vehicle.createdAt), Icons.calendar_today),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showEditVehicleDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400,
                    ),
                    child: Text('Edit Vehicle', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Colors.orange.shade400),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryDetailRow(String label, DateTime expiry, int daysLeft, IconData icon) {
    Color color = daysLeft > 30 ? Colors.green : daysLeft > 7 ? Colors.orange : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _formatDate(expiry),
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '$daysLeft days left',
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showAddVehicleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildVehicleDialog(context, 'Add Vehicle', null),
    );
  }

  void _showEditVehicleDialog(BuildContext context) {
    final sampleVehicle = VehicleData.getVehicles().first;
    showDialog(
      context: context,
      builder: (context) => _buildVehicleDialog(context, 'Edit Vehicle', sampleVehicle),
    );
  }

  Widget _buildVehicleDialog(BuildContext context, String title, Vehicle? vehicle) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      vehicle == null ? Icons.add : Icons.edit,
                      color: Colors.orange.shade400,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField('Vehicle Number', vehicle?.vehicleNumber),
                    SizedBox(height: 16),
                    _buildTextField('Owner Name', vehicle?.ownerName),
                    SizedBox(height: 16),
                    _buildTextField('Driver Name', vehicle?.driverName),
                    SizedBox(height: 16),
                    _buildTextField('Driver Contact', vehicle?.driverContact),
                    SizedBox(height: 16),
                    _buildNumberField('Capacity (Tons)', vehicle?.capacity.toString()),
                    SizedBox(height: 16),
                    _buildDropdownField('Vehicle Type', vehicle?.vehicleType, VehicleData.getVehicleTypes()),
                    SizedBox(height: 16),
                    _buildTextField('Insurance Number', vehicle?.insuranceNumber),
                    SizedBox(height: 16),
                    _buildDateField('Insurance Expiry', vehicle?.insuranceExpiry),
                    SizedBox(height: 16),
                    _buildDateField('Fitness Expiry', vehicle?.fitnessExpiry),
                    SizedBox(height: 16),
                    _buildSwitchField('Active Vehicle', vehicle?.isActive ?? true),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Handle save logic here
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String? initialValue, {int maxLines = 1}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.orange.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      controller: initialValue != null ? TextEditingController(text: initialValue) : null,
      maxLines: maxLines,
    );
  }

  Widget _buildNumberField(String label, String? initialValue) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.orange.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      controller: initialValue != null ? TextEditingController(text: initialValue) : null,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildDateField(String label, DateTime? initialValue) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.orange.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: Icon(Icons.calendar_today, color: Colors.orange.shade400),
      ),
      controller: initialValue != null ? TextEditingController(text: _formatDate(initialValue)) : null,
      readOnly: true,
      onTap: () {
        // Show date picker
      },
    );
  }

  Widget _buildDropdownField(String label, String? initialValue, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.orange.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      value: initialValue,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }

  Widget _buildSwitchField(String label, bool value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Switch(
          value: value,
          activeColor: Colors.orange.shade400,
          onChanged: (newValue) {},
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.warning, color: Colors.orange, size: 24),
            ),
            SizedBox(width: 12),
            Text('Confirm Delete', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text('Are you sure you want to delete this vehicle? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle delete logic here
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}