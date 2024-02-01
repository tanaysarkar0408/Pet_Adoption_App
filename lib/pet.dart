class Pet {
  final String id;
  final String name;
  final String category;
  final int age;
  final double price;
  final String imageAssetPath; // Change this line
  bool isAdopted;
  DateTime adoptionDate;

  Pet({
    required this.id,
    required this.name,
    required this.category,
    required this.age,
    required this.price,
    required this.imageAssetPath, // Change this line
    this.isAdopted = false,
    DateTime? adoptionDate,
  }) : this.adoptionDate = adoptionDate ?? DateTime.now();
}
