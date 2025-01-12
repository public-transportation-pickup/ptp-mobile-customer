import 'package:capstone_ptp/models/product_in_menu_model.dart';
import 'package:capstone_ptp/pages/product_pages/cart_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:capstone_ptp/services/api_services/cart_api.dart';
import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/store_model.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/category_model.dart';
import '../../services/api_services/store_api.dart';
import '../main_pages/page_navigation.dart';
import '../product_pages/cart_page.dart';
import '../product_pages/product_detail_page.dart';
import 'components/list_product_component.dart';
import 'components/list_product_with_category.dart';
import 'components/store_detail_card.dart';

class StoreDetailPage extends StatefulWidget {
  final String storeId;
  final String stationId;
  final String arrivalTime;

  StoreDetailPage(
      {required this.storeId,
      required this.arrivalTime,
      required this.stationId});

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  late Future<StoreModel> _storeFuture;
  DateTime now = DateTime.now();
  List<CategoryModel>? listCategories = [];
  List<ProductInMenu>? listProductsInMenu = [];

  @override
  void initState() {
    super.initState();
    _storeFuture = StoreApi.getStoreById(widget.storeId);
    CartProvider.stationId = widget.stationId;
    CartProvider.arrivalTime = widget.arrivalTime;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkSameStore(widget.storeId);
    });
  }

  void checkSameStore(String storeId) {
    if (CartProvider.storeId == "") {
      CartProvider.storeId = storeId;
    } else {
      if (storeId != CartProvider.storeId) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                // Handle tapping outside the dialog
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Close current page
                return true; // Prevent dialog from closing automatically
              },
              child: AlertDialog(
                title: const Text(
                  "Bạn muốn đặt món ở cửa hàng này?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                content: const Text(
                  "Bạn có thể tiếp tục đặt món ở cửa hàng này, nhưng những món bạn đã chọn từ cửa hàng trước sẽ bị xóa khỏi giỏ hàng nhé.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Close current page
                    },
                    child: const Text(
                      'Không',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // clear cart
                      Provider.of<CartProvider>(context, listen: false)
                          .clearCart();
                      CartApi.deleteCart();
                      CartProvider.storeId = storeId;
                      CartProvider.stationId = widget.stationId;
                      CartProvider.arrivalTime = widget.arrivalTime;
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Tiếp tục',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        return;
      }
    }
  }

  void updateCategories(List<CategoryModel>? categories) {
    setState(() {
      listCategories = categories ?? [];
    });
  }

  void updateProductsInMenu(List<ProductInMenu>? products) {
    setState(() {
      listProductsInMenu = products ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Thông tin cửa hàng'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _storeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            StoreModel store = snapshot.data as StoreModel;
            return buildStoreDetail(store);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        backgroundColor: Colors.amber,
        heroTag: null,
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Stack(
              children: [
                if (cartProvider.itemCount == 0)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeContent: Text(
                      cartProvider.itemCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    showBadge: false,
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                if (cartProvider.itemCount > 0)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeContent: Text(
                      cartProvider.itemCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildStoreDetail(StoreModel store) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Store Detail SizeBox
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Stack(
                    children: [
                      Positioned(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          child: Image.network(
                            store.imageURL!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16.0),
                          child: StoreDetailCard(
                            storeName: store.name!,
                            description: store.description!,
                            phone: store.phoneNumber!,
                            fullAddress:
                                "${store.addressNo} ${store.street}, ${store.ward}, ${store.zone}",
                            openTime: store.openedTime!,
                            closeTime: store.closedTime!,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: SizedBox(
                          width: 100.0,
                          height: 40.0,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.orange,
                            onPressed: () {
                              // Navigate to HomePage and close all previous pages
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageNavigation()),
                                (route) => false,
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.home, color: Colors.white),
                                SizedBox(width: 5.0),
                                Text('Trang chủ',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 8, 8, 0),
                    child: Text(
                      "Thực đơn dành cho bạn: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                // List menu component
                LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: ListProductComponent(
                            storeId: widget.storeId,
                            arrivalTime: widget.arrivalTime,
                            now: DateTime.now(),
                            updateCategories: updateCategories,
                            updateProductsInMenu: updateProductsInMenu,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Loop through categories to display products for each category
                for (int i = 0; i < listCategories!.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 8, 8, 0),
                          child: Text(
                            listCategories![i].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                      // List products for this category
                      ...listProductsInMenu!
                          .where((product) =>
                              product.categoryId == listCategories![i].id)
                          .map((product) => ProductWithCategoryCard(
                                product: product,
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                              productId: product.id,
                                            )),
                                  );
                                },
                              ))
                          .toList(),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
