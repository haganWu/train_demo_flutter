//
//  Contacter.swift
//  TrainDemo-IOS
//
//  Created by 吴海恒 on 2023/9/7.
//

import Contacts

class Contacter:NSObject, Codable {
    @objc var contactName = ""
    @objc var contactNumber = ""
    
    @objc func getName() -> String {
        return self.contactName
    }
    @objc func getPhone() -> String {
        return self.contactNumber
    }
}
