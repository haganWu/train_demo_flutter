package com.example.plugin.contacts.utils

import android.util.Log
import com.example.contacts_plugin.BuildConfig

object L {

    private const val TAG: String = "trainDemo"

    fun d(text: String?) {
        if (BuildConfig.DEBUG) {
            text?.let {
                Log.d(TAG, it)
            }
        }
    }

    fun i(text: String?) {
        if (BuildConfig.DEBUG) {
            text?.let {
                Log.i(TAG, it)
            }
        }
    }

    fun e(text: String?) {
        if (BuildConfig.DEBUG) {
            text?.let {
                Log.e(TAG, it)
            }
        }
    }
}