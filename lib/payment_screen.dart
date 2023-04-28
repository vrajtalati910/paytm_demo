import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:ptm_payment_gateway/text_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String mid = "", orderId = "", amount = "", txnToken = "";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;
  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Card(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  EditText('Merchant ID', mid, onChange: (val) => mid = val),
                  EditText('Order ID', orderId, onChange: (val) => orderId = val),
                  EditText('Amount', amount, onChange: (val) => amount = val),
                  EditText('Transaction Token', txnToken, onChange: (val) => txnToken = val),
                  EditText('Call Back Url', callbackUrl, onChange: (val) => callbackUrl = val),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          activeColor: Theme.of(context).buttonColor,
                          value: isStaging,
                          onChanged: (bool? val) {
                            setState(() {
                              isStaging = val!;
                            });
                          }),
                      const Text("Staging")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          activeColor: Theme.of(context).buttonColor,
                          value: restrictAppInvoke,
                          onChanged: (bool? val) {
                            setState(() {
                              restrictAppInvoke = val!;
                            });
                          }),
                      const Text("Restrict AppInvoke")
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: isApiCallInprogress
                          ? null
                          : () {
                              _startTransaction();
                            },
                      child: const Text('Start Transcation'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Text("Message : "),
                  ),
                  Container(
                    child: Text(result),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startTransaction() async {
    if (txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
    print(sendMap);
    try {
      var response = AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount,
        txnToken,
        callbackUrl,
        isStaging,
        restrictAppInvoke,
        enableAssist,
      );
      response.then((value) {
        print(value);
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = "${onError.message} \n  ${onError.details}";
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }
}
