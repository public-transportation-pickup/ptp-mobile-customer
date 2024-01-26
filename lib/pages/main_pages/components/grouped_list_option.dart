import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../order_page.dart';
import '../activity_page.dart';

class GroupedListOption extends StatelessWidget {
  final List<Map<String, dynamic>> elements = [
    {
      'name': 'Cập nhật thông tin cá nhân',
      'group': 'Tài khoản của tôi',
      'page': OrderPage()
    },
    {
      'name': 'Giỏ hàng của tôi',
      'group': 'Tài khoản của tôi',
      'page': ActivityPage()
    },
    {
      'name': 'Lịch sử giao dịch',
      'group': 'Tài khoản của tôi',
      'page': OrderPage()
    },
    {'name': 'Liên kết ví', 'group': 'Tài khoản của tôi', 'page': OrderPage()},
    {
      'name': 'Điểm tích lũy',
      'group': 'Ưu đãi và tích điểm',
      'page': OrderPage()
    },
    {
      'name': 'Thẻ quà tặng',
      'group': 'Ưu đãi và tích điểm',
      'page': OrderPage()
    },
    {'name': 'Trung tâm trợ giúp', 'group': 'Trợ giúp', 'page': OrderPage()},
    {'name': 'Thông tin chung', 'group': 'Trợ giúp', 'page': OrderPage()},
  ];

  GroupedListOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GroupedListView<dynamic, String>(
        elements: elements,
        groupBy: (element) => element['group'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (c, element) {
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: GestureDetector(
              onTap: () {
                // Handle the click event by navigating to the specified page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => element['page'],
                  ),
                );
              },
              child: SizedBox(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 2.0),
                  title: Text(element['name']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
