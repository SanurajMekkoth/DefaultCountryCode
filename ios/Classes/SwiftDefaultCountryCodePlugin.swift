import Flutter
import UIKit
import CoreTelephony


public class SwiftDefaultCountryCodePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "default_country_code", binaryMessenger: registrar.messenger())
    let instance = SwiftDefaultCountryCodePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
      
      channel.setMethodCallHandler { (methodCall, result) in
          if methodCall.method == "detectSIMCountry" {
              
              let networkInfo = CTTelephonyNetworkInfo()
              if #available(iOS 12.0, *) {
                  let carrier = networkInfo.serviceSubscriberCellularProviders?.map({ $0.1 }).first(where: { $0.isoCountryCode != nil })
                  let isoCode = carrier?.isoCountryCode?.uppercased()
                  result(isoCode)
              } else {
                  // Fallback on earlier versions
                  let carrier = networkInfo.subscriberCellularProvider
                  let isoCode = carrier?.isoCountryCode?.uppercased()
                  result(isoCode)
                  
              }
          } else if methodCall.method == "detectNetworkCountry" {
              
              let networkInfo = CTTelephonyNetworkInfo()
              if #available(iOS 12.0, *) {
                  let carrier = networkInfo.serviceSubscriberCellularProviders?.map({ $0.1 }).first(where: { $0.isoCountryCode != nil })
                  let isoCode = carrier?.isoCountryCode?.uppercased()
                  result(isoCode)
              } else {
                  // Fallback on earlier versions
                  let carrier = networkInfo.subscriberCellularProvider
                  let isoCode = carrier?.isoCountryCode?.uppercased()
                  result(isoCode)
                  
              }
          } else if methodCall.method == "detectLocaleCountry" {
              let locale = Locale.current
              result(locale.regionCode)
          }
      }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
