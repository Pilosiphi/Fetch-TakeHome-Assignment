//
//  MealListDataModel.swift
//  Fetch-TakeHome
//
//  Created by Phil Pilosi on 6/10/23.
//

import Foundation

class MealListDataModel {
    var mealList = [MealDataModel]()
    
    init?(withJson jsonData: Any?) {
        guard let jsonDictionary = jsonData as? [String: Any],
              let mealListData = jsonDictionary["meals"] as? [[String:Any]] else {
            return nil
        }
        
        mealList = parseMealListData(fromJson: mealListData)
    }
    
    private func parseMealListData(fromJson data: [[String: Any]]) -> [MealDataModel] {
        var mealList = [MealDataModel]()
        let mealNameKey = "strMeal"
        let mealThumbKey = "strMealThumb"
        let mealIDKey = "idMeal"
        for mealItem in data {
            
            //Sample Json for MealDataModel
            //"strMeal": "Bakewell tart",
            //"strMealThumb": "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg",
            //"idMeal": "52767"
            guard let mealName = mealItem[mealNameKey] as? String,
                  let mealThumbnail = mealItem[mealThumbKey] as? String,
                  let mealID = mealItem[mealIDKey] as? String else {
                continue
            }
            
            let currentMeal = MealDataModel(mealName: mealName, mealThumbnail: mealThumbnail, mealID: mealID)
            mealList.append(currentMeal)
        }
        
        let sortedMealList = mealList.sorted { (left: MealDataModel, right: MealDataModel) -> Bool in
            return left.mealName.compare(right.mealName, options: .caseInsensitive) == .orderedAscending
        }
        return sortedMealList
    }
    
}
