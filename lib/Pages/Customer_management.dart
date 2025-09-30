import 'package:flutter/material.dart';

class CustomerManagementPage extends StatelessWidget {
  const CustomerManagementPage({super.key});

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
                    _buildCustomerListSection(context, isSmallScreen, isMediumScreen, isLargeScreen),
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
              colors: [Colors.lightBlue.shade400, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.group_outlined,
            color: Colors.white,
            size: isSmallScreen ? 24 : 32,
          ),
        ),
        SizedBox(width: isSmallScreen ? 12 : 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Management',
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Manage your business customers',
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
          colors: [Colors.lightBlue.shade400, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          _showAddCustomerDialog(context);
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
              isSmallScreen ? 'Add' : 'Add Customer',
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
                  Icon(Icons.search, color: Colors.lightBlue.shade400, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Find Customers',
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
                hintText: 'Search by company name, contact person...',
                prefixIcon: Icon(Icons.search, color: Colors.lightBlue.shade400),
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
                child: Icon(Icons.filter_list_alt, color: Colors.lightBlue.shade400),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerListSection(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Card(
        key: ValueKey('customer_list'),
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
                        color: Colors.lightBlue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.business, color: Colors.lightBlue.shade400, size: 20),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Customer Directory',
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
                _buildCustomerList(context, isSmallScreen, isMediumScreen, isLargeScreen),
              ],
            ),
          ),
        ),
      ),
    );
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
            child: Icon(Icons.grid_view, size: 16, color: Colors.lightBlue.shade400),
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

  Widget _buildCustomerList(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    final List<Map<String, dynamic>> customers = [
      {
        'companyName': 'Tech Solutions Inc.',
        'gstin': '29AABCU9603R1ZM',
        'contactPerson': 'John Smith',
        'address': '123 Business Park, Mumbai, Maharashtra 400001',
        'paymentTerms': 'Net 30',
        'status': 'Active',
        'email': 'john@techsolutions.com',
        'phone': '+91 98765 43210'
      },
      {
        'companyName': 'Global Enterprises Ltd.',
        'gstin': '07ABACS4307B1Z9',
        'contactPerson': 'Sarah Johnson',
        'address': '456 Corporate Tower, Delhi, NCR 110001',
        'paymentTerms': 'Net 45',
        'status': 'Active',
        'email': 'sarah@globalent.com',
        'phone': '+91 87654 32109'
      },
      {
        'companyName': 'Innovative Systems',
        'gstin': '24AADCI1205H1ZP',
        'contactPerson': 'Mike Wilson',
        'address': '789 Tech Hub, Bangalore, Karnataka 560001',
        'paymentTerms': 'Net 15',
        'status': 'Inactive',
        'email': 'mike@innovative.com',
        'phone': '+91 76543 21098'
      },
    ];

    if (isLargeScreen) {
      return _buildDesktopCustomerTable(context, customers, isSmallScreen);
    } else {
      return _buildMobileCustomerList(context, customers, isSmallScreen);
    }
  }

  Widget _buildDesktopCustomerTable(BuildContext context, List<Map<String, dynamic>> customers, bool isSmallScreen) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.lightBlue.shade50),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade800,
          fontSize: isSmallScreen ? 12 : 14,
        ),
        dataRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.lightBlue.shade50;
            }
            return Colors.transparent;
          },
        ),
        columns: [
          DataColumn(label: _buildTableHeader('Company Name')),
          DataColumn(label: _buildTableHeader('GSTIN')),
          DataColumn(label: _buildTableHeader('Contact Person')),
          DataColumn(label: _buildTableHeader('Address')),
          DataColumn(label: _buildTableHeader('Payment Terms')),
          DataColumn(label: _buildTableHeader('Status')),
          DataColumn(label: _buildTableHeader('Actions')),
        ],
        rows: customers.map((customer) {
          return DataRow(
            cells: [
              DataCell(_buildCompanyCell(customer, isSmallScreen)),
              DataCell(_buildTableData(customer['gstin']!, isSmallScreen)),
              DataCell(_buildContactCell(customer, isSmallScreen)),
              DataCell(_buildTableData(customer['address']!, isSmallScreen)),
              DataCell(_buildPaymentTermsCell(customer['paymentTerms']!, isSmallScreen)),
              DataCell(_buildStatusChip(customer['status']!)),
              DataCell(_buildActionButtons(context, isSmallScreen)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCompanyCell(Map<String, dynamic> customer, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          customer['companyName']!,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 2),
        Text(
          customer['email']!,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCell(Map<String, dynamic> customer, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          customer['contactPerson']!,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 2),
        Text(
          customer['phone']!,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentTermsCell(String terms, bool isSmallScreen) {
    Color color = terms == 'Net 15' ? Colors.green : 
                 terms == 'Net 30' ? Colors.blue : 
                 terms == 'Net 45' ? Colors.orange : Colors.red;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        terms,
        style: TextStyle(
          color: color,
          fontSize: isSmallScreen ? 10 : 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Chip(
      label: Text(
        status,
        style: TextStyle(
          color: status == 'Active' ? Colors.green : Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: status == 'Active' ? Colors.green.shade50 : Colors.red.shade50,
      side: BorderSide(
        color: status == 'Active' ? Colors.green.shade100 : Colors.red.shade100,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
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

  Widget _buildMobileCustomerList(BuildContext context, List<Map<String, dynamic>> customers, bool isSmallScreen) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: customers.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final customer = customers[index];
        return _buildMobileCustomerCard(context, customer, isSmallScreen);
      },
    );
  }

  Widget _buildMobileCustomerCard(BuildContext context, Map<String, dynamic> customer, bool isSmallScreen) {
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
                _showCustomerDetails(context, customer);
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
                                customer['companyName']!,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                customer['email']!,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildStatusChip(customer['status']!),
                      ],
                    ),
                    SizedBox(height: 12),
                    _buildCustomerDetailItem('GSTIN', customer['gstin']!, Icons.receipt, isSmallScreen),
                    _buildCustomerDetailItem('Contact', customer['contactPerson']!, Icons.person, isSmallScreen),
                    _buildCustomerDetailItem('Phone', customer['phone']!, Icons.phone, isSmallScreen),
                    _buildCustomerDetailItem('Address', customer['address']!, Icons.location_on, isSmallScreen),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        _buildPaymentTermsCell(customer['paymentTerms']!, isSmallScreen),
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

  Widget _buildCustomerDetailItem(String label, String value, IconData icon, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: isSmallScreen ? 14 : 16, color: Colors.lightBlue.shade400),
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
          color: Colors.lightBlue.shade400,
          onPressed: () {
            // View customer details
          },
          padding: EdgeInsets.all(8),
        ),
        IconButton(
          icon: Icon(Icons.edit, size: isSmallScreen ? 18 : 20),
          color: Colors.orange.shade400,
          onPressed: () {
            _showEditCustomerDialog(context);
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
        _showAddCustomerDialog(context);
      },
      backgroundColor: Colors.lightBlue.shade400,
      elevation: 8,
      child: Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  void _showCustomerDetails(BuildContext context, Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => _buildCustomerDetailsDialog(context, customer),
    );
  }

  Widget _buildCustomerDetailsDialog(BuildContext context, Map<String, dynamic> customer) {
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
                      color: Colors.lightBlue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.business, color: Colors.lightBlue.shade400, size: 28),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer['companyName']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 4),
                        _buildStatusChip(customer['status']!),
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
              _buildDetailRow('GSTIN', customer['gstin']!, Icons.receipt),
              _buildDetailRow('Contact Person', customer['contactPerson']!, Icons.person),
              _buildDetailRow('Email', customer['email']!, Icons.email),
              _buildDetailRow('Phone', customer['phone']!, Icons.phone),
              _buildDetailRow('Address', customer['address']!, Icons.location_on),
              _buildDetailRow('Payment Terms', customer['paymentTerms']!, Icons.payment),
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
                      _showEditCustomerDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue.shade400,
                    ),
                    child: Text('Edit Customer', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Colors.lightBlue.shade400),
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

  void _showAddCustomerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildCustomerDialog(context, 'Add Customer', null),
    );
  }

  void _showEditCustomerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildCustomerDialog(context, 'Edit Customer', {
        'companyName': 'Tech Solutions Inc.',
        'gstin': '29AABCU9603R1ZM',
        'contactPerson': 'John Smith',
        'address': '123 Business Park, Mumbai, Maharashtra 400001',
        'paymentTerms': 'Net 30',
        'email': 'john@techsolutions.com',
        'phone': '+91 98765 43210'
      }),
    );
  }

  Widget _buildCustomerDialog(BuildContext context, String title, Map<String, String>? customerData) {
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
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      customerData == null ? Icons.add : Icons.edit,
                      color: Colors.lightBlue.shade400,
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
              _buildTextField('Company Name', customerData?['companyName']),
              SizedBox(height: 16),
              _buildTextField('GSTIN', customerData?['gstin']),
              SizedBox(height: 16),
              _buildTextField('Contact Person', customerData?['contactPerson']),
              SizedBox(height: 16),
              _buildTextField('Email', customerData?['email']),
              SizedBox(height: 16),
              _buildTextField('Phone', customerData?['phone']),
              SizedBox(height: 16),
              _buildTextField('Address', customerData?['address'], maxLines: 3),
              SizedBox(height: 16),
              _buildDropdownField('Payment Terms', customerData?['paymentTerms']),
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
                      backgroundColor: Colors.lightBlue.shade400,
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
          borderSide: BorderSide(color: Colors.lightBlue.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      controller: initialValue != null ? TextEditingController(text: initialValue) : null,
      maxLines: maxLines,
    );
  }

  Widget _buildDropdownField(String label, String? initialValue) {
    final paymentTerms = ['Net 15', 'Net 30', 'Net 45', 'Net 60', 'Due on receipt'];
    
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
          borderSide: BorderSide(color: Colors.lightBlue.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      value: initialValue,
      items: paymentTerms.map((term) {
        return DropdownMenuItem(
          value: term,
          child: Text(term),
        );
      }).toList(),
      onChanged: (value) {},
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
        content: Text('Are you sure you want to delete this customer? This action cannot be undone.'),
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