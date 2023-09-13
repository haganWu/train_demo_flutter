import 'package:flutter/services.dart';


/// @author WuHaiheng
/// @date 2023-09-13 15:52
/// @description 原生通讯插件
class ContactsPluginManager {
  static const MethodChannel _channel = MethodChannel("contacts_plugin");

  static Future<String> getContacts() async {
    return await _channel.invokeMethod("getContacts");
  }
}
