//
//  SupaClient.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Supabase

final class SupaClient {
    static let supabase = SupabaseClient(
        supabaseURL: APIConstants.supaUrl,
        supabaseKey: APIConstants.supaKey
    )
}
