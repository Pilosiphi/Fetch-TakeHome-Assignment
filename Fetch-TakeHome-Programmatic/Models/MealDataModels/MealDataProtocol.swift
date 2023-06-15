//
//  MealDataProtocol.swift
//  Fetch-TakeHome
//
//  Created by Phil Pilosi on 6/10/23.
//

import Foundation

protocol MealDataProtocol {
    var mealName: String { get }
    var mealThumbnail: String { get }
    var mealID: String { get }
}
