import 'package:flutter/material.dart';
import './auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  CartItem( document){

    this.name= document['name'];
    this.price = document['price'];
    this.qty =document['qty'];
    this.discount=document['discount'];
  }
   String name;
   int price;
   int qty;
   int discount;
}


class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double total = 0;
  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await widget.auth.signOut();
        widget.onSignOut();
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
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('Total: ' + total.toString()),
        RaisedButton(
          child: Text("Proceed"),
                  splashColor: Colors.blueGrey,
          onPressed: ()  {
            Navigator.of(context).pushNamed("/lastpage");
          },
        )
      ],
    );
    
  }

String _getTotalDouble() {
  // double total=180.0;
  //    String length=Firestore.instance.collection('products').snapshots().length.toString();
  //    int d=int.parse(length);//string to int type
  //    for (int i = 0; i < d; i++) {
  //       //total += getTotalDouble(cartItem[i]);
  //    }
  //    return total.toString();
    
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: StreamBuilder(
          stream: Firestore.instance.collection('cart_items').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading');
            } else {
               double t = 0;
               for(int i=0;i<snapshot.data.documents.length;i++){
                 t+=snapshot.data.documents[i]["price"];
                 print(t);
                 total = t;
               }
            //   setState(() {
            //    total = t; 
            //  });
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext content, int index) {
                    CartItem cartItem = CartItem(snapshot.data.documents[index]);
                    return _buildCartItemListTile(cartItem,context);
                  });
            }
          },
        )),
        _buildSummary(context)
      ],
    );
  }
}

Widget _buildCartItemListTile(CartItem cartItem, BuildContext context) {
  
  return GestureDetector(
    onTap: ()=>{Navigator.of(context).pushNamed('/suggestions')},
      child: Card(
        child: ListTile(
      leading: CircleAvatar(child: Text(cartItem.name[0])),
      title: _buildItemTitle(cartItem), 
    )),
  );
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
      Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text("Total : " + getTotalString(cartItem)),
      ),
      Row(
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text("Discount : " + cartItem.discount.toString() + "%"),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text("Savings: " + getTotalDouble(cartItem)),
          )
        ],
      ),
    ],
  );
  
}

getTotalString(CartItem cartItem) {
   double total = cartItem.qty.toDouble() * cartItem.price;
   return total.toString();
  
}

getTotalDouble(CartItem cartItem)
{
  double savings=(cartItem.qty.toDouble() * cartItem.price)-((.01*cartItem.discount*cartItem.price).toDouble());
  return savings.toString();
}

// List<CartItem> allCartItems = [
//   CartItem(name: 'Isa Tusa', price: 40, qty: 5),
//   CartItem(name: 'Racquel Ricciardi', price: 60, qty: 3),
//   CartItem(name: 'Teresita Mccubbin', price: 47, qty: 8),
//   CartItem(name: 'Teresita Mccubbin', price: 47, qty: 8),
//   CartItem(name: 'Isa Tusa', price: 40, qty: 5),
//   CartItem(name: 'Racquel Ricciardi', price: 60, qty: 3),
//   CartItem(name: 'Teresita Mccubbin', price: 47, qty: 8),
//   CartItem(name: 'Teresita Mccubbin', price: 47, qty: 8),
// ];
