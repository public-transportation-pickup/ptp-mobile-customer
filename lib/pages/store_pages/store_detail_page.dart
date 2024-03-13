import 'package:flutter/material.dart';
import 'components/list_product_component.dart';
import 'components/product_card_component.dart';
import 'components/store_detail_card.dart';

class StoreDetailPage extends StatelessWidget {
  // Sample data, replace with your actual data
  final String storeName = "Jollibee - TTTM Coopmart Xa Lộ Hà Nội";
  final String description =
      "Thực đơn Jollibee đa dạng và phong phú, có rất nhiều sự lựa chọn cho bạn, gia đình và bạn bè.";
  final String phone = "+1234567890";
  final String fullAddress =
      "191 Quang Trung, Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh";
  final String openTime = "9:00 AM";
  final String closeTime = "6:00 PM";
  // Add other necessary fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Detail'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: StoreDetailCard(
                  storeName: storeName,
                  description: description,
                  phone: phone,
                  fullAddress: fullAddress,
                  openTime: openTime,
                  closeTime: closeTime,
                ),
              ),
              const SizedBox(
                height: 40,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Menu this time: "),
                ),
              ),
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
                            Product(
                              name:
                                  '1 Mì ý sốt bò bằm lớn + 1 Miếng Gà Giòn Vui Vẻ',
                              imageUrl:
                                  'https://firebasestorage.googleapis.com/v0/b/capstone-ptp.appspot.com/o/assets%2FStoreImages%2Fhouse1.jpg?alt=media&token=10999e68-8be9-448a-97a6-0e05ed349d51',
                              price: 80000,
                            ),
                            Product(
                              name: 'Product 2',
                              imageUrl:
                                  'https://firebasestorage.googleapis.com/v0/b/capstone-ptp.appspot.com/o/assets%2FStoreImages%2Fhouse1.jpg?alt=media&token=10999e68-8be9-448a-97a6-0e05ed349d51',
                              price: 229000,
                            ),
                            Product(
                              name:
                                  '1 Mì ý sốt bò bằm lớn + 1 Miếng Gà Giòn Vui Vẻ',
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
                  padding: EdgeInsets.all(8.0),
                  child: Text("Menu this time: "),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
