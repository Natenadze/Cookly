//
//  RecipeService.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation
import Supabase


final class RecipeService:  RecipeProviding {
    
    // MARK: - Properties
    @Injected(\.supaClient) var supaClient: SupabaseClient
    
    // MARK: - Methods
    func generateRecipe(prompt: Prompt) async -> Recipe? {
        var result: Recipe? = nil
        
        do {
            result = try await supaClient.functions
                .invoke(
                    "generate-recipe",
                    options: FunctionInvokeOptions(
                        body: prompt
                    )
                )
        } catch FunctionsError.httpError(let code, let data) {
            print("Function returned code \(code) with response \(String(data: data, encoding: .utf8) ?? "")")
        } catch FunctionsError.relayError {
            print("Relay error")
        } catch {
            print("Other error: \(error.localizedDescription)")
        }
        result?.isSaved = false
        return result
    }
    
}
