import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/history/model/historymaodel.dart';
import 'package:hasadak/notifications/notification_back.dart';
import 'package:hasadak/widget/Drawer/mydrawer.dart';
import 'package:intl/intl.dart';

class MyRequestsScreen extends StatefulWidget {
  static const String routeName = 'my_requests_screen';
  const MyRequestsScreen({super.key});

  @override
  _MyRequestsScreenState createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
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
          "Requests",
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
          stream: FirebaseFunctions.getMyRequestStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text("Error loading history: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("history-empty"));
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
                // DateTime now = DateTime.now();
                // Duration timeDiff = now.difference(timestamp);

                // // Show cancel button only if the order was placed within 5 minutes
                // bool enableCancelButton = timeDiff.inMinutes < 5;

                // // Start a timer to refresh the UI after 5 minutes
                // if (enableCancelButton) {
                //   startTimer(Duration(seconds: 300 - timeDiff.inSeconds), () {
                //     setState(() {}); // Trigger a rebuild to refresh the UI
                //   });
                // }

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
                          '${"service-type"}: ${history.orderType ?? 'N/A'}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${"timestamp"}: ${formattedTime}",
                          style: TextStyle(fontSize: 16),
                        ),

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'order-status' + ': ',
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
                                  "${"add-service-name"}: ${history.serviceModel!.name}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${"add-service-description"}: ${history.serviceModel!.description}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  "${"add-service-price"}: ${history.serviceModel!.price}",
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
                                      "Service Name: ${item.serviceModel.name}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Service Description: ${item.serviceModel.description}",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Text(
                                      "Price: ${item.serviceModel.price}",
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

                        // // Display a countdown for cancel eligibility if within 5 minutes
                        // if (enableCancelButton)
                        //   Text(
                        //     "Cancel within ${5 - timeDiff.inMinutes} minutes",
                        //     style: TextStyle(
                        //       color: Colors.red,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        SizedBox(height: 10),
                        history.orderStatus == 'Pending'
                            ? Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("accept-order"),
                                          actions: [
                                            TextButton(
                                              child: Text("yes"),
                                              onPressed: () {
                                                // FirebaseFunctions.deleteHistoryOrder(
                                                //     history.timestamp!);
                                                FirebaseFunctions
                                                    .acceptOrderStatus(
                                                        history.id!,
                                                        'Accepted');
                                                NotificationBack
                                                    .sendAcceptNotification(
                                                        history.userId!);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text("no"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }, // Disable the button if not within the cancellation time
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Complete-order"),
                                              actions: [
                                                TextButton(
                                                  child: Text("yes"),
                                                  onPressed: () {
                                                    // FirebaseFunctions.deleteHistoryOrder(
                                                    //     history.timestamp!);
                                                    FirebaseFunctions
                                                        .acceptOrderStatus(
                                                            history.id!,
                                                            'Completed');
                                                    FirebaseFunctions
                                                        .completOrder(
                                                            history.timestamp!,
                                                            history.userId!);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("no"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }, // Disable the button if not within the cancellation time
                                      child: Text(
                                        "Complete",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("cancel-order"),
                                              actions: [
                                                TextButton(
                                                  child: Text("yes"),
                                                  onPressed: () {
                                                    // FirebaseFunctions.deleteHistoryOrder(
                                                    //     history.timestamp!);
                                                    FirebaseFunctions
                                                        .acceptOrderStatus(
                                                            history.id!,
                                                            'Pending');
                                                    NotificationBack
                                                        .sendDeclinedNotification(
                                                            history.userId!);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("no"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }, // Disable the button if not within the cancellation time
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
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
