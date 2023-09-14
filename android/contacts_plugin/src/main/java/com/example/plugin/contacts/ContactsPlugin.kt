package com.example.plugin.contacts

import android.app.Activity
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

open class ContactsPlugin(val activity: Activity) : MethodChannel.MethodCallHandler {

    private val tag = "ContactsPlugin"

    companion object {
        fun registerWith(activity: Activity, messenger: BinaryMessenger) {
            val channel = MethodChannel(messenger, "contacts_plugin")
            val instance = ContactsPlugin(activity)
            channel.setMethodCallHandler(instance)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "getContacts") {
            getContactsByNative(result)
            Log.e(tag,"Dart端调用Native方法，Native端onMethodCall触发")
        }
    }

    private fun getContactsByNative( result: MethodChannel.Result) {

        result.success("返回给Dart联系人数据")
    }
}