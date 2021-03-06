import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food01.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      // autovalidate: true,
      validator: (String value) {
        if (value.isEmpty || value.length > 5) {
          return 'Title is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
          _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Description is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
          _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Price is required and should be number';
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (String value) {
          _formData['price'] = double.parse(value);
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('submit form');
    print(_formData['title']);
    print(_formData['description']);
    print(_formData['price']);
    print(_formData['image']);
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  children: <Widget>[
                    _buildTitleTextField(),
                    _buildDescriptionTextField(),
                    _buildPriceTextField(),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      child: Text('Save'),
                      textColor: Colors.white,
                      color: Theme.of(context).accentColor,
                      onPressed: _submitForm,
                    )
                  ],
                ))));
  }
}
