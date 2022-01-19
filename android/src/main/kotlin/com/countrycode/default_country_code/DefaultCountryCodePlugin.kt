package com.countrycode.default_country_code

import android.content.Context
import android.telephony.TelephonyManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

/** DefaultCountryCodePlugin */
class DefaultCountryCodePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "default_country_code")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "detectSIMCountry") {
            detectSIMCountry(result)
        } else if (call.method == "detectNetworkCountry") {
            detectNetworkCountry(result)
        } else if (call.method == "detectLocaleCountry") {
            detectLocaleCountry(result)
        } else {
            result.notImplemented()
        }
    }


    fun detectSIMCountry(@NonNull result: Result) {
        try {
            val telephonyManager: TelephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val country: String? = telephonyManager.simCountryIso
            if (country == null || country.isEmpty()){
                result.error("SIM_COUNTRY_CODE_ERROR", null, null);
            }else {
                result.success(country.toUpperCase(Locale.ROOT));
            }
        } catch (e: Exception) {
            e.printStackTrace()
            result.error("SIM_COUNTRY_CODE_ERROR", null, null);
        }
    }

    fun detectNetworkCountry(@NonNull result: Result)  {
        try {
            val telephonyManager: TelephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val country: String? = telephonyManager.networkCountryIso
            if (country == null || country.isEmpty()){
                result.error("NETWORK_COUNTRY_CODE_ERROR", null, null);
            }else {
                result.success(country.toUpperCase(Locale.ROOT));
            }
        } catch (e: Exception) {
            e.printStackTrace()
            result.error("NETWORK_COUNTRY_CODE_ERROR", null, null);
        }
    }

    fun detectLocaleCountry(@NonNull result: Result)  {
      try {
            val country: String? = context.resources.configuration.locale.country
            if (country == null || country.isEmpty()){
                result.error("LOCALE_COUNTRY_CODE_ERROR", null, null);
            }else {
                result.success(country.toUpperCase(Locale.ROOT));
            }
        } catch (e: Exception) {
            e.printStackTrace()
            result.error("LOCALE_COUNTRY_CODE_ERROR", null, null);
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
