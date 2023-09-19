//
//  ContactsPhoneUtil.swift
//  TrainDemo-IOS
//
//  Created by 吴海恒 on 2023/9/7.
//


import Contacts

class ContactsPhoneUtil {
    
    static func getContacts() -> Array<Contacter>{
        if(!requestContactPermission()){
            return []
        }
        /*
         CNContactGivenNameKey联系人的名字
         CNContactFamilyNameKey联系人的姓氏
         CNContactPhoneNumbersKey电话号码
         */
        var contactesArray:[Contacter] = Array()
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,CNContactFamilyNameKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        let contactStore = CNContactStore.init()
        
        try?contactStore.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) in
            
            //姓名
            let name = contact.familyName + contact.givenName
            //电话
            let phoneNumbers = contact.phoneNumbers
            for labelValue in phoneNumbers {
                
                let contacter = Contacter.init()
                var phoneNumber = labelValue.value.stringValue
                //对电话号码的数据进行整理
                phoneNumber = phoneNumber.replacingOccurrences(of: "+86", with: "")
                phoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
                phoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
                phoneNumber = phoneNumber.replacingOccurrences(of: "(", with: "")
                phoneNumber = phoneNumber.replacingOccurrences(of: ")", with: "")
                phoneNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
//                print("姓名=\(name), 电话号码是=\(phoneNumber)")
                contacter.contactName = name
                contacter.contactNumber = phoneNumber
                contactesArray.append(contacter)
                
            }
        })

        return contactesArray
    }


    //查看通讯录权限
   static func requestContactPermission() -> Bool{
       
        var isHavePermission = false
        let status = CNContactStore .authorizationStatus(for: .contacts)
        if status == .notDetermined {
            //用户还没有就应用程序是否可以访问联系人数据做出选择。
            //请求弹窗选择
            let store = CNContactStore.init()
            store.requestAccess(for: .contacts) { (granted, error) in
                if (error != nil) {
                   print("授权失败")
                    isHavePermission = false
                }else {
                    //授权成功，访问数据
                    DispatchQueue.main.async {
                        isHavePermission = true
                    }
                }
            }
        }else if status == .restricted {
            //用户没有权限，家长控制这些导致用户没有访问权限
            isHavePermission = false
        }else if status == .denied {
            //用户拒绝访问，引导用户打开通讯录权限
            isHavePermission = false
        }else if status == .authorized {
            //用户已同意访问，访问数据
            isHavePermission = true
        }
       return  isHavePermission
    }
}
