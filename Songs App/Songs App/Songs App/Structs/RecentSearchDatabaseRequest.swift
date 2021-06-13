//
//  RecentSearchDatabaseRequest.swift
//  Songs App
//
//  Created by Aditya Gautam on 22/05/21.
//

import Foundation
import DatabaseManager

struct RecentSearchDatabaseRequest : DatabaseRequest {
    var key : String {
        return "Recents"
    }
}
