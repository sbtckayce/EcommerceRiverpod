import 'dart:convert';

class ProductModel {
   String image;
   String id;

   String name;
   double price;
   String description;
   String status;
  
   bool isFavourite;
  int? quantity;
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.status,
    required this.isFavourite,
    this.quantity,
  });
  

  ProductModel copyWith({
    String? image,
    String? id,
    String? name,
    double? price,
    String? description,
    String? status,
    bool? isFavourite,
    int? quantity,
  }) {
    return ProductModel(
      image: image ?? this.image,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      status: status ?? this.status,
      isFavourite: isFavourite ?? this.isFavourite,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'status': status,
      'isFavourite': isFavourite,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      image: map['image'] ,
      id: map['id'] ,
      name: map['name'],
      price: map['price'] ,
      description: map['description'] ,
      status: map['status'] ,
      isFavourite: false ,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(image: $image, id: $id, name: $name, price: $price, description: $description, status: $status, isFavourite: $isFavourite, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.id == id &&
      other.name == name &&
      other.price == price &&
      other.description == description &&
      other.status == status &&
      other.isFavourite == isFavourite &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      description.hashCode ^
      status.hashCode ^
      isFavourite.hashCode ^
      quantity.hashCode;
  }
}
