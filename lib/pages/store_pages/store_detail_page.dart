import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/store_model.dart';

import '../../services/api_services/store_api.dart';
import 'components/list_product_component.dart';
import 'components/product_card_component.dart';
import 'components/store_detail_card.dart';

class StoreDetailPage extends StatefulWidget {
  final String storeId;

  StoreDetailPage({required this.storeId});

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  late Future<StoreModel> _storeFuture;

  @override
  void initState() {
    super.initState();
    _storeFuture = StoreApi.getStoreById(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Thông tin cửa hàng'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                            store.imageURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 120,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16.0),
                          child: StoreDetailCard(
                            storeName: store.name,
                            description: store.description,
                            phone: store.phoneNumber,
                            fullAddress:
                                "${store.addressNo} ${store.street}, ${store.ward}, ${store.zone}",
                            openTime: store.openedTime,
                            closeTime: store.closedTime,
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
                      "Menu dành cho bạn: ",
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
                            products: [
                              // Add your products based on your API response
                              Product(
                                name: 'Product 1',
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/capstone-ptp.appspot.com/o/assets%2FStoreImages%2Fhouse1.jpg?alt=media&token=10999e68-8be9-448a-97a6-0e05ed349d51',
                                price: 80000,
                              ),
                              Product(
                                name:
                                    '2 Gà Giòn Vui Vẻ + 2 Mì Ý siêu to khổng lồ',
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/capstone-ptp.appspot.com/o/assets%2FStoreImages%2Fhouse1.jpg?alt=media&token=10999e68-8be9-448a-97a6-0e05ed349d51',
                                price: 229000,
                              ),
                              Product(
                                name:
                                    '2 Gà Giòn Vui Vẻ + 2 Mì Ý vừa+ 1 Khoai tây chiên xù quành tánh',
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/capstone-ptp.appspot.com/o/assets%2FStoreImages%2Fhouse1.jpg?alt=media&token=10999e68-8be9-448a-97a6-0e05ed349d51',
                                price: 1250000,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 8, 8, 0),
                    child: Text(
                      "Burger: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
