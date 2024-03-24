import 'package:capstone_ptp/services/local_variables.dart';
import 'package:flutter/material.dart';
import '../../services/api_services/user_api.dart';

class UpdateProfilePage extends StatefulWidget {
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
    try {
      // Update user profile using the provided data
      await UserApi.updateUserProfile(
        userId: userId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
      );
      // Optionally, you can display a success message or navigate back to the previous screen
      print('User profile updated successfully');
    } catch (e) {
      // Handle error updating user profile
      print('Error updating user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Full Name'),
                  TextField(
                    onChanged: (value) {
                      fullName = value;
                    },
                    controller: TextEditingController(text: fullName),
                  ),
                  SizedBox(height: 20.0),
                  Text('Phone Number'),
                  TextField(
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    controller: TextEditingController(text: phoneNumber),
                  ),
                  SizedBox(height: 20.0),
                  Text('Date of Birth'),
                  SizedBox(height: 10.0),
                  InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: dateOfBirth,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          dateOfBirth = selectedDate;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 10.0),
                          Text(
                            '${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Call function to update user profile
                      updateUserProfile();
                    },
                    child: Text('Update Profile'),
                  ),
                ],
              ),
            ),
    );
  }
}
