import 'package:capstone_ptp/services/mini_map_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'components/route_detail_card.dart';
import 'components/route_detail_tab.dart';

class RouteDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết chuyến'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: MiniMapComponent(),
            ),
          ),
          DraggableScrollableSheet(
            minChildSize: 0.15,
            maxChildSize: 0.9,
            initialChildSize: 0.4,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      RouteCardDetailComponent(),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          color: Colors.white,
                          child: RouteDetailTab()),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
