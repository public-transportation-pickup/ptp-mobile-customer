import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar2PointsComponent extends StatelessWidget {
  final TextEditingController startPointController;
  final TextEditingController endPointController;
  final Function() onFilter;

  SearchBar2PointsComponent({
    required this.startPointController,
    required this.endPointController,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 0, right: 8.0, bottom: 8.0, left: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 160,
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
                      'lib/assets/icons/start_search.svg',
                      width: 32,
                      height: 32,
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
                      controller: startPointController,
                      onChanged: (_) => onFilter(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Đi từ...',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: 50,
                  child: Center(
                    child: SvgPicture.asset(
                      'lib/assets/icons/end_search.svg',
                      width: 32,
                      height: 32,
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
                      controller: endPointController,
                      onChanged: (_) => onFilter(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Đến...',
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
