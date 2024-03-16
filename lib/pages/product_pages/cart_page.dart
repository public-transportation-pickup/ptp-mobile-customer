import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/product_in_cart_model.dart';
import '../../services/api_services/store_api.dart';
import '../store_pages/components/store_detail_card.dart';
import '../store_pages/store_detail_page.dart';
import 'cart_provider.dart';
import 'components/edit_note_form.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  dynamic _storeDetails;

  @override
  void initState() {
    super.initState();
    _fetchStoreDetails();
  }

  void _fetchStoreDetails() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    if (cartProvider.items.isNotEmpty) {
      final storeDetails = await StoreApi.getStoreById(CartProvider.storeId);
      setState(() {
        _storeDetails = storeDetails;
      });
    }
  }

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return formattedPrice.replaceAll(',', '.');
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final List<ProductInCartModel> items = cartProvider.items;

    final double totalPrice = cartProvider.calculateTotal();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Giỏ hàng của bạn'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.grey[50],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (_storeDetails != null && items.isNotEmpty)
                            StoreDetailCard(
                              storeName: _storeDetails.name,
                              description: _storeDetails.description,
                              phone: _storeDetails.phoneNumber,
                              fullAddress:
                                  "${_storeDetails.addressNo} ${_storeDetails.street}, ${_storeDetails.ward}, ${_storeDetails.zone}",
                              openTime: _storeDetails.openedTime,
                              closeTime: _storeDetails.closedTime,
                            ),
                          if (_storeDetails != null && items.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text(
                                    'Tóm tắt đơn hàng',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoreDetailPage(
                                                arrivalTime:
                                                    CartProvider.arrivalTime,
                                                stationId:
                                                    CartProvider.stationId,
                                                storeId: CartProvider.storeId,
                                              )),
                                    );
                                  },
                                  child: const Text('Thêm món'),
                                ),
                              ],
                            ),
                          if (items.isNotEmpty)
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      color: Colors.red,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      setState(() {
                                        cartProvider
                                            .removeFromCart(items[index]);
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 64,
                                                height: 64,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                    image: items[index]
                                                            .imageURL
                                                            .isNotEmpty
                                                        ? NetworkImage(
                                                            items[index]
                                                                .imageURL)
                                                        : const AssetImage(
                                                                'lib/assets/images/cafe.jpg')
                                                            as ImageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      items[index].productName,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            items[index].note,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            size: 16,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () {
                                                            DialogHelper
                                                                .showEditNoteDialog(
                                                                    context,
                                                                    items[
                                                                        index]);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    formatPrice(items[index]
                                                        .actualPrice),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.remove,
                                                          color:
                                                              Color(0xFFFBAB40),
                                                        ),
                                                        onPressed: () {
                                                          if (items[index]
                                                                  .quantity >
                                                              1) {
                                                            cartProvider
                                                                .updateQuantity(
                                                                    items[
                                                                        index],
                                                                    items[index]
                                                                            .quantity -
                                                                        1);
                                                          }
                                                        },
                                                      ),
                                                      Text(items[index]
                                                          .quantity
                                                          .toString()),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.add,
                                                          color:
                                                              Color(0xFFFBAB40),
                                                        ),
                                                        onPressed: () {
                                                          cartProvider
                                                              .updateQuantity(
                                                                  items[index],
                                                                  items[index]
                                                                          .quantity +
                                                                      1);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (items.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  'Giỏ hàng của bạn đang trống!\nHãy thêm sản phẩm vào giỏ.',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (items.isNotEmpty)
              Card(
                color: const Color(0xFFFEEBBB),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        '*Lấy hàng tại cửa hàng',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng cộng:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${formatPrice(totalPrice)} VND',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle creating order
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFBAB40),
                        ),
                        child: const Text(
                          'Thanh toán và đặt đơn',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
