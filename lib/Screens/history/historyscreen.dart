import 'dart:async'; // For Timer
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/history/model/historymaodel.dart';
import 'package:hasadak/widget/Drawer/mydrawer.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = 'history';
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // A method to periodically check for expired time and refresh the UI
  void startTimer(Duration duration, void Function() onTimeout) {
    Timer(
        duration, onTimeout); // After the time passes, the callback is executed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF56ab91),
        title: Text(
          'history'.tr(),
          style: GoogleFonts.domine(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF56ab91),
              Color(0xFF14746f),
            ],
          ),
        ),
        child: StreamBuilder<List<HistoryModel>>(
          stream: FirebaseFunctions.getHistoryStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                  'error_loading_history'.tr(
                    namedArgs: {'error': snapshot.error.toString()},
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                  'no_history_found'.tr(),
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ));
            }

            final historyList = snapshot.data!;
            return ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final history = historyList[index];

                // Handling null timestamp with a fallback
                DateTime timestamp = history.timestamp != null
                    ? DateTime.fromMillisecondsSinceEpoch(history.timestamp!)
                    : DateTime.now();
                DateTime now = DateTime.now();
                Duration timeDiff = now.difference(timestamp);

                // Show cancel button only if the order was placed within 5 minutes
                bool enableCancelButton = timeDiff.inMinutes < 5;

                // Start a timer to refresh the UI after 5 minutes
                if (enableCancelButton) {
                  startTimer(Duration(seconds: 300 - timeDiff.inSeconds), () {
                    setState(() {}); // Trigger a rebuild to refresh the UI
                  });
                }

                String formattedTime = DateFormat('yyyy-MM-dd HH:mm a')
                    .format(timestamp.toLocal());

                return Card(
                  color: Colors.blue,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'service_type'.tr()}: ${history.orderType ?? 'N/A'}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${'timestamp'.tr()}: $formattedTime',
                          style: TextStyle(fontSize: 16),
                        ),

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${'order_status'.tr()}: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              history.orderStatus == 'Pending'
                                  ? TextSpan(
                                      text: history.orderStatus,
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  : TextSpan(
                                      text: history.orderStatus,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                      ),
                                    )
                            ],
                          ),
                        ),

                        // Display Quick Order data
                        if (history.serviceModel != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${'service_name'.tr()}: ${history.serviceModel!.name}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${'service_description'.tr()}: ${history.serviceModel!.description}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  "${'price'.tr()}: ${history.serviceModel!.price}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.network(
                                  history.serviceModel!.image,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),

                        // Display Cart Order data
                        if (history.items != null && history.items!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: history.items!.map((item) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${'service_name'.tr()}: ${item.serviceModel.name}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "${'service_description'.tr()}: ${item.serviceModel.description}",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Text(
                                      "${'price'.tr()}: ${item.serviceModel.price}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Image.network(
                                      item.serviceModel.image,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),

                        SizedBox(height: 10),

                        // Display a countdown for cancel eligibility if within 5 minutes
                        if (enableCancelButton)
                           Text(
                            'cancel_within_minutes'.tr(
                              namedArgs: {'minutes': (5 - timeDiff.inMinutes).toString()},
                            ),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: enableCancelButton
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('confirm_cancel_order'.tr()),
                                          content: Text('confirm_cancel_message'.tr()),
                                          actions: [
                                            TextButton(
                                              child: Text('yes'.tr()),
                                              onPressed: () {
                                                FirebaseFunctions
                                                    .deleteHistoryOrder(
                                                        history.timestamp!);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('no'.tr()),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                : null, // Disable the button if not within the cancellation time
                            child: Text(
                              'cancel'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
