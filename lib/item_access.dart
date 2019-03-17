import 'package:flutter/material.dart';
import './layout_type.dart';
import './main_app_bar.dart';

class CartItem {
  CartItem({this.name, this.price, this.qty});
  final String name;
  final String price;
  final int qty;
}

class ListPage extends StatelessWidget implements HasLayoutGroup {
  ListPage({Key key, this.layoutGroup, this.onLayoutToggle}) : super(key: key);
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        layoutGroup: layoutGroup,
        layoutType: LayoutType.list,
        onLayoutToggle: onLayoutToggle,
      ),
      body: Container(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
        itemCount: allCartItems.length,
        itemBuilder: (BuildContext content, int index) {
          CartItem cartItem = allCartItems[index];
          return ItemListTile(cartItem);
        });
  }
}

class ItemListTile extends ListTile {
  ItemListTile(CartItem cartItem)
      : super(
          title: _buildItemTitle(cartItem),
          leading: CircleAvatar(child: Text(cartItem.name[0])),
        );

  static Widget _buildItemTitle(CartItem cartItem) {
    return Column(
      children: <Widget>[
        Text(cartItem.name),
        Row(
          children: <Widget>[
            Text("Price : " + cartItem.price),
            Text("Quantity : " + cartItem.qty.toString())
          ],
        ),
      ],
    );
  }
}

List<CartItem> allCartItems = [
  CartItem(name: 'Maggi', price: '40', qty: 4),
  CartItem(name: 'Racquel Ricciardi', price: '60', qty: 4),
  CartItem(name: 'Teresita Mccubbin', price: 'teresita.mccubbin@me.com'),
  CartItem(name: 'Rhoda Hassinger', price: 'rhoda.hassinger@me.com'),
  CartItem(name: 'Carson Cupps', price: 'carson.cupps@me.com'),
  CartItem(name: 'Devora Nantz', price: 'devora.nantz@me.com'),
  CartItem(name: 'Tyisha Primus', price: 'tyisha.primus@me.com'),
  CartItem(name: 'Muriel Lewellyn', price: 'muriel.lewellyn@me.com'),
  CartItem(name: 'Hunter Giraud', price: 'hunter.giraud@me.com'),
  CartItem(name: 'Corina Whiddon', price: 'corina.whiddon@me.com'),
  CartItem(name: 'Meaghan Covarrubias', price: 'meaghan.covarrubias@me.com'),
  CartItem(name: 'Ulysses Severson', price: 'ulysses.severson@me.com'),
  CartItem(name: 'Richard Baxter', price: 'richard.baxter@me.com'),
  CartItem(name: 'Alessandra Kahn', price: 'alessandra.kahn@me.com'),
  CartItem(name: 'Libby Saari', price: 'libby.saari@me.com'),
];
