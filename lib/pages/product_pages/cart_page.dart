import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/product_in_cart_model.dart';
import '../../services/api_services/store_api.dart';
import '../../utils/global_message.dart';
import '../main_pages/components/confirm_create_order_card.dart';
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
    //await cartProvider.fetchCart();
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
    //final Future<void> cartCurrent = cartProvider.fetchCart();
    final List<ProductInCartModel> items = cartProvider.items;

    final double totalPrice = cartProvider.calculateTotal();

    GlobalMessage globalMessage = GlobalMessage(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Giỏ hàng của bạn'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              if (_storeDetails != null && items.isNotEmpty) {
                cartProvider.saveCart();
              }
              Navigator.pop(context);
            },
          ),
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
                            Card(
                              color: Colors.white,
                              elevation: 2.0,
                              margin: const EdgeInsets.all(10.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Đơn hàng được đặt tại cửa hàng:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: Colors.brown,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      _storeDetails.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'lib/assets/icons/subway_location_icon.svg',
                                          width: 20.0,
                                          height: 20.0,
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Text(
                                            "${_storeDetails.addressNo} ${_storeDetails.street}, ${_storeDetails.ward}, ${_storeDetails.zone}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'lib/assets/icons/store_phone_icon.svg',
                                          width: 20.0,
                                          height: 20.0,
                                          color: Colors.blueAccent,
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Text(
                                            _storeDetails.phoneNumber,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                            ),
                          // ===========================================
                          if (_storeDetails != null && items.isNotEmpty)
                            Card(
                              color: Colors.white,
                              elevation: 2.0,
                              margin: const EdgeInsets.all(10.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'lib/assets/icons/bus_stop_icon.svg',
                                          height: 24,
                                          width: 24,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Trạm đến:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Trạm thủ đức - TEST',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'lib/assets/icons/clock_get_product_icon.svg',
                                          height: 24,
                                          width: 24,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Thời gian có thể đến lấy hàng:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '8:00 21/12/2023 - 12:00 11/11/2024',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          // =====================================================
                          if (_storeDetails != null && items.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                ElevatedButton.icon(
                                  onPressed: () {
                                    HapticFeedback.mediumImpact();
                                    cartProvider.saveCart();
                                  },
                                  icon: const Icon(Icons.save,
                                      color: Colors.white),
                                  label: const Text(
                                    'Lưu',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    HapticFeedback.mediumImpact();
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
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        return const Color(0xFFFBAB40);
                                      },
                                    ),
                                  ),
                                  child: const Text(
                                    'Thêm món',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
                                                            items[index]
                                                                    .note
                                                                    .isEmpty
                                                                ? "Thêm ghi chú"
                                                                : items[index]
                                                                    .note,
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
                                                        onPressed: items[index]
                                                                        .maxQuantity !=
                                                                    null &&
                                                                items[index]
                                                                        .quantity <
                                                                    items[index]
                                                                        .maxQuantity!
                                                            ? () {
                                                                cartProvider.updateQuantity(
                                                                    items[
                                                                        index],
                                                                    items[index]
                                                                            .quantity +
                                                                        1);
                                                              }
                                                            : null,
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
                        onPressed: () async {
                          HapticFeedback.mediumImpact();
                          // Handle confirm button tap
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  contentPadding: EdgeInsets.zero,
                                  content: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Color(0xFFFCCF59),
                                            Color.fromRGBO(255, 255, 255, 0),
                                          ],
                                          stops: [0.0126, 0.6296],
                                          transform: GradientRotation(178.52 *
                                              (3.141592653589793 / 180)),
                                        ),
                                      ),
                                      child: ConfirmCreateOrderCard(
                                        onConfirm: () async {
                                          HapticFeedback.mediumImpact();
                                          // Handle creating order
                                          bool orderCreated = await cartProvider
                                              .createOrderAndClearCart();
                                          Navigator.pop(context);
                                          if (orderCreated) {
                                            setState(() {});
                                            globalMessage.showSuccessMessage(
                                                "Tạo đơn hàng thành công!");
                                          } else {
                                            globalMessage.showErrorMessage(
                                                "Tạo đơn hàng thất bại!");
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
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
