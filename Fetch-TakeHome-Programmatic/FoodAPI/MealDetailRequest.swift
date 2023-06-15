//
//  MealDetailRequest.swift
//  Fetch-TakeHome
//
//  Created by Phil Pilosi on 6/11/23.
//

import Foundation

struct MealDetailRequest: MealAPIProtocol {
    var mealID: String?
    var URL: Foundation.URL? {
        get {
            guard let ID = mealID else {
                return nil
            }
            
            //https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "themealdb.com"
            urlComponents.path = "/api/json/v1/1/lookup.php"
            urlComponents.queryItems = [
                URLQueryItem(name: "i", value: ID)
            ]
            return urlComponents.url
        }
    }
    
    init(mealID: String) {
        self.mealID = mealID
    }
}
