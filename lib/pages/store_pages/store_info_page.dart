import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/store_model.dart';

import 'components/store_detail_card.dart';

class StoreInfoPage extends StatelessWidget {
  final StoreModel store;

  StoreInfoPage({required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Info'),
      ),
      body: Center(
        child: SizedBox(
          height: double.infinity,
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
            ],
          ),
        ),
      ),
    );
  }
}
