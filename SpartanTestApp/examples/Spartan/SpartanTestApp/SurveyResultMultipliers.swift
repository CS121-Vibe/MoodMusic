//
//  SurveyResultMultipliers.swift
//  SpartanTestApp
//
//  Created by Omari Matthews on 11/23/19.
//  Copyright © 2019 Spotify. All rights reserved.
//

import Foundation

// this function takes in the survey results and outputs a dictionary
// that contains multiplier values for filtering the songs retrieved
// from the survey
func getMultiplierFromSurveyResults(surveyResults: [String]) -> [String: Double] {
    var finalMultiplier = [String: Double]()
    for result in surveyResults {
        let multiplier = getMultiplierFromSurveyResult(result: result)
        finalMultiplier = consolidateMultipliers(baseMultiplier: finalMultiplier, multiplier: multiplier)
    }
    return finalMultiplier
}

// this songs takes the items in `baseMultiplier` and adds them with the items in `multiplier`
func consolidateMultipliers(baseMultiplier: [String: Double], multiplier: [String: Double]) -> [String: Double] {
    var newBaseMultiplier = [String: Double]()
    baseMultiplier.forEach({ (key, value) -> Void in
        newBaseMultiplier[key] = value
    })
    multiplier.forEach({ (key, value) -> Void in
        if newBaseMultiplier[key] == nil {
            newBaseMultiplier[key] = value
        } else {
            newBaseMultiplier[key] = value + (multiplier[key] ?? 0)
        }
    })
    return newBaseMultiplier
}

// this function takes a result from the survey and returns a dictionary of the mutations
// that need to be made to the score multiplier array
func getMultiplierFromSurveyResult(result: String) -> [String: Double] {
    switch result {
    case "Bedroom", "Office":
        return ["energy": -0.5, "danceability": -0.5, "loudness": -0.5, "acousticness": 0.25]
    case "5-10", ">10":
        return ["energy": 1, "danceability": 0.5, "loudness": 0.25]
    case "Calm":
        return ["energy": -1.2, "danceability": -1.5, "loudness": -2.2, "instrumentalness": 1]
    case "Loud":
        return ["energy": 1, "danceability": 0.1, "loudness": 1]
    case "Party":
        return ["energy": 1, "danceability": 2, "loudness": 1.2]
    default:
        return [:]
    }
}
