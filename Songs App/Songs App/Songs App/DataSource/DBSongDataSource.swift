//
//  DBSongDataSource.swift
//  Songs App
//
//  Created by Aditya Gautam on 20/05/21.
//

import Foundation
import DatabaseManager

class DBSongDataSource : BaseSongDataSource {
    
    var shouldMakeNetworkCall: Bool = false
    
    func fetchSongData(trackID: Int, completionHandler: @escaping (Song) -> Void) {
        print("Fetching Data from DB")
        var array : [Song]
        array = DatabaseManager.shared.retrieveStructDataFromDB(call: DetailedSongDataDatabaseRequest()) ?? []
        if array.isEmpty {
            return
        }
        var result : Song
        for i in array {
            if i.trackId == trackID {
                result = i
                completionHandler(result)
                break
            }
        }
    }
}
