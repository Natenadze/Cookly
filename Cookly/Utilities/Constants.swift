//
//  Constants.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation

struct APIConstants {
    
    static var supaUrl: String {
        ProcessInfo.processInfo.environment["supabase_url"] ?? ""
    } 
    
    static var supaKey: String {
        ProcessInfo.processInfo.environment["supabase_key"] ?? ""
    }
}
