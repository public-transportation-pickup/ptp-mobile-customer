import 'package:capstone_ptp/services/local_variables.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../services/api_services/user_api.dart';
import '../../utils/global_message.dart';

class UpdateProfilePage extends StatefulWidget {
  UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String userId = LocalVariables.userGUID ?? '';
  String fullName = LocalVariables.fullName ?? '';
  String phoneNumber = LocalVariables.phoneNumber ?? '';
  String localDoB = LocalVariables.dateOfBirth ?? '';
  late DateTime dateOfBirth;

  bool isLoading = true;
  bool isLoadingCircle = false;
  late GlobalMessage globalMessage;

  void _showLoading() {
    setState(() {
      isLoadingCircle = true;
    });
  }

  void _hideLoading() {
    setState(() {
      isLoadingCircle = false;
    });
  }

  void formatDateOfBirth(String localDoB) {
    if (localDoB.isNotEmpty) {
      dateOfBirth = DateTime.parse(localDoB);
    } else {
      dateOfBirth = DateTime.now();
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch user details when the page initializes
    formatDateOfBirth(localDoB);
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      // Retrieve user details using the provided user ID
      final userDetails = await UserApi.getUserDetails(userId);
      setState(() {
        fullName = userDetails['fullName'];
        phoneNumber = userDetails['phoneNumber'];
        dateOfBirth = DateTime.parse(userDetails['dateOfBirth']);
        isLoading = false;
      });
      // Format date of birth after retrieving user details
      formatDateOfBirth(localDoB);
    } catch (e) {
      // Handle error fetching user details
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateUserProfile() async {
    if (_validateInputs()) {
      try {
        _showLoading();
        // Update user profile using the provided data
        await UserApi.updateUserProfile(
          userId: userId,
          fullName: fullName,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
        );
        setState(() {
          _hideLoading();

          LocalVariables.phoneNumber = phoneNumber;
          LocalVariables.fullName = fullName;
          LocalVariables.dateOfBirth = dateOfBirth.toString();
        });
        globalMessage.showSuccessMessage("Cập nhật thành công.");
      } catch (e) {
        _hideLoading();
        globalMessage.showErrorMessage("Cập nhật thất bại.");
      }
    }
  }

  bool _validateInputs() {
    // if (fullName.isEmpty) {
    //   globalMessage.showErrorMessage("Vui lòng nhập họ và tên.");
    //   return false;
    // }
    if (phoneNumber.isEmpty) {
      globalMessage.showErrorMessage("Vui lòng nhập số điện thoại.");
      return false;
    } else {
      if (!isValidPhoneNumber(phoneNumber) || phoneNumber.length < 10) {
        globalMessage.showErrorMessage("Số điện thoại không hợp lệ.");
        return false;
      }
    }

    return true;
  }

  bool isValidPhoneNumber(String value) {
    // Regular expression to match phone number starting with 0 and containing exactly 10 digits
    RegExp regex = RegExp(r'^0\d{9}$');
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    globalMessage = GlobalMessage(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cập nhật thông tin',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFCCF59),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Họ và tên'),
                    TextField(
                      onChanged: (value) {
                        if (value.length <= 20) {
                          fullName = value;
                        }
                      },
                      controller: TextEditingController(text: fullName),
                      maxLength: 20,
                      decoration: InputDecoration(
                        hintText: fullName.isEmpty ? 'Chưa cập nhật' : null,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text('Số điện thoại'),
                    TextField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      controller: TextEditingController(text: phoneNumber),
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: phoneNumber.isEmpty ? 'Chưa cập nhật' : null,
                        errorText: phoneNumber.isNotEmpty &&
                                !isValidPhoneNumber(phoneNumber)
                            ? 'Số điện thoại không hợp lệ'
                            : null,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20.0),
                    const Text('Ngày sinh'),
                    const SizedBox(height: 10.0),
                    InkWell(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: dateOfBirth,
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2008),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            dateOfBirth = selectedDate;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 10.0),
                            Text(
                              '${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        updateUserProfile();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFCCF59)),
                      ),
                      child: const Text(
                        'Cập nhật hồ sơ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoadingCircle)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
            ]),
    );
  }
}
