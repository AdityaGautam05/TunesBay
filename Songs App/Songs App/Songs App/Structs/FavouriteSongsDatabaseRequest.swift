//
//  DatabaseRequestStruct.swift
//  Songs App
//
//  Created by Aditya Gautam on 13/05/21.
//

import Foundation
import DatabaseManager

struct FavouriteSongsDatabaseRequest : DatabaseRequest {
    var key : String {
        return "FavouriteTrackIDs"
    }
}
