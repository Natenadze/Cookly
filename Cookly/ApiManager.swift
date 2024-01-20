//
//  ApiManager.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation
import Supabase


final class ApiManager {
    
    // MARK: - Properties
    private let supabase = SupabaseClient(supabaseURL: URL(string: "https://qiddezpmfgryfkylgrhr.supabase.co")!,
                                  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFpZGRlenBtZmdyeWZreWxncmhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU2OTI2OTUsImV4cCI6MjAyMTI2ODY5NX0.LbO6tES0aBySQmlfURoWNnFqmc8cPw978kH7R1KlkXI")
  
    
    // MARK: - Methods
    func registerUser(email: String, password: String) async {
        do {
            try await supabase.auth.signUp(
              email: email,
              password: password
            )
            print("success")
        }catch {
            print("reg error")
        }
        
    }
    
}
