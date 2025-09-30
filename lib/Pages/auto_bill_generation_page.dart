// auto_bill_generation_page.dart
import 'package:flutter/material.dart';
import '../Models/bill_model.dart';

class AutoBillGenerationPage extends StatelessWidget {
  const AutoBillGenerationPage({super.key});

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
                    _buildStatsGrid(isSmallScreen, isMediumScreen, isLargeScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildPendingTicketsSection(context, isSmallScreen, isMediumScreen, isLargeScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildGeneratedInvoicesSection(context, isSmallScreen, isMediumScreen, isLargeScreen),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade400, Colors.purple.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.receipt_long_outlined,
            color: Colors.white,
            size: isSmallScreen ? 24 : 32,
          ),
        ),
        SizedBox(width: isSmallScreen ? 12 : 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Auto Bill Generation',
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Create invoices from completed weighment tickets',
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const Spacer(),
        _buildGenerateReportButton(context, isSmallScreen),
      ],
    );
  }

  Widget _buildGenerateReportButton(BuildContext context, bool isSmallScreen) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Generate report
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
            Icon(Icons.summarize, size: isSmallScreen ? 16 : 18, color: Colors.white),
            SizedBox(width: 6),
            Text(
              isSmallScreen ? 'Report' : 'Generate Report',
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

    final pendingTickets = BillData.getPendingWeighmentTickets();
    final generatedInvoices = BillData.getGeneratedInvoices();
    final totalRevenue = generatedInvoices.fold(0.0, (sum, invoice) => sum + invoice.ticket.grandTotal);
    final pendingAmount = generatedInvoices.where((inv) => inv.status == 'Pending').fold(0.0, (sum, invoice) => sum + invoice.ticket.grandTotal);

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: isSmallScreen ? 8 : 16,
      mainAxisSpacing: isSmallScreen ? 8 : 16,
      childAspectRatio: childAspectRatio,
      children: [
        _buildStatCard('Pending Tickets', '${pendingTickets.length}', Icons.pending_actions, Colors.orange, isSmallScreen),
        _buildStatCard('Generated Invoices', '${generatedInvoices.length}', Icons.receipt, Colors.purple, isSmallScreen),
        _buildStatCard('Total Revenue', '₹${totalRevenue.toStringAsFixed(0)}', Icons.attach_money, Colors.green, isSmallScreen),
        _buildStatCard('Pending Amount', '₹${pendingAmount.toStringAsFixed(0)}', Icons.payment, Colors.red, isSmallScreen),
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

  Widget _buildPendingTicketsSection(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Card(
        key: ValueKey('pending_tickets'),
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
                      child: Icon(Icons.pending_actions, color: Colors.orange.shade400, size: 20),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Pending Weighment Tickets',
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
                _buildPendingTicketsList(context, isSmallScreen, isMediumScreen, isLargeScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGeneratedInvoicesSection(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Card(
        key: ValueKey('generated_invoices'),
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
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.receipt_long, color: Colors.purple.shade400, size: 20),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Generated Invoices',
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
                _buildGeneratedInvoicesList(context, isSmallScreen, isMediumScreen, isLargeScreen),
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
            child: Icon(Icons.grid_view, size: 16, color: Colors.purple.shade400),
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

  Widget _buildPendingTicketsList(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    final tickets = BillData.getPendingWeighmentTickets();

    if (isLargeScreen) {
      return _buildDesktopPendingTicketsTable(context, tickets, isSmallScreen);
    } else {
      return _buildMobilePendingTicketsList(context, tickets, isSmallScreen);
    }
  }

  Widget _buildDesktopPendingTicketsTable(BuildContext context, List<WeighmentTicket> tickets, bool isSmallScreen) {
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
          DataColumn(label: _buildTableHeader('Ticket No.')),
          DataColumn(label: _buildTableHeader('Date')),
          DataColumn(label: _buildTableHeader('Vehicle')),
          DataColumn(label: _buildTableHeader('Customer')),
          DataColumn(label: _buildTableHeader('Product')),
          DataColumn(label: _buildTableHeader('Net Weight')),
          DataColumn(label: _buildTableHeader('Amount')),
          DataColumn(label: _buildTableHeader('Actions')),
        ],
        rows: tickets.map((ticket) {
          return DataRow(
            cells: [
              DataCell(_buildTicketNumberCell(ticket, isSmallScreen)),
              DataCell(_buildTableData(_formatDate(ticket.date), isSmallScreen)),
              DataCell(_buildVehicleCell(ticket, isSmallScreen)),
              DataCell(_buildCustomerCell(ticket, isSmallScreen)),
              DataCell(_buildProductChip(ticket.product)),
              DataCell(_buildWeightCell(ticket.netWeight, isSmallScreen)),
              DataCell(_buildAmountCell(ticket.totalAmount, isSmallScreen)),
              DataCell(_buildTicketActionButtons(context, ticket, isSmallScreen)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTicketNumberCell(WeighmentTicket ticket, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ticket.ticketNumber,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 2),
        Text(
          '${_formatTime(ticket.inTime)} - ${_formatTime(ticket.outTime)}',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleCell(WeighmentTicket ticket, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ticket.vehicleNumber,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 2),
        Text(
          ticket.driverName,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerCell(WeighmentTicket ticket, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ticket.customer,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 2),
        Text(
          ticket.customerGstin,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildProductChip(String product) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getProductColor(product).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _getProductColor(product).withOpacity(0.3)),
      ),
      child: Text(
        product,
        style: TextStyle(
          color: _getProductColor(product),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildWeightCell(double weight, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text(
        '${weight.toStringAsFixed(1)} MT',
        style: TextStyle(
          color: Colors.blue.shade600,
          fontSize: isSmallScreen ? 11 : 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAmountCell(double amount, bool isSmallScreen) {
    return Text(
      '₹${amount.toStringAsFixed(0)}',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.green.shade600,
        fontSize: isSmallScreen ? 12 : 14,
      ),
    );
  }

  Widget _buildTicketActionButtons(BuildContext context, WeighmentTicket ticket, bool isSmallScreen) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.visibility, size: isSmallScreen ? 16 : 18),
          color: Colors.blue.shade400,
          onPressed: () {
            _showTicketDetails(context, ticket);
          },
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.receipt, size: isSmallScreen ? 16 : 18),
          color: Colors.purple.shade400,
          onPressed: () {
            _showGenerateInvoiceDialog(context, ticket);
          },
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildMobilePendingTicketsList(BuildContext context, List<WeighmentTicket> tickets, bool isSmallScreen) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tickets.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return _buildMobilePendingTicketCard(context, ticket, isSmallScreen);
      },
    );
  }

  Widget _buildMobilePendingTicketCard(BuildContext context, WeighmentTicket ticket, bool isSmallScreen) {
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
                _showTicketDetails(context, ticket);
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
                                ticket.ticketNumber,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${_formatDate(ticket.date)} • ${_formatTime(ticket.inTime)} - ${_formatTime(ticket.outTime)}',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildProductChip(ticket.product),
                      ],
                    ),
                    SizedBox(height: 12),
                    _buildTicketDetailItem('Vehicle', '${ticket.vehicleNumber} • ${ticket.driverName}', Icons.local_shipping, isSmallScreen),
                    _buildTicketDetailItem('Customer', ticket.customer, Icons.business, isSmallScreen),
                    _buildTicketDetailItem('Route', '${ticket.source} → ${ticket.destination}', Icons.route, isSmallScreen),
                    _buildTicketDetailItem('Weight', 'Gross: ${ticket.grossWeight} MT | Tare: ${ticket.tareWeight} MT | Net: ${ticket.netWeight} MT', Icons.scale, isSmallScreen),
                    _buildTicketDetailItem('Rate', '₹${ticket.ratePerTon}/MT', Icons.attach_money, isSmallScreen),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.green.shade100),
                          ),
                          child: Text(
                            '₹${ticket.totalAmount.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: Colors.green.shade600,
                              fontSize: isSmallScreen ? 12 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        _buildTicketActionButtons(context, ticket, isSmallScreen),
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

  Widget _buildTicketDetailItem(String label, String value, IconData icon, bool isSmallScreen) {
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

  Widget _buildGeneratedInvoicesList(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    final invoices = BillData.getGeneratedInvoices();

    if (isLargeScreen) {
      return _buildDesktopInvoicesTable(context, invoices, isSmallScreen);
    } else {
      return _buildMobileInvoicesList(context, invoices, isSmallScreen);
    }
  }

  Widget _buildDesktopInvoicesTable(BuildContext context, List<Invoice> invoices, bool isSmallScreen) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.purple.shade50),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade800,
          fontSize: isSmallScreen ? 12 : 14,
        ),
        dataRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.purple.shade50;
            }
            return Colors.transparent;
          },
        ),
        columns: [
          DataColumn(label: _buildTableHeader('Invoice No.')),
          DataColumn(label: _buildTableHeader('Date')),
          DataColumn(label: _buildTableHeader('Customer')),
          DataColumn(label: _buildTableHeader('Ticket No.')),
          DataColumn(label: _buildTableHeader('Amount')),
          DataColumn(label: _buildTableHeader('Tax')),
          DataColumn(label: _buildTableHeader('Grand Total')),
          DataColumn(label: _buildTableHeader('Status')),
          DataColumn(label: _buildTableHeader('Actions')),
        ],
        rows: invoices.map((invoice) {
          return DataRow(
            cells: [
              DataCell(_buildInvoiceNumberCell(invoice, isSmallScreen)),
              DataCell(_buildTableData(_formatDate(invoice.invoiceDate), isSmallScreen)),
              DataCell(_buildTableData(invoice.ticket.customer, isSmallScreen)),
              DataCell(_buildTableData(invoice.ticket.ticketNumber, isSmallScreen)),
              DataCell(_buildAmountCell(invoice.ticket.totalAmount, isSmallScreen)),
              DataCell(_buildTaxCell(invoice.ticket.taxAmount, isSmallScreen)),
              DataCell(_buildGrandTotalCell(invoice.ticket.grandTotal, isSmallScreen)),
              DataCell(_buildInvoiceStatusChip(invoice.status)),
              DataCell(_buildInvoiceActionButtons(context, invoice, isSmallScreen)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInvoiceNumberCell(Invoice invoice, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          invoice.invoiceNumber,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 2),
        Text(
          invoice.paymentMode,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTaxCell(double taxAmount, bool isSmallScreen) {
    return Text(
      '₹${taxAmount.toStringAsFixed(0)}',
      style: TextStyle(
        color: Colors.orange.shade600,
        fontSize: isSmallScreen ? 12 : 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildGrandTotalCell(double grandTotal, bool isSmallScreen) {
    return Text(
      '₹${grandTotal.toStringAsFixed(0)}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.purple.shade600,
        fontSize: isSmallScreen ? 12 : 14,
      ),
    );
  }

  Widget _buildInvoiceStatusChip(String status) {
    Color color = status == 'Paid' ? Colors.green : Colors.orange;
    return Chip(
      label: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildInvoiceActionButtons(BuildContext context, Invoice invoice, bool isSmallScreen) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.visibility, size: isSmallScreen ? 16 : 18),
          color: Colors.blue.shade400,
          onPressed: () {
            _showInvoiceDetails(context, invoice);
          },
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.download, size: isSmallScreen ? 16 : 18),
          color: Colors.green.shade400,
          onPressed: () {
            // Download invoice
          },
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.share, size: isSmallScreen ? 16 : 18),
          color: Colors.purple.shade400,
          onPressed: () {
            // Share invoice
          },
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildMobileInvoicesList(BuildContext context, List<Invoice> invoices, bool isSmallScreen) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: invoices.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        return _buildMobileInvoiceCard(context, invoice, isSmallScreen);
      },
    );
  }

  Widget _buildMobileInvoiceCard(BuildContext context, Invoice invoice, bool isSmallScreen) {
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
                _showInvoiceDetails(context, invoice);
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
                                invoice.invoiceNumber,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${_formatDate(invoice.invoiceDate)} • ${invoice.paymentMode}',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildInvoiceStatusChip(invoice.status),
                      ],
                    ),
                    SizedBox(height: 12),
                    _buildInvoiceDetailItem('Customer', invoice.ticket.customer, Icons.business, isSmallScreen),
                    _buildInvoiceDetailItem('Ticket No.', invoice.ticket.ticketNumber, Icons.receipt, isSmallScreen),
                    _buildInvoiceDetailItem('Product', invoice.ticket.product, Icons.inventory, isSmallScreen),
                    _buildInvoiceDetailItem('Net Weight', '${invoice.ticket.netWeight.toStringAsFixed(1)} MT', Icons.scale, isSmallScreen),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amount: ₹${invoice.ticket.totalAmount.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Tax: ₹${invoice.ticket.taxAmount.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Colors.orange.shade600,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          '₹${invoice.ticket.grandTotal.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    _buildInvoiceActionButtons(context, invoice, isSmallScreen),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceDetailItem(String label, String value, IconData icon, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: isSmallScreen ? 14 : 16, color: Colors.purple.shade400),
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

  Color _getProductColor(String product) {
    switch (product) {
      case '20mm Aggregate':
        return Colors.blue;
      case '40mm Aggregate':
        return Colors.blue.shade700;
      case 'River Sand':
        return Colors.yellow.shade700;
      case 'GSB':
        return Colors.orange;
      case 'Stone Dust':
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _showTicketDetails(BuildContext context, WeighmentTicket ticket) {
    showDialog(
      context: context,
      builder: (context) => _buildTicketDetailsDialog(context, ticket),
    );
  }

  void _showInvoiceDetails(BuildContext context, Invoice invoice) {
    showDialog(
      context: context,
      builder: (context) => _buildInvoiceDetailsDialog(context, invoice),
    );
  }

  void _showGenerateInvoiceDialog(BuildContext context, WeighmentTicket ticket) {
    showDialog(
      context: context,
      builder: (context) => _buildGenerateInvoiceDialog(context, ticket),
    );
  }

  // Dialog builders (similar to previous implementations)
  // These would include detailed views for tickets and invoices
  // and the invoice generation form

  Widget _buildTicketDetailsDialog(BuildContext context, WeighmentTicket ticket) {
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
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.receipt, color: Colors.orange.shade400, size: 28),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weighment Ticket - ${ticket.ticketNumber}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.green.shade100),
                          ),
                          child: Text(
                            ticket.status,
                            style: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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
              // Add detailed ticket information here
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
                      _showGenerateInvoiceDialog(context, ticket);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade400,
                    ),
                    child: Text('Generate Invoice', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceDetailsDialog(BuildContext context, Invoice invoice) {
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
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.receipt_long, color: Colors.purple.shade400, size: 28),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invoice - ${invoice.invoiceNumber}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 4),
                        _buildInvoiceStatusChip(invoice.status),
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
              // Add detailed invoice information here
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
                      // Download invoice
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                    ),
                    child: Text('Download PDF', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenerateInvoiceDialog(BuildContext context, WeighmentTicket ticket) {
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
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.receipt_long, color: Colors.purple.shade400, size: 24),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Generate Invoice',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Ticket: ${ticket.ticketNumber}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Customer: ${ticket.customer}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Amount: ₹${ticket.totalAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade600,
                ),
              ),
              SizedBox(height: 24),
              _buildDropdownField('Tax Rate', '18%', BillData.getTaxRates()),
              SizedBox(height: 16),
              _buildDropdownField('Payment Mode', 'Bank Transfer', BillData.getPaymentModes()),
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
                      // Generate invoice logic
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade400,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Generate Invoice', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
          borderSide: BorderSide(color: Colors.purple.shade400),
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
}