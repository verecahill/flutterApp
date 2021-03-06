import 'package:flutter/material.dart';
// import 'product_create.dart';
import 'product_edit.dart';

import 'product_list.dart';

class ProductsAdmin extends StatelessWidget {
  final Function addProduct;
  final Function updateProduct;
  final Function deleteProduct;
  final List<Map<String, dynamic>> products;

  ProductsAdmin(this.addProduct, this.updateProduct, this.deleteProduct, this.products);

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Choose'),
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('All Products'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            drawer: _buildDrawer(context),
            appBar: AppBar(
                title: Text('Manage Product'),
                bottom: TabBar(tabs: <Widget>[
                  Tab(icon: Icon(Icons.create), text: 'Create Product'),
                  Tab(icon: Icon(Icons.list), text: 'My Products'),
                ])),
            body: TabBarView(
              children: <Widget>[
                ProductEditPage(addProduct: addProduct),
                ProductListPage(products, updateProduct)
              ],
            )));
  }
}
