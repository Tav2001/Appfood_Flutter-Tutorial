import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_product_screen.dart';
import 'admin_product_list_tile.dart';
import 'products_manager.dart';

import '../shared/admin_drawer.dart';

class AdminProductsScreen extends StatelessWidget{
  static const routeName= '/user-products';

  const AdminProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context){
    final productsManager = ProductsManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Products'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 255, 237, 205),
      drawer: const AdminDrawer(),

      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: buildUserProductListView(),
          );
        },
      ),
    );
  }

  Widget buildUserProductListView(){
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              AdminProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: (){
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }
}