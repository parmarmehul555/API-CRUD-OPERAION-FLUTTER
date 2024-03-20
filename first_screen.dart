import 'dart:convert';

import 'package:crud_evaluation/api_crud/addProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Api CRUD Operation",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddProduct(null);
                })).then(
                  (value) {
                    setState(() {});
                  },
                );
              },
              child: Icon(
                Icons.add,
                size: 40,
              ))
        ],
      ),
      body: FutureBuilder(
        future: getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      snapshot.data![index]['name'].toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                    InkWell(
                        onTap: () async {
                          await deleteProduct(snapshot.data![index]['id']).then(
                            (value) {
                              setState(() {});
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          size: 35,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AddProduct(snapshot.data![index]);
                        })).then(
                          (value) {
                            setState(() {});
                          },
                        );
                      },
                      child: Icon(Icons.edit),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              '${snapshot.error}',
              style: TextStyle(fontSize: 25),
            ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<List<dynamic>> getAll() async {
    var data = await http.get(
        Uri.parse('https://64e2cdb1bac46e480e77c3e5.mockapi.io/faculties'));
    return jsonDecode(data.body);
  }

  Future<void> deleteProduct(id) async {
    await http.delete(
        Uri.parse('https://64e2cdb1bac46e480e77c3e5.mockapi.io/faculties/$id'));
  }
}
