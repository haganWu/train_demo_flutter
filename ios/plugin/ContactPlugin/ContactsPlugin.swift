//
//  ContactsPlugin.swift
//  Runner
//
//  Created by 吴海恒 on 2023/9/19.
//
import Flutter


public class ContactsPlugin: NSObject, FlutterPlugin{
     



    public static func register(with registrar: FlutterPluginRegistrar) {

        
        let methodChannel = FlutterMethodChannel(name: "contacts_plugin", binaryMessenger: registrar.messenger())
        let instance = ContactsPlugin()
        
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "getContacts") {
            getContactsByNative(result: result)
        } else if(call.method == "callTelephone") {
            callTelephone(phoneNumber: call.arguments as! String )
        }
    }
    
    
    func getContactsByNative(result: @escaping FlutterResult) {
        print("Dart端调用Native-IOS方法，Native端onMethodCall触发getContacts")
        DispatchQueue.global().async {
            let contactsList = ContactsPhoneUtil.getContacts()
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(contactsList)
                
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    DispatchQueue.main.sync {
                        print("Native-IOS端获取联系人列表：\(jsonString)")
                        result(jsonString)
                    }
                }
            } catch {
                print("编码为JSON时出错：\(error)")
            }
            
            
            
        }
       
        
    }
    
    func callTelephone(phoneNumber: String) {
        print("Dart端调用Native-IOS方法，Native端onMethodCall触发callTelephone,手机号码：\(phoneNumber)")
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
        
    }


}




