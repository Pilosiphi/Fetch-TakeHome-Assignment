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
        if (category.isEmpty) {
            //TODO: Error messaging
        }
        return MealListRequest(mealCategory: category)
    }
    
    public func createMealDetailRequest(mealID: String) -> MealAPIProtocol {
        if (mealID.isEmpty) {
            //TODO: Error messaging
        }
        return MealDetailRequest(mealID: mealID)
    }
    
    public func getMealListData(with request: MealAPIProtocol, and completion: @escaping (Any?, Error?) -> ()) {
        retrieveMealData(with: request) { (responseData, error) in
            guard let data = responseData,
                  let mealListData = MealListDataModel(withJson: data) else {
                completion(nil, error)
                return
            }
            completion(mealListData, nil)
        }
    }
    
    public func getMealDetailData(with request: MealAPIProtocol, and completion: @escaping (Any?, Error?) -> ()) {
        retrieveMealData(with: request) { (responseData, error) in
            guard let data = responseData,
                  let mealDetailedInfoData = MealDetailedInfoDataModel(withJson: data) else {
                completion(nil, error)
                return
            }
            completion(mealDetailedInfoData, nil)
        }
    }
    
    private func retrieveMealData(with currentRequest: MealAPIProtocol, and completion: @escaping (Any?, Error?) -> ()) {
        let session = URLSession(configuration: .default)
        guard let requestURL = currentRequest.URL else{
            let error = BaseError(errorTitle: "Meal URL Failed", errorMessage: "Failed to read Meal url. Please check your request and try again")
            completion(nil,error)
            return
        }
        let request = URLRequest(url: requestURL)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                let dataTaskError = BaseError(errorTitle: "Network Error", errorMessage: error.localizedDescription)
                completion(nil, dataTaskError)
            } else if let data = data {
                guard let responseJsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                    let jsonError = BaseError(errorTitle: "Data error", errorMessage: "Unable to properly read the data, please try again later.")
                    completion(nil, jsonError)
                    return
                }
                
                completion(responseJsonData, nil)
                return
            }
        }
        task.resume()
    }
}
