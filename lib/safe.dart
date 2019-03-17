import 'package:flutter/material.dart';
import './auth.dart';

class CartItem {
  CartItem({this.name, this.price, this.qty});
  final String name;
  final double price;
  final int qty;
}

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut,
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)))
        ],
      ),
      body: Container(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('Total: ' + _getTotalString()),
        RaisedButton(
          child: Text("Proceed"),
          onPressed: () => {},
        )
      ],
    );
  }

  String _getTotalString() {
    double total = 0;
    for(int i=0;i<allCartItems.length;i++){
      total+=allCartItems[i].price*allCartItems[i].qty;
    }
    return total.toString();
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: allCartItems.length,
              itemBuilder: (BuildContext content, int index) {
                CartItem cartItem = allCartItems[index];
                return _buildCartItemListTile(cartItem);
              }),
        ),
        _buildSummary()
      ],
    );
  }
}

Widget _buildCartItemListTile(CartItem cartItem) {
  return Card(
      child: ListTile(
    leading: CircleAvatar(child: Text(cartItem.name[0])),
    title: _buildItemTitle(cartItem),
  ));
}

Widget _buildItemTitle(CartItem cartItem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(cartItem.name),
      Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
            child: Text("Price : " + cartItem.price.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Quantity : " + cartItem.qty.toString()),
          )
        ],
      ),
      Text("Total : " + getTotalString(cartItem))
    ],
  );
}

getTotalString(CartItem cartItem) {
  double total = cartItem.qty * cartItem.price;
  return total.toString();
}

List<CartItem> allCartItems = [
  CartItem(name: 'Isa Tusa', price: 40, qty: 5),
  CartItem(name: 'Racquel Ricciardi', price: 60, qty: 3),
  CartItem(name: 'Teresita Mccubbin', price: 47, qty: 8),
  CartItem(name: 'Teresita Mccubbin', price: 47, qty: 8),
  CartItem(name: 'Isa Tusa', price: 40, qty: 5),
  CartItem(name: 'Racquel Ricciardi', price: 60, qty: 3),
  CartItem(name: 'Teresita Mccubbin', price: 47, qty: 8),
  CartItem(name: 'Teresita Mccubbin', price: 47, qty: 8),
];
