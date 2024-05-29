class ProductModel {
  String? id;
  String? productName;
  String? image;
  String? productCode;
  String? unitPrice;
  String? totalPrice;
  String? quantity;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    productName = json['ProductName'] ?? 'product Name';
    image = json['Image'] ?? '';
    productCode = json['ProductCode'] ?? 'Product Code';
    unitPrice = json['UnitPrice'] ?? 'Unit Price';
    totalPrice = json['TotalPrice'] ?? 'Total Price';
    quantity  = json['Quantity'] ?? 'quantity';
  }
}