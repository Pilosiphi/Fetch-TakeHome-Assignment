//
//  MealDetailedInfoDataModel.swift
//  Fetch-TakeHome
//
//  Created by Phil Pilosi on 6/10/23.
//


/*
 "idMeal": "52893",
 "strMeal": "Apple & Blackberry Crumble",
 "strDrinkAlternate": null,
 "strCategory": "Dessert",
 "strArea": "British",
 "strInstructions": "Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured.\r\nMeanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan.\r\nTo serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream.",
 "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
 "strTags": "Pudding",
 "strYoutube": "https://www.youtube.com/watch?v=4vhcOwVBDO4",
 */
import Foundation
class MealDetailedInfoDataModel: MealDataProtocol, CustomStringConvertible {
    var mealName: String;
    var mealThumbnail: String;
    var mealID: String;
    
    var mealInstructions: String
    var mealYT: String
    
    var mealIngredients: [String]
    var mealIngredientQuantity: [String]
    
    var description: String { return "Meal Detailed Info: \(mealName) \n \(mealInstructions) \n \(mealIngredients) \n \(mealIngredientQuantity)"}
    
    init?(withJson jsonData:Any?) {
        var ingredientList = [String]()
        var measurementList = [String]()
        
        guard let jsonDictionary = jsonData as? [String: Any],
        let mealsArray = jsonDictionary["meals"] as? [[String: Any]],
              let mealData = mealsArray.first else {
            return nil;
        }
        
        guard let mealName = mealData["strMeal"] as? String,
              let mealID = mealData["idMeal"] as? String,
              let mealInstructions = mealData["strInstructions"] as? String
        else {
            return nil
        }
        
        for index in 1...20 {
            let ingredientKey: String = "strIngredient\(index)"
            let measurementKey: String = "strMeasure\(index)"
            guard let currentIngredient = mealData[ingredientKey] as? String else {
                continue;
            }
            guard let currentMeasurement = mealData[measurementKey] as? String else {
                continue
            }
            
            if (!currentIngredient.isEmpty) {
                ingredientList.append(currentIngredient)
            }
            if (!currentMeasurement.isEmpty) {
                measurementList.append(currentMeasurement)
            }
        }
        
        
        self.mealName = mealName
        self.mealID = mealID
        self.mealInstructions = mealInstructions
        
        mealIngredients = ingredientList
        mealIngredientQuantity = measurementList
        
        if let mealThumbnail = mealData["strMealThumb"] as? String {
            self.mealThumbnail = mealThumbnail
        } else {
            self.mealThumbnail = ""
        }
        
        if let mealYT = mealData["strYoutube"] as? String {
            self.mealYT = mealYT
        } else {
            self.mealYT = ""
        }
        
    }
    
}
