//
//  MealAPI.swift
//  Fetch-TakeHome
//
//  Created by Phil Pilosi on 6/9/23.
//

//import Foundation
import UIKit

class MealAPI: NSObject {
    static let sharedInstance = MealAPI()
    
    
    public func createMealListRequest(category: String) -> MealAPIProtocol {
        return MealListRequest(mealCategory: category)
    }
    
    public func createMealDetailRequest(mealID: String) -> MealAPIProtocol {
        return MealDetailRequest(mealID: mealID)
    }
    
    //MARK: New Await/Async - Get Meal List and Meal Detail
    public func mealListData(with request: MealAPIProtocol) async throws -> MealListDataModel {
        let response = try await mealData(with: request)
        guard let mealListData = MealListDataModel(withJson: response) else { throw BaseError(errorTitle: "Data error", errorMessage: "Stuff went wrong") }
        return mealListData
    }
    
    public func mealDetailData(with request: MealAPIProtocol) async throws -> MealDetailedInfoDataModel {
        let response = try await mealData(with: request)
        guard let mealDetailData = MealDetailedInfoDataModel(withJson: response) else { throw BaseError(errorTitle: "Data error", errorMessage: "Stuff went wrong") }
        return mealDetailData
    }
    
    //MARK: New Async/Await - MealData
    private func mealData(with currentRequest: MealAPIProtocol) async throws -> Any {
        guard let requestURL = currentRequest.URL else { throw BaseError(errorTitle: "Meal URL Failed", errorMessage: "Failed to read url, please try again.") }
        let request = URLRequest(url: requestURL)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let responseJsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { throw BaseError(errorTitle: "Error", errorMessage: "Try again") }
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw BaseError(errorTitle: "Network error", errorMessage: "Bad resposne, check connection and try again") }
        return responseJsonData
    }
}
