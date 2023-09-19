package com.example.plugin.contacts

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import com.example.plugin.contacts.utils.ContactsPhoneUtils
import com.google.gson.Gson
import com.yanzhenjie.permission.Action
import com.yanzhenjie.permission.AndPermission
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


open class ContactsPlugin(private val activity: Activity) : MethodChannel.MethodCallHandler {

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
            Log.e(tag, "Dart端调用Native-Android方法，Native端onMethodCall触发getContacts")
        } else if (call.method == "callTelephone") {
            callTelephone(call.arguments as String)
            Log.e(tag, "Dart端调用Native-Android方法，Native端onMethodCall触发callTelephone")
        }
    }

    private fun callTelephone(phoneNumber: String) {
        ContactsPhoneUtils.callTelephone(activity, phoneNumber)
    }

    private fun getContactsByNative(result: MethodChannel.Result) {

        val permissions = arrayOf(
            Manifest.permission.CALL_PHONE,
            Manifest.permission.READ_CONTACTS,
        )
        if (checkPermission(permissions)) {
            loadContact(result)
        } else {
            requestPermission(permissions) {
                loadContact(result)
            }
        }
    }

    private fun loadContact(result: MethodChannel.Result) {
        val contactsList = ContactsPhoneUtils.getContactsList(activity)
        val gson = Gson()
        val jsonArray = gson.toJson(contactsList)
        result.success(jsonArray)
    }


    private fun checkPermission(permissions: Array<String>): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            permissions.forEach {
                if (activity.checkSelfPermission(it) != PackageManager.PERMISSION_GRANTED) {
                    return false
                }
            }
        }
        return true
    }


    private fun requestPermission(permission: Array<String>, granted: () -> Unit) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            AndPermission.with(activity).runtime().permission(permission)
                .onGranted(Action { granted() }).start()
        }

    }
}