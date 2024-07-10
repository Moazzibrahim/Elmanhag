import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: redcolor),
              onPressed: () {
                Navigator.of(context).pop();

                // Handle back button action
              },
            ),
            title: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/tefl.png'),
                  radius: 20,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اهلا بك محمد',
                      style: TextStyle(
                        color: redcolor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'الصف الرابع لغات',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: redcolor,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: redcolor,
                  labelStyle: TextStyle(
                    fontSize: 18.sp,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14.sp,
                  ),
                  tabs: const [
                    Tab(
                      text: 'الطالب',
                    ),
                    Tab(text: 'ولي الامر'),
                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              StudentTabContent(),
              ParentTabContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentTabContent extends StatelessWidget {
  const StudentTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'محمد احمد',
                    icon: Icons.person,
                  ),
                  CustomTextField(
                    hintText: 'الصف الرابع',
                    icon: Icons.grade,
                  ),
                  CustomTextField(
                    hintText: 'لغات',
                    icon: Icons.language,
                  ),
                  CustomTextField(
                    hintText: 'مصر',
                    icon: Icons.flag,
                  ),
                  CustomTextField(
                    hintText: 'الاسكندريه',
                    icon: Icons.location_city,
                  ),
                  CustomTextField(
                    hintText: '01558744425',
                    icon: Icons.phone,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: SaveButton(),
        ),
      ],
    );
  }
}

class ParentTabContent extends StatelessWidget {
  const ParentTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'ابراهيم محمد',
                    icon: Icons.person,
                  ),
                  CustomTextField(
                    hintText: '0121111125',
                    icon: Icons.phone,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: SaveButton(),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;

  const CustomTextField(
      {super.key, required this.hintText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: redcolor,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: redcolor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: redcolor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: redcolor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          shadowColor: Colors.black45,
        ),
        onPressed: () {
          // Handle save button action
        },
        child: Text(
          'حفظ',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
