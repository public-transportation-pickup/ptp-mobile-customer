import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/store_model.dart';
import '../../services/api_services/store_api.dart';
import 'store_info_page.dart';

class ListStoresPage extends StatefulWidget {
  @override
  _ListStoresPageState createState() => _ListStoresPageState();
}

class _ListStoresPageState extends State<ListStoresPage> {
  List<StoreModel> stores = [];

  @override
  void initState() {
    super.initState();
    fetchStores();
  }

  Future<void> fetchStores() async {
    try {
      List<StoreModel> fetchedStores = await StoreApi.getStores();
      setState(() {
        stores = fetchedStores;
      });
    } catch (e) {
      print('Error fetching stores: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cửa hàng đang hoạt động'),
        centerTitle: true,
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
      body: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                'lib/assets/images/store_icon.png',
                width: 36,
                height: 36,
              ),
              title: Text(
                stores[index].name!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${stores[index].addressNo} ${stores[index].street}, ${stores[index].ward}, ${stores[index].zone}",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoreInfoPage(store: stores[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
