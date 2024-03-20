import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  Map<String, dynamic>? map;

  AddProduct(this.map);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text =
        widget.map == null ? '' : widget.map!['name'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Product"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: nameController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  widget.map == null
                      ? addProduct().then(
                          (value) {
                            Navigator.of(context).pop(true);
                          },
                        ).then(
                          (value) {
                            setState(() {});
                          },
                        )
                      : editProduct().then(
                          (value) {
                            Navigator.of(context).pop(true);
                          },
                        ).then(
                          (value) {
                            setState(() {});
                          },
                        );
                },
                child: InkWell(child: Text("Submit")),),
          ],
        ));
  }

  Future<void> addProduct() async {
    Map<String, dynamic> map = Map();
    map['name'] = nameController.text;
    await http.post(
        Uri.parse('https://64e2cdb1bac46e480e77c3e5.mockapi.io/faculties'),
        body: map);
  }

  Future<void> editProduct() async {
    Map<String, dynamic> map = Map();
    map['name'] = nameController.text;
    await http.put(
        Uri.parse(
            'https://64e2cdb1bac46e480e77c3e5.mockapi.io/faculties/${widget.map!['id']}'),
        body: map);
  }
}
