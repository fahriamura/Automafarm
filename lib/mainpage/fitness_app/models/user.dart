

class user {
  final String? id;
  final String fullName;
  final String email;
  final String PoultryName;
  final int PoultryCount;
  final int MaxWater;
  final int MaxFood;

  const user({
    this.id,
    required this.fullName,
    required this.email,
    required this.PoultryName,
    required this.PoultryCount,
    required this.MaxWater,
    required this.MaxFood,
  });

  toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "PoultryName": PoultryName,
      "PoultryCount": PoultryCount,
      "MaxWater": MaxWater,
      "MaxFood": MaxFood,
    };
  }
}
