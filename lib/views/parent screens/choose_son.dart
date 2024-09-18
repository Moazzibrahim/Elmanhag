import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/parent/get_children_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/parent%20screens/home_parent_screen.dart';
import 'package:provider/provider.dart';

class ChooseSon extends StatefulWidget {
  const ChooseSon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChooseSonState createState() => _ChooseSonState();
}

class _ChooseSonState extends State<ChooseSon> {
  int? selectedIndex; // To keep track of which card is selected

  @override
  void initState() {
    super.initState();
    // Delay the fetchChildren call until after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetChildrenProvider>(context, listen: false)
          .fetchChildren(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Consumer<LoginModel>(// Use Consumer to get login data
            builder: (context, loginProvider, child) {
          return Center(
            child: Text(
              'اهلا بك ${loginProvider.name}', // Use the logged-in user's name
              style: const TextStyle(
                color: redcolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<GetChildrenProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.errorMessage != null) {
              return Center(
                child: Text(provider.errorMessage!),
              );
            }

            final children = provider.childrenResponse?.children ?? [];
            if (children.isEmpty) {
              return const Center(
                child: Text('No children available'),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: children.length,
                    itemBuilder: (context, index) {
                      final child = children[index];
                      return Column(
                        children: [
                          UserCard(
                            name: child!.name!,
                            grade: child.category?.name ?? 'No Grade Available',
                            imageUrl: child.imageLink,
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
                if (selectedIndex !=
                    null) // Show the button only if a card is selected
                  Consumer<LoginModel>(
                    builder: (context, loginprovider, child) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            final selectedChild = children[selectedIndex!];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeParentScreen(
                                  childname: selectedChild!.name!,
                                  childcategory: selectedChild.category?.name ??
                                      'No Category Available',
                                  imagelnk: selectedChild.imageLink,
                                  childcity: selectedChild.city!.name,
                                  childcountry: selectedChild.country!.name,
                                  childeducation: selectedChild.education?.name,
                                  emailchild: selectedChild.email,
                                  phonechild: selectedChild.phone,
                                  parentname: loginprovider.name,
                                  childid: selectedChild.id,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 16),
                            backgroundColor: redcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            localizations.translate('next'),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String grade;
  final String? imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.name,
    required this.grade,
    this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        color: isSelected
            ? Colors.red[100]
            : Colors.white, // Change color if selected
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                backgroundImage: imageUrl != null
                    ? NetworkImage(imageUrl!)
                    : const AssetImage('assets/images/Memoji.png')
                        as ImageProvider, // Load the image from the URL
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: redcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    grade,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
