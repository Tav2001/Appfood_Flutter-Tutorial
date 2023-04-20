import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_food/ui/cart/cart_screen.dart';
import 'package:app_food/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import '../shared/app_drawer.dart';

import '../cart/cart_manager.dart';
import '../products/top_right_badge.dart';

enum FilterOptions { favorites, all }

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({super.key});

  @override
  State<IntroduceScreen> createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyFood'),
        actions: <Widget>[
          buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 255, 237, 205),
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: const Text(
              'INTRODUCE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30.0,
                fontFamily: "DancingScript",
                color: Color.fromARGB(255, 251, 106, 2),
              ),
            ),
          ),
          CarouselSlider(
            items: [
              //Image 1
              Container(
                margin: EdgeInsets.all(6.0),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://img.meta.com.vn/Data/image/2020/03/04/cach-lam-khoai-tay-chien-bang-noi-chien-khong-dau-3.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //Image 2
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://pizzalove.vn/wp-content/uploads/2020/03/pizza-ngon-tai-hai-phong.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //Image 3
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://media.istockphoto.com/id/583848484/vi/anh/c%C3%A1nh-g%C3%A0-chi%C3%AAn-gi%C3%B2n-cay.jpg?s=612x612&w=0&k=20&c=0pRVSgqf1sbqU94fNFBCDxQy_uGahoJKTqChwSOHspU="),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://bizweb.dktcdn.net/100/339/225/files/thuc-an-nhanh.jpg?v=1627638748869"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 280.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 8,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.7,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {},
            child: Text('✔ 100% nguyên liệu sạch và đảm bảo chất lượng',
                style: TextStyle(fontSize: 15)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {},
            child: Text('✔ Quy trình chế biến được giám sát nghiêm ngặt',
                style: TextStyle(fontSize: 15)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {},
            child: Text('✔ Hợp tác với nhiều đơn vị vận chuyển uy tín',
                style: TextStyle(fontSize: 15)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {},
            child: Text('✔ Đặt sự hài lòng của khách hàng lên trên hết',
                style: TextStyle(fontSize: 15)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {},
            child: Text('✔ Đã và đang nhận được sự quan tâm của người dùng',
                style: TextStyle(fontSize: 15)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {},
            child: Text('✔ Chi nhánh có tại Tp. HCM, Cần Thơ và các tỉnh...',
                style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorites) {
            _showOnlyFavorites.value = true;
          } else {
            _showOnlyFavorites.value = false;
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}
