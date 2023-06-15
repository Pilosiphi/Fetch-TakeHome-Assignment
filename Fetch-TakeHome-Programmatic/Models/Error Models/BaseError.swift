//
//  BaseError.swift
//  Fetch-TakeHome
//
//  Created by Phil Pilosi on 6/10/23.
//

import Foundation

class BaseError: Error {
    let title: String
    let message: String
    
    init(errorTitle: String, errorMessage: String) {
        title = errorTitle
        message = errorMessage
    }
}
