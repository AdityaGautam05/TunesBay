//
//  DatabaseManager.swift
//  Songs App
//
//  Created by Aditya Gautam on 13/05/21.
//

import Foundation

struct FavouriteSongsDatabaseRequest : DatabaseRequest {
    var key : String {
        return "FavouriteTrackIDs"
    }
}

public class DatabaseManager {
    
    let defaults = UserDefaults.standard
    public static let shared : DatabaseManager = DatabaseManager()
    
    private init(){
        //
    }
    
    public func requestDataFromDB <T>(call : DatabaseRequest) -> ([T]?, DatabaseConnectionError?)
    {
        guard let favouritesongs : [T] = defaults.array(forKey: call.key) as? [T] else {
            defaults.setValue([T](), forKey: call.key)
            return (nil, .resolvingHostUnsuccessful)
        }
        return (favouritesongs, nil)
    }
    
    public func addDataToDB<T>(ID : T, call : DatabaseRequest) -> (SongFavouriteStatus, DatabaseConnectionError?){
        var databaseError : DatabaseConnectionError?
        var favourites : [T]?
        (favourites, databaseError) = requestDataFromDB(call: FavouriteSongsDatabaseRequest())
        favourites?.append(ID)
        self.defaults.set(favourites, forKey: call.key)
        return (.addedToFavourites, databaseError)
    }
    
    public func removeDataFromDB<T:Equatable>(ID : T, call : DatabaseRequest) -> (SongFavouriteStatus, DatabaseConnectionError?){
        var databaseError : DatabaseConnectionError?
        var favourites : [T]?
        (favourites, databaseError) = requestDataFromDB(call: FavouriteSongsDatabaseRequest())
        if let index = favourites?.firstIndex(of: ID) {
            favourites?.remove(at: index)
        }
        self.defaults.set(favourites, forKey: call.key)
        return (.removedFromFavourites, databaseError)
    }
    
    public func searchDatainDB<T:Equatable>(ID : T, call : DatabaseRequest)-> (Bool, DatabaseConnectionError?) {
        guard let favouritesongs : [T] = defaults.array(forKey: call.key) as? [T] else {
            defaults.setValue([T](), forKey: call.key)
            return (false, nil)
        }
        print(favouritesongs)
        var flag = 0
        for i in favouritesongs {
            if i == ID {
                flag = 1
                break
            }
        }
        if flag == 1 {
            return (true, nil)
        } else {
            return (false, nil)
        }
    }
    
    public func retrieveStructDataFromDB <T:Codable>(call : DatabaseRequest) -> [T]? {
        var array : [T] = []
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: call.key) else {
            if let data = try? PropertyListEncoder().encode([T]()) {
                UserDefaults.standard.set(data, forKey: "Result")
            }
            return nil
        }
        do {
            array = try PropertyListDecoder().decode([T].self, from: data)
            return array
        } catch {
            return nil
        }
    }
    
    
    public func addStructDataToDB<T:Codable>(structData : T, call : DatabaseRequest) -> Bool {
        var array = [T]()
        do {
            guard let data = defaults.data(forKey: call.key) else {
                if let data = try? PropertyListEncoder().encode([T]()) {
                    UserDefaults.standard.set(data, forKey: "Result")
                }
                return false
            }
            let dummy = try PropertyListDecoder().decode([T].self, from: data)
            array = dummy
            array.append(structData)
            if let data = try? PropertyListEncoder().encode(array) {
                UserDefaults.standard.set(data, forKey: "Result")
            }
            return true
        } catch {
            return false
        }
    }
    
    public func addRemovedStructToDB<T:Codable>(array : [T]){
        guard let data = try? PropertyListEncoder().encode(array) else { return }
        UserDefaults.standard.set(data, forKey: "Result")
    }
}
