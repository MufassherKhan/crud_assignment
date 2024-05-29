import 'package:crud_assignment/class/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, this.product});

  final ProductModel? product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product?.productName ?? '';
    _codeTEController.text = widget.product?.productCode ?? '';
    _unitPriceTEController.text = widget.product?.unitPrice ?? '';
    _totalPriceTEController.text = widget.product?.totalPrice ?? '';
    _quantityTEController.text = widget.product?.quantity ?? '';
    _imageTEController.text = widget.product?.image ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          widget.product == null ? 'Add Product' : 'Update Product',
          style: const TextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: "Products' Name",
                    labelText: "Products' Name",
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "Write Your Products' Name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Unit Price',
                    labelText: 'Unit Price',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "Write Your Products' Unit Price";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _codeTEController,
                  decoration: const InputDecoration(
                    hintText: "Products' Code",
                    labelText: "Products' Code",
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "Write Your Products' Code";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "Write Your Products' Quantity";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Total Price', labelText: 'Total Price'),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "Write Your Products' Total Price";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _imageTEController,
                  decoration: const InputDecoration(
                      hintText: 'Image', labelText: 'Image'),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "Set Your Products' Image";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _updateProductInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        _updateProduct();
                      }
                    },
                    child: Text(
                      widget.product == null
                          ? 'Add Product'
                          : 'Update Product',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});

    Map<String, String> inputData = {
      'ProductName': _nameTEController.text,
      'Image': _imageTEController.text,
      'ProductCode': _codeTEController.text,
      'UnitPrice': _unitPriceTEController.text,
      'TotalPrice': _totalPriceTEController.text,
      'Quantity': _quantityTEController.text
    };

    String productUrl = widget.product == null
        ? 'https://crud.teamrabbil.com/api/v1/CreateProduct'
        : 'https://crud.teamrabbil.com/api/v1/UpdateProduct/'
        '${widget.product!.id}';
    Uri uri = Uri.parse(productUrl);
    Response response = await post(uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(inputData));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            widget.product == null
                ? 'Product has been added'
                : 'Product has been updated')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            widget.product == null
                ? 'Adding new product failed! Try again.'
                : 'Update=ing product failed! Try again.')),
      );
    }
  }
  @override
  void dispose() {
    super.dispose();
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _codeTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
  }
}