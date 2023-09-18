import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:train_demo_flutter/model/contact_model.dart';
import 'package:train_demo_flutter/plugin/contacts_plugin_manager.dart';
import 'package:train_demo_flutter/utils/hi_logger.dart';
import 'package:train_demo_flutter/widgets/contact_item_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter 获取通讯录'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ContactModel> contactList = [];

  get _listView => ListView.builder(
      // 解决ListView数据量较少时无法滑动问题
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: contactList.length,
      itemBuilder: (BuildContext context, int index) => _contactItemWidget(index));

  _contactItemWidget(int index) {
    ContactModel model = contactList[index];
    return ContactItemWidget(model: model, callTelephoneCallback: _callTelephone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            FilledButton(onPressed: getContacts, child: const Text("获取通讯录")),
            Expanded(child: _listView),
          ],
        ));
  }

  void getContacts() {
    HiLogger.log(message: "获取通讯录");
    ContactsPluginManager.getContacts().then((result) {
      HiLogger.log(message: "获取原生通讯录返回结果:$result");
      List<dynamic> jsonList = json.decode(result);
      List<ContactModel> listTemp = [];
      // 遍历 JSON 数据列表并将其转换为自定义 Bean 对象
      for (var jsonMap in jsonList) {
        ContactModel contact = ContactModel.fromJson(jsonMap);
        listTemp.add(contact);
      }
      setState(() {
        contactList.clear();
        contactList.addAll(listTemp);
      });
      HiLogger.log(message: "原生通讯录数据转成成Dart BeanList:$contactList");
    });
  }

  _callTelephone(String phoneNumber) {
    HiLogger.log(message: "拨打电话：$phoneNumber");
    ContactsPluginManager.callTelephone(phoneNumber);
  }
}
