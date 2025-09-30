// product_model.dart
class Product {
  final String id;
  final String name;
  final String description;
  final String hsnSacCode;
  final String category;
  final String unit;
  final double price;
  final double taxRate;
  final bool isActive;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.hsnSacCode,
    required this.category,
    required this.unit,
    required this.price,
    required this.taxRate,
    required this.isActive,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      hsnSacCode: json['hsnSacCode'],
      category: json['category'],
      unit: json['unit'],
      price: (json['price'] as num).toDouble(),
      taxRate: (json['taxRate'] as num).toDouble(),
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'hsnSacCode': hsnSacCode,
      'category': category,
      'unit': unit,
      'price': price,
      'taxRate': taxRate,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class ProductData {
  static List<Product> getProducts() {
    return [
      Product(
        id: '1',
        name: '20mm Aggregate',
        description: 'High quality 20mm coarse aggregate for construction',
        hsnSacCode: '2517',
        category: 'Aggregates',
        unit: 'MT',
        price: 850.0,
        taxRate: 18.0,
        isActive: true,
        createdAt: DateTime(2024, 1, 15),
      ),
      Product(
        id: '2',
        name: '40mm Aggregate',
        description: 'Large size 40mm aggregate for heavy construction',
        hsnSacCode: '2517',
        category: 'Aggregates',
        unit: 'MT',
        price: 780.0,
        taxRate: 18.0,
        isActive: true,
        createdAt: DateTime(2024, 1, 20),
      ),
      Product(
        id: '3',
        name: 'GSB (Granular Sub-base)',
        description: 'Granular sub-base material for road construction',
        hsnSacCode: '2517',
        category: 'Base Materials',
        unit: 'MT',
        price: 650.0,
        taxRate: 18.0,
        isActive: true,
        createdAt: DateTime(2024, 2, 1),
      ),
      Product(
        id: '4',
        name: 'River Sand',
        description: 'Fine river sand for plastering and concrete work',
        hsnSacCode: '2505',
        category: 'Sand',
        unit: 'MT',
        price: 1200.0,
        taxRate: 18.0,
        isActive: true,
        createdAt: DateTime(2024, 2, 10),
      ),
      Product(
        id: '5',
        name: 'Stone Dust',
        description: 'Fine stone dust for filling and construction',
        hsnSacCode: '2517',
        category: 'Dust',
        unit: 'MT',
        price: 550.0,
        taxRate: 18.0,
        isActive: true,
        createdAt: DateTime(2024, 2, 15),
      ),
      Product(
        id: '6',
        name: 'WMM (Wet Mix Macadam)',
        description: 'Wet mix macadam for road base courses',
        hsnSacCode: '2517',
        category: 'Base Materials',
        unit: 'MT',
        price: 950.0,
        taxRate: 18.0,
        isActive: false,
        createdAt: DateTime(2024, 3, 1),
      ),
    ];
  }

  static List<String> getCategories() {
    return ['Aggregates', 'Base Materials', 'Sand', 'Dust', 'Concrete', 'Blocks'];
  }

  static List<String> getUnits() {
    return ['MT', 'KG', 'CFT', 'CUM', 'BRASS', 'BAG'];
  }
}