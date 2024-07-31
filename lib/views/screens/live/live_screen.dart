import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/live/history_live_screen.dart';
import 'package:flutter_application_1/views/screens/live/private_live_sceen.dart';
import 'package:flutter_application_1/views/screens/live/up_coming_screen.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    List<String> texts = [
      localizations.translate('upcoming_classes'),
      localizations.translate('previous_classes'),
      localizations.translate('private_classes')
    ];
    List<IconData> icons = [
      Icons.schedule,
      Icons.history,
      Icons.lock,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('live_classes'),
          style: const TextStyle(
              color: redcolor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: texts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to different screens based on the grid item tapped
                switch (index) {
                  case 0:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => const UpComingScreen()),
                    );
                    break;
                  case 1:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => const HistoryLiveScreen()),
                    );
                    break;
                  case 2:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => const PrivateLiveScreen()),
                    );
                    break;
                }
              },
              child: Card(
                color: Colors.white,
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      size: 60,
                      color: redcolor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      texts[index],
                      style: const TextStyle(
                        color: redcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
