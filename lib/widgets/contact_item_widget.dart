import 'package:flutter/material.dart';
import 'package:train_demo_flutter/model/contact_model.dart';

//定义回调
typedef OnClickCallTelephoneCallback = Function(String phoneNumber);

class ContactItemWidget extends StatelessWidget {
  final ContactModel model;
  final OnClickCallTelephoneCallback callTelephoneCallback;

  const ContactItemWidget({super.key, required this.model, required this.callTelephoneCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(model.contactName!, style: const TextStyle(fontSize: 16, color: Colors.black)),
          Text(model.contactNumber!, style: const TextStyle(fontSize: 16, color: Colors.black)),
          InkWell(
            onTap: () {
              callTelephoneCallback(model.contactNumber!);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 12, top: 4, right: 12, bottom: 4),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(6)),
              child: const Text("拨打", style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
