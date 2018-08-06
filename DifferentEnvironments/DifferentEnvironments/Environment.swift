//
//  Enviroment.swift
//  DifferentEnvironments
//
//  Created by Nguyen Nam on 7/7/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import Foundation

public enum PlistKey{
    
    case ServerURL
    case Server_Protocol
    
    public func value() -> String{
        switch  self {
        case .ServerURL:
            return "server_url"
        case .Server_Protocol:
            return "https"
        }
    }
}

public struct Environment{
    
    fileprivate var infoDict: [String: Any] {
        get {
            if let dict = Bundle.main.infoDictionary{
                return dict
            }else{
                fatalError("Plist file not found")
            }
        }
    }
    
    public func configuration(plistKey: PlistKey) -> String?{
        return infoDict[plistKey.value()] as? String
    }
    
}
