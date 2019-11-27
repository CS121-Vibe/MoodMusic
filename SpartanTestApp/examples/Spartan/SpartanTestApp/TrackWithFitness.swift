//
//  TrackWithFitness.swift
//  SpartanTestApp
//
//  Created by Omari Matthews on 11/20/19.
//  Copyright © 2019 Spotify. All rights reserved.
//

import Foundation
import Spartan



public class TrackWithFitness : Comparable {
    
    public var track: AudioFeaturesObject
    public var fitness = 0.0
    
    init(track: AudioFeaturesObject) {
        self.track = track
    }
    
    public var description: String { return "\(track.id!): \(fitness)" }
    
    func calculateFitness(multipliers: [String: Double]) {
        fitness += track.danceability! * (multipliers["danceability"] ?? 1.0)
        fitness += track.energy! * (multipliers["energy"] ?? 1.0)
        fitness += Double(track.key!) * (multipliers["key"] ?? 1.0)
        fitness += track.loudness! * -(multipliers["loudness"] ?? 1.0)
        fitness += Double(track.mode!) * (multipliers["mode"] ?? 1.0)
        fitness += track.speechiness! * (multipliers["speechiness"] ?? 1.0)
        fitness += track.acousticness! * (multipliers["acousticness"] ?? 1.0)
        fitness += track.instrumentalness! * (multipliers["instrumentalness"] ?? 1.0)
        fitness += track.liveness! * (multipliers["liveness"] ?? 1.0)
        fitness += track.valence! * (multipliers["valence"] ?? 1.0)
    }
    
    static public func < (lhs: TrackWithFitness, rhs: TrackWithFitness) -> Bool {
        return lhs.fitness < rhs.fitness
    }

    static public func == (lhs: TrackWithFitness, rhs: TrackWithFitness) -> Bool {
        return lhs.fitness == rhs.fitness
    }
    
    
    
}
