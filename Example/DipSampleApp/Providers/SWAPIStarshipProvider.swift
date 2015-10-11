//
//  SWAPIStarshipProvider.swift
//  Dip
//
//  Created by Olivier Halligon on 10/10/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

struct SWAPIStarshipProvider : StarshipProviderAPI {
    let ws = wsDependencies.resolve(.StarshipWS) as NetworkLayer
    
    func fetchIDs(completion: [Int] -> Void) {
        ws.request("starships") { response in
            do {
                let dict = try response.json() as NSDictionary
                guard let results = dict["results"] as? [NSDictionary] else { throw SWAPIError.InvalidJSON }
                
                // Extract URLs (flatten to ignore invalid ones)
                let urlStrings = results.flatMap({ $0["url"] as? String })
                let ids = urlStrings.flatMap(idFromURLString)
                
                completion(ids)
            }
            catch {
                completion([])
            }
        }
    }
    
    func fetch(id: Int, completion: Starship? -> Void) {
        ws.request("starships/\(id)") { response in
            do {
                let json = try response.json() as NSDictionary
                guard
                    let name = json["name"] as? String,
                    let model = json["model"] as? String,
                    let manufacturer = json["manufacturer"] as? String,
                    let crewStr = json["crew"] as? String, crew = Int(crewStr),
                    let passengersStr = json["passengers"] as? String, passengers = Int(passengersStr),
                    let pilotIDStrings = json["pilots"] as? [String]
                    else {
                        throw SWAPIError.InvalidJSON
                }
                
                let ship = Starship(
                    name: name,
                    model: model,
                    manufacturer: manufacturer,
                    crew: crew,
                    passengers: passengers,
                    pilotIDs: pilotIDStrings.flatMap(idFromURLString)
                )
                completion(ship)
            }
            catch {
                completion(nil)
            }
        }
    }
}