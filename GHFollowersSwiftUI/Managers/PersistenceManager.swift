//
//  PersistenceManager.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 14/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}


enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        // Get the saved favourites (if they exist)
        retreiveFavourites { result in
            switch result {
            case .success(let favourites):
                var retrievedFavourites = favourites
                switch actionType {
                case .add: // If they're adding, check the favourite doesn't already exist
                    guard !retrievedFavourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    // Add to the favourites array (in memory)
                    retrievedFavourites.append(favourite)
                case .remove: // If they're removing, remove the favourite from the local memory array
                    retrievedFavourites.removeAll { $0.login == favourite.login }
                }
                // Save the array from memory to user defaults.
                completed(save(favourites: favourites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retreiveFavourites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        // Check to see if we already have favourites data saved, if not, return an empty array as the success result type.
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        // If we're here, we have stored favourites data which we need to decode and return
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(followers))
        } catch {
            completed(.failure(.unableToFavourite))
        }
    }
    
    
    static func save(favourites: [Follower]) -> GFError? {
        // We need to encode the object to data and then save to defaults.
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToFavourite
        }
        
    }
}
