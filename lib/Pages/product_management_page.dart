// product_management_page.dart
import 'package:flutter/material.dart';
import '../Models/product_model.dart';

class ProductManagementPage extends StatelessWidget {
  const ProductManagementPage({super.key});

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
                    _buildProductListSection(context, isSmallScreen, isMediumScreen, isLargeScreen),
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
              colors: [Colors.green.shade400, Colors.green.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.inventory_2_outlined,
            color: Colors.white,
            size: isSmallScreen ? 24 : 32,
          ),
        ),
        SizedBox(width: isSmallScreen ? 12 : 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Management',
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Manage construction materials and products',
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
          colors: [Colors.green.shade400, Colors.green.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          _showAddProductDialog(context);
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
              isSmallScreen ? 'Add' : 'Add Product',
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
                  Icon(Icons.search, color: Colors.green.shade400, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Find Products',
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
                hintText: 'Search by product name, HSN code...',
                prefixIcon: Icon(Icons.search, color: Colors.green.shade400),
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
                child: Icon(Icons.filter_list_alt, color: Colors.green.shade400),
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

    final products = ProductData.getProducts();
    final activeProducts = products.where((p) => p.isActive).length;
    final totalCategories = ProductData.getCategories().length;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: isSmallScreen ? 8 : 16,
      mainAxisSpacing: isSmallScreen ? 8 : 16,
      childAspectRatio: childAspectRatio,
      children: [
        _buildStatCard('Total Products', '${products.length}', Icons.inventory, Colors.green, isSmallScreen),
        _buildStatCard('Active Products', '$activeProducts', Icons.check_circle, Colors.blue, isSmallScreen),
        _buildStatCard('Categories', '$totalCategories', Icons.category, Colors.orange, isSmallScreen),
        _buildStatCard('Avg Price', '₹650/MT', Icons.attach_money, Colors.purple, isSmallScreen),
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

  Widget _buildProductListSection(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Card(
        key: ValueKey('product_list'),
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
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.list_alt, color: Colors.green.shade400, size: 20),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Product Catalog',
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
                _buildProductList(context, isSmallScreen, isMediumScreen, isLargeScreen),
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
            child: Icon(Icons.grid_view, size: 16, color: Colors.green.shade400),
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

  Widget _buildProductList(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    final products = ProductData.getProducts();

    if (isLargeScreen) {
      return _buildDesktopProductTable(context, products, isSmallScreen);
    } else {
      return _buildMobileProductList(context, products, isSmallScreen);
    }
  }

  Widget _buildDesktopProductTable(BuildContext context, List<Product> products, bool isSmallScreen) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.green.shade50),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade800,
          fontSize: isSmallScreen ? 12 : 14,
        ),
        dataRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.green.shade50;
            }
            return Colors.transparent;
          },
        ),
        columns: [
          DataColumn(label: _buildTableHeader('Product Name')),
          DataColumn(label: _buildTableHeader('Category')),
          DataColumn(label: _buildTableHeader('HSN/SAC')),
          DataColumn(label: _buildTableHeader('Unit')),
          DataColumn(label: _buildTableHeader('Price')),
          DataColumn(label: _buildTableHeader('Tax Rate')),
          DataColumn(label: _buildTableHeader('Status')),
          DataColumn(label: _buildTableHeader('Actions')),
        ],
        rows: products.map((product) {
          return DataRow(
            cells: [
              DataCell(_buildProductNameCell(product, isSmallScreen)),
              DataCell(_buildCategoryChip(product.category)),
              DataCell(_buildTableData(product.hsnSacCode, isSmallScreen)),
              DataCell(_buildUnitChip(product.unit)),
              DataCell(_buildPriceCell(product.price, isSmallScreen)),
              DataCell(_buildTaxRateCell(product.taxRate, isSmallScreen)),
              DataCell(_buildStatusChip(product.isActive)),
              DataCell(_buildActionButtons(context, isSmallScreen)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductNameCell(Product product, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          product.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: isSmallScreen ? 12 : 14,
          ),
        ),
        SizedBox(height: 2),
        Text(
          product.description,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 10 : 12,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getCategoryColor(category).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _getCategoryColor(category).withOpacity(0.3)),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: _getCategoryColor(category),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildUnitChip(String unit) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text(
        unit,
        style: TextStyle(
          color: Colors.blue.shade600,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPriceCell(double price, bool isSmallScreen) {
    return Text(
      '₹${price.toStringAsFixed(0)}/MT',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.green.shade600,
        fontSize: isSmallScreen ? 12 : 14,
      ),
    );
  }

  Widget _buildTaxRateCell(double taxRate, bool isSmallScreen) {
    return Text(
      '${taxRate.toStringAsFixed(1)}%',
      style: TextStyle(
        color: Colors.orange.shade600,
        fontSize: isSmallScreen ? 12 : 14,
        fontWeight: FontWeight.w500,
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Aggregates':
        return Colors.blue;
      case 'Base Materials':
        return Colors.orange;
      case 'Sand':
        return Colors.yellow.shade700;
      case 'Dust':
        return Colors.brown;
      case 'Concrete':
        return Colors.grey;
      default:
        return Colors.purple;
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

  Widget _buildMobileProductList(BuildContext context, List<Product> products, bool isSmallScreen) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildMobileProductCard(context, product, isSmallScreen);
      },
    );
  }

  Widget _buildMobileProductCard(BuildContext context, Product product, bool isSmallScreen) {
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
                _showProductDetails(context, product);
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
                                product.name,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                product.description,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 14,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        _buildStatusChip(product.isActive),
                      ],
                    ),
                    SizedBox(height: 12),
                    _buildProductDetailItem('Category', product.category, Icons.category, isSmallScreen),
                    _buildProductDetailItem('HSN/SAC', product.hsnSacCode, Icons.receipt, isSmallScreen),
                    _buildProductDetailItem('Unit', product.unit, Icons.scale, isSmallScreen),
                    _buildProductDetailItem('Price', '₹${product.price.toStringAsFixed(0)}/MT', Icons.attach_money, isSmallScreen),
                    _buildProductDetailItem('Tax Rate', '${product.taxRate.toStringAsFixed(1)}%', Icons.percent, isSmallScreen),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(product.category).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _getCategoryColor(product.category).withOpacity(0.3)),
                          ),
                          child: Text(
                            product.category,
                            style: TextStyle(
                              color: _getCategoryColor(product.category),
                              fontSize: isSmallScreen ? 10 : 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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

  Widget _buildProductDetailItem(String label, String value, IconData icon, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: isSmallScreen ? 14 : 16, color: Colors.green.shade400),
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
          color: Colors.green.shade400,
          onPressed: () {
            // View product details
          },
          padding: EdgeInsets.all(8),
        ),
        IconButton(
          icon: Icon(Icons.edit, size: isSmallScreen ? 18 : 20),
          color: Colors.orange.shade400,
          onPressed: () {
            _showEditProductDialog(context);
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
        _showAddProductDialog(context);
      },
      backgroundColor: Colors.green.shade400,
      elevation: 8,
      child: Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => _buildProductDetailsDialog(context, product),
    );
  }

  Widget _buildProductDetailsDialog(BuildContext context, Product product) {
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
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.inventory_2, color: Colors.green.shade400, size: 28),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 4),
                        _buildStatusChip(product.isActive),
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
              _buildProductDetailRow('Description', product.description, Icons.description),
              _buildProductDetailRow('Category', product.category, Icons.category),
              _buildProductDetailRow('HSN/SAC Code', product.hsnSacCode, Icons.receipt),
              _buildProductDetailRow('Unit', product.unit, Icons.scale),
              _buildProductDetailRow('Price', '₹${product.price.toStringAsFixed(0)} per MT', Icons.attach_money),
              _buildProductDetailRow('Tax Rate', '${product.taxRate.toStringAsFixed(1)}%', Icons.percent),
              _buildProductDetailRow('Created Date', _formatDate(product.createdAt), Icons.calendar_today),
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
                      _showEditProductDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                    ),
                    child: Text('Edit Product', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Colors.green.shade400),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildProductDialog(context, 'Add Product', null),
    );
  }

  void _showEditProductDialog(BuildContext context) {
    final sampleProduct = ProductData.getProducts().first;
    showDialog(
      context: context,
      builder: (context) => _buildProductDialog(context, 'Edit Product', sampleProduct),
    );
  }

  Widget _buildProductDialog(BuildContext context, String title, Product? product) {
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
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      product == null ? Icons.add : Icons.edit,
                      color: Colors.green.shade400,
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
              _buildTextField('Product Name', product?.name),
              SizedBox(height: 16),
              _buildTextField('Description', product?.description, maxLines: 2),
              SizedBox(height: 16),
              _buildDropdownField('Category', product?.category, ProductData.getCategories()),
              SizedBox(height: 16),
              _buildTextField('HSN/SAC Code', product?.hsnSacCode),
              SizedBox(height: 16),
              _buildDropdownField('Unit', product?.unit, ProductData.getUnits()),
              SizedBox(height: 16),
              _buildNumberField('Price (₹)', product?.price.toString()),
              SizedBox(height: 16),
              _buildNumberField('Tax Rate (%)', product?.taxRate.toString()),
              SizedBox(height: 16),
              _buildSwitchField('Active Product', product?.isActive ?? true),
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
                      backgroundColor: Colors.green.shade400,
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
          borderSide: BorderSide(color: Colors.green.shade400),
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
          borderSide: BorderSide(color: Colors.green.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      controller: initialValue != null ? TextEditingController(text: initialValue) : null,
      keyboardType: TextInputType.number,
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
          borderSide: BorderSide(color: Colors.green.shade400),
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
          activeColor: Colors.green.shade400,
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
        content: Text('Are you sure you want to delete this product? This action cannot be undone.'),
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