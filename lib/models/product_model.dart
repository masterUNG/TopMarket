import 'dart:convert';

class ProductModel {
  // "id": "7",
  final String id;
  //       "category": "แกง",
  final String nameFood;
  //       "nameFood": "แกงผักเซียงดา",
  //  final String id;
  // //       "price": "85",
  //  final String id;
  //  final String id;
  //       "detail": "แกงผักเซียงดา หรือแกงผักเซง มีวิธีการแกงเช่นเดียวกับแกงผักหวานบ้าน และแกงผักหวานป่า แต่ไม่ใส่วุ้นเส้น นิยมใส่ปลาย่าง หรือปลาแห้ง (ประทุม อุ่นศรี, สัมภาษณ์, 25 มิถุนายน 2550) บางสูตรแกงร่วมกับผักเสี้ยวและผักชะอม หรือร่วมกับผักชะอมอย่างเดียว",
  //       "image": "/fluttertraining/food/food7.jpeg"
  final String image;
  
  ProductModel({
    required this.id,
    required this.nameFood,
    required this.image,
  });

  ProductModel copyWith({
    String? id,
    String? nameFood,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      nameFood: nameFood ?? this.nameFood,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameFood': nameFood,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      nameFood: map['nameFood'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProductModel(id: $id, nameFood: $nameFood, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.id == id &&
      other.nameFood == nameFood &&
      other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ nameFood.hashCode ^ image.hashCode;
}
