/*
 * @Author: Joe.Chen
 * @Date: 2025-03-12 18:10:09
 * @LastEditors: Joe.Chen joechen@tracle-tw.com
 * @LastEditTime: 2025-03-14 16:22:22
 * @Description: 
 */
import 'package:flutter/material.dart';

// 宣告一個 Product 類別，並且設定一個 name 的屬性
class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = void Function(Product product, bool inCart);

// 顯示商品名稱的元件
class ShoppingListItem extends StatelessWidget {
  ///  建構子，不能使用 const ，因為 key 是從 ObjectKey 來的，抽取 product
  ///  
  ShoppingListItem({ 
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }): super(key: ObjectKey(product));

  // final 副
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if(!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({
    required this.products,
    super.key
  });

  final List<Product> products;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shopping = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if(inCart) {
        _shopping.add(product);
      } else {
        _shopping.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shopping.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
  
}

// 主程式進入點，沒有的話會無法 build 
void main() {
  runApp(
    const MaterialApp(
      title: 'Shopping App',
      home: ShoppingList(
        products: <Product>[
          Product(name: 'Eggs'),
          Product(name: 'Flour'),
          Product(name: 'Chocolate chips'),
        ],
      ),
    )
  );
}