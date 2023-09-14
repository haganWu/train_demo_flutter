package com.example.train

import com.example.plugin.contacts.ContactsPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        //flutter sdk >= v1.17.0 时使用下面方法注册自定义plugin
        ContactsPlugin.registerWith(this, flutterEngine.dartExecutor.binaryMessenger)
        super.configureFlutterEngine(flutterEngine)
    }
}
