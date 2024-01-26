import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class GroupedListOption extends StatelessWidget {
  // Initialize the elements list here
  final List<Map<String, String>> elements = [
    {'name': 'Cập nhật thông tin cá nhân', 'group': 'Tài khoản của tôi'},
    {'name': 'Giỏ hàng của tôi', 'group': 'Tài khoản của tôi'},
    {'name': 'Lịch sử giao dịch', 'group': 'Tài khoản của tôi'},
    {'name': 'Liên kết ví', 'group': 'Tài khoản của tôi'},
    {'name': 'Điểm tích lũy', 'group': 'Ưu đãi và tích điểm'},
    {'name': 'Thẻ quà tặng', 'group': 'Ưu đãi và tích điểm'},
    {'name': 'Trung tâm trợ giúp', 'group': 'Trợ giúp'},
    {'name': 'Thông tin chung', 'group': 'Trợ giúp'},
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
        // itemComparator: (item1, item2) =>
        //     item1['name'].compareTo(item2['name']),
        //order: GroupedListOrder.ASC,
        //useStickyGroupSeparators: true,
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
            child: SizedBox(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                //leading: const Icon(Icons.account_circle),
                title: Text(element['name']!),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}
