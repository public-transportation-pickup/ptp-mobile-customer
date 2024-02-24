import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarByNameComponent extends StatelessWidget {
  final TextEditingController routeName;
  final TextEditingController routeNo;
  final Function() onFilter;

  SearchBarByNameComponent({
    required this.routeName,
    required this.routeNo,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 0, right: 8.0, bottom: 8.0, left: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0xFF909090),
              blurRadius: 10,
              offset: Offset(2, 4),
              spreadRadius: -3,
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: 50,
                  child: Center(
                    child: SvgPicture.asset(
                      'lib/assets/icons/search_icon.svg',
                      width: 32,
                      height: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56),
                      side: const BorderSide(color: Color(0xFFE7E7E7)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: routeName,
                      onChanged: (_) => onFilter(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tìm nhanh',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
