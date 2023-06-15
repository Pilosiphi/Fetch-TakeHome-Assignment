//
//  MealDataModel.swift
//  Fetch-TakeHome
//
//  Created by Phil Pilosi on 6/10/23.
//

//Sample Meal Data Json:
/*
  "strMeal": "Apam balik",
  "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
  "idMeal": "53049"
 */

import Foundation

class MealDataModel: MealDataProtocol, CustomStringConvertible {
    let mealName: String;
    let mealThumbnail: String;
    let mealID: String;
    
    public var description: String { return "MealDataModel: \(mealName) \n \(mealThumbnail) \n \(mealID) \n"}
    
    init(mealName: String, mealThumbnail: String, mealID: String) {
        self.mealName = mealName
        self.mealThumbnail = mealThumbnail
        self.mealID = mealID
    }
}
