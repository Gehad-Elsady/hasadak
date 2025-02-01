// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/add-services/model/service-model.dart';
import 'package:hasadak/Screens/cart/cart-screen.dart';
import 'package:hasadak/Screens/cart/model/cart-model.dart';
import 'package:hasadak/Screens/cart/widget/cartitem.dart';
import 'package:hasadak/Screens/history/historyscreen.dart';
import 'package:hasadak/Screens/history/model/historymaodel.dart';
import 'package:hasadak/notifications/notification_back.dart';
import 'package:hasadak/paymob/paymob_manager.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen(
      {super.key, required this.totalPrice, required this.historymaodel});
  InAppWebViewController? _webViewController;
  final double totalPrice;
  HistoryModel? historymaodel;
  ServiceModel? serviceModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          PaymobManager()
              .getPaymentKey(totalPrice, "EGP")
              .then((String paymentKey) {
            _webViewController?.loadUrl(
              urlRequest: URLRequest(
                url: WebUri(
                  "https://accept.paymob.com/api/acceptance/iframes/845444?payment_token=$paymentKey",
                ),
              ),
            );
          });
        },
        onLoadStop: (controller, url) {
          if (url != null && url.queryParameters.containsKey('success')) {
            if (url.queryParameters['success'] == 'true') {
              FirebaseFunctions.orderHistory(historymaodel!);
              List<CartModel>? items = historymaodel?.items;
              for (int i = 0; i < items!.length; i++) {
                NotificationBack.sendPlacedOrderNotification(items[i].userId!);
              }
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Payment Done"),
                    actions: [
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pushNamed(context, HistoryScreen.routeName);
                        },
                      ),
                    ],
                  );
                },
              );
              print("Payment Done");
            } else if (url.queryParameters['success'] == 'false') {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Payment Failed"),
                    actions: [
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pushNamed(context, CartScreen.routeName);
                        },
                      ),
                    ],
                  );
                },
              );
              print("Payment Failed");
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text("Payment Canceled"),
                        actions: [
                          TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, CartScreen.routeName);
                              })
                        ]);
                  });
            }
          }
        },
      ),
    );
  }
}
