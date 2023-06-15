//
//  MealCategoryRequest.swift
//  Fetch-TakeHome
//
//  Created by Phil Pilosi on 6/10/23.
//
import Foundation

struct MealListRequest: MealAPIProtocol {
    var mealCategory: String?
    var URL: Foundation.URL? {
        get {
            guard let category = mealCategory else {
                return nil
            }
            //https://themealdb.com/api/json/v1/1/filter.php?c=CATEGORY
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "themealdb.com"
            urlComponents.path = "/api/json/v1/1/filter.php"
            urlComponents.queryItems = [
                URLQueryItem(name: "c", value: category)
            ]
            
            return urlComponents.url
        }
    }
    
    init(mealCategory: String) {
        self.mealCategory = mealCategory
    }
}


