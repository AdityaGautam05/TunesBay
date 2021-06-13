//
//  DBHelper.swift
//  Songs App
//
//  Created by Aditya Gautam on 20/05/21.
//

import Foundation
import DatabaseManager

class DBHelper {
    
    var Error : DatabaseConnectionError?
    var status : SongFavouriteStatus = .none
    
    public static let shared : DBHelper = DBHelper()
    
    func isSongFavourite(trackID : Int) -> (Bool, DatabaseConnectionError?) {
        return DatabaseManager.shared.searchDatainDB(ID: trackID, call: FavouriteSongsDatabaseRequest())
    }
    
    func requestFavouriteSongsFromDB() -> [Int]{
        return DatabaseManager.shared.requestDataFromDB(call: FavouriteSongsDatabaseRequest()).0 ?? []
    }
    
    func addToFavouriteSongsList(trackID : Int) -> Bool{
        (self.status, self.Error) = DatabaseManager.shared.addDataToDB(ID: trackID, call: FavouriteSongsDatabaseRequest())
        if self.status == .addedToFavourites {
            print(trackID as Any, "was added to the favourite list")
            return true
        } else {
            return false
        }
    }
    
    func removeFromFavouriteSongsList(trackID : Int) -> Bool{
        (self.status, self.Error) = DatabaseManager.shared.removeDataFromDB(ID: trackID, call: FavouriteSongsDatabaseRequest())
        if self.status == .removedFromFavourites {
            print(trackID as Any, "was removed from the favourite list")
            return true
        } else {
            return false
        }
    }
    
    func addRecentSearches(search : String, call : RecentSearchDatabaseRequest) -> Bool{
        var array : [String] = []
        let defaults = UserDefaults.standard
        array = defaults.stringArray(forKey: call.key) ?? [String]()
        array.append(search)
        defaults.set(array, forKey: "Recents")
        if array.isEmpty{
            return false
        } else {
            return true
        }
    }
    
    public func retrieveRecentSearches(call : DatabaseRequest) -> [String]{
        let defaults = UserDefaults.standard
        let array = defaults.stringArray(forKey: call.key) ?? [String]()
        return array
    }
    
    func isSongDetailedDataPresentInDB(trackId: Int) -> Bool {
        let array : [Song]
        array = DatabaseManager.shared.retrieveStructDataFromDB(call: DetailedSongDataDatabaseRequest()) ?? []
        if array.isEmpty {
            return false
        }
        var flag : Int = 0
        for i in array {
            if i.trackId == trackId {
                flag = 1
                break
            }
        }
        if flag == 1 {
            return true
        } else {
            return false
        }
    }
    
    func addSongDetailedDataToDB(song : Song) -> Bool {
        return DatabaseManager.shared.addStructDataToDB(structData: song, call: DetailedSongDataDatabaseRequest())
    }
    
    func removeSongDetailedFromDB(StructData : Song) -> Bool{
        var array : [Song] = []
        array = DatabaseManager.shared.retrieveStructDataFromDB(call: DetailedSongDataDatabaseRequest()) ?? []
        if array.isEmpty {
            return false
        }
        var index = 0
        for i in array {
            if i.artistId == StructData.artistId {
                array.remove(at: index)
                index = index + 1
            }
            index = index + 1
        }
        DatabaseManager.shared.addRemovedStructToDB(array : array)
        return true
    }
}
