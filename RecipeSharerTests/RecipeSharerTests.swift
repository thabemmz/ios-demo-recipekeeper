//
//  RecipeSharerTests.swift
//  RecipeSharerTests
//
//  Created by Christiaan van Bemmel on 06/06/2019.
//  Copyright © 2019 Christiaan van Bemmel. All rights reserved.
//

import XCTest
@testable import RecipeSharer

class RecipeSharerTests: XCTestCase {
    func testRecipeSharerInitSucceeds() {
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    func testRecipeSharerInitFails() {
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -5)
        XCTAssertNil(negativeRatingMeal)
        
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
}
