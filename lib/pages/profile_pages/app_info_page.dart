import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace these placeholders with actual values
    String version = '1.0.1';
    String teamCode = 'GSP24SE47';
    String topicCode = 'SP24SE075';
    String releaseDate = '20 Tháng 4, 2024';
    String companyName = 'FPT University HCM';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin ứng dụng'),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.orange,
              child: const Text(
                'Public Transportation Pickup',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              title: const Text(
                'Phiên bản',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                version,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Ngày phát hành',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                releaseDate,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Mã Nhóm',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                teamCode,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Mã đề tài',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                topicCode,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Phát triển bởi',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                companyName,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
