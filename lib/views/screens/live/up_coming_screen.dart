import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class UpComingScreen extends StatefulWidget {
  const UpComingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
  int? _selectedIndex;
  final List<Map<String, String>> _items = List.generate(
      8,
      (index) => {
            'lessonName': 'أنا مميز',
            'time': 'م03:00 - م04:30',
            'cost': index % 2 == 0 ? 'مجانا' : '50 جنيه',
          });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'حصص لايف',
            style: TextStyle(
                color: redcolor, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: redcolor),
            onPressed: () {},
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text('اسم الدرس',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: redcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))),
                  Expanded(
                      // ignore: unnecessary_const
                      child: const Text('المعاد',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: redcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('التكلفة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: redcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color:
                            _selectedIndex == index ? redcolor : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(item['lessonName']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16))),
                          Expanded(
                              child: Text(item['time']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16))),
                          Expanded(
                              child: Text(item['cost']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _selectedIndex == null ? null : () {},
                // ignore: sort_child_properties_last
                child: const Text('احجز الان',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _selectedIndex == null ? Colors.grey : redcolor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
