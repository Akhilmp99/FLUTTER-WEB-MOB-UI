// vehicle_model.dart
class Vehicle {
  final String id;
  final String vehicleNumber;
  final String ownerName;
  final String driverName;
  final String driverContact;
  final double capacity;
  final String vehicleType;
  final String insuranceNumber;
  final DateTime insuranceExpiry;
  final DateTime fitnessExpiry;
  final bool isActive;
  final DateTime createdAt;

  Vehicle({
    required this.id,
    required this.vehicleNumber,
    required this.ownerName,
    required this.driverName,
    required this.driverContact,
    required this.capacity,
    required this.vehicleType,
    required this.insuranceNumber,
    required this.insuranceExpiry,
    required this.fitnessExpiry,
    required this.isActive,
    required this.createdAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      vehicleNumber: json['vehicleNumber'],
      ownerName: json['ownerName'],
      driverName: json['driverName'],
      driverContact: json['driverContact'],
      capacity: (json['capacity'] as num).toDouble(),
      vehicleType: json['vehicleType'],
      insuranceNumber: json['insuranceNumber'],
      insuranceExpiry: DateTime.parse(json['insuranceExpiry']),
      fitnessExpiry: DateTime.parse(json['fitnessExpiry']),
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleNumber': vehicleNumber,
      'ownerName': ownerName,
      'driverName': driverName,
      'driverContact': driverContact,
      'capacity': capacity,
      'vehicleType': vehicleType,
      'insuranceNumber': insuranceNumber,
      'insuranceExpiry': insuranceExpiry.toIso8601String(),
      'fitnessExpiry': fitnessExpiry.toIso8601String(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class VehicleData {
  static List<Vehicle> getVehicles() {
    return [
      Vehicle(
        id: '1',
        vehicleNumber: 'MH12AB1234',
        ownerName: 'Rajesh Transport',
        driverName: 'Sanjay Kumar',
        driverContact: '+91 98765 43210',
        capacity: 20.0,
        vehicleType: 'Truck',
        insuranceNumber: 'INS123456789',
        insuranceExpiry: DateTime(2024, 12, 31),
        fitnessExpiry: DateTime(2024, 11, 30),
        isActive: true,
        createdAt: DateTime(2024, 1, 15),
      ),
      Vehicle(
        id: '2',
        vehicleNumber: 'MH14CD5678',
        ownerName: 'Sharma Logistics',
        driverName: 'Vikram Singh',
        driverContact: '+91 87654 32109',
        capacity: 25.0,
        vehicleType: 'Trailer',
        insuranceNumber: 'INS987654321',
        insuranceExpiry: DateTime(2024, 10, 15),
        fitnessExpiry: DateTime(2024, 9, 20),
        isActive: true,
        createdAt: DateTime(2024, 1, 20),
      ),
      Vehicle(
        id: '3',
        vehicleNumber: 'GJ05EF9012',
        ownerName: 'Patel Carriers',
        driverName: 'Ramesh Patel',
        driverContact: '+91 76543 21098',
        capacity: 15.0,
        vehicleType: 'Truck',
        insuranceNumber: 'INS456789123',
        insuranceExpiry: DateTime(2024, 8, 20),
        fitnessExpiry: DateTime(2024, 7, 25),
        isActive: true,
        createdAt: DateTime(2024, 2, 1),
      ),
      Vehicle(
        id: '4',
        vehicleNumber: 'DL01GH3456',
        ownerName: 'Singh Transport',
        driverName: 'Amit Sharma',
        driverContact: '+91 65432 10987',
        capacity: 18.0,
        vehicleType: 'Dumper',
        insuranceNumber: 'INS789123456',
        insuranceExpiry: DateTime(2024, 9, 30),
        fitnessExpiry: DateTime(2024, 8, 15),
        isActive: false,
        createdAt: DateTime(2024, 2, 10),
      ),
      Vehicle(
        id: '5',
        vehicleNumber: 'KA03IJ7890',
        ownerName: 'Bangalore Logistics',
        driverName: 'Kumar Swamy',
        driverContact: '+91 94321 09876',
        capacity: 22.0,
        vehicleType: 'Trailer',
        insuranceNumber: 'INS321654987',
        insuranceExpiry: DateTime(2024, 11, 15),
        fitnessExpiry: DateTime(2024, 10, 20),
        isActive: true,
        createdAt: DateTime(2024, 2, 15),
      ),
      Vehicle(
        id: '6',
        vehicleNumber: 'TN09KL1234',
        ownerName: 'Chennai Transport',
        driverName: 'Sundar Raj',
        driverContact: '+91 83210 98765',
        capacity: 16.0,
        vehicleType: 'Truck',
        insuranceNumber: 'INS654987321',
        insuranceExpiry: DateTime(2024, 7, 25),
        fitnessExpiry: DateTime(2024, 6, 30),
        isActive: true,
        createdAt: DateTime(2024, 3, 1),
      ),
    ];
  }

  static List<String> getVehicleTypes() {
    return ['Truck', 'Trailer', 'Dumper', 'Tipper', 'Container', 'Tanker'];
  }

  static List<String> getCapacityUnits() {
    return ['Tons', 'MT', 'Cubic Meters'];
  }
}