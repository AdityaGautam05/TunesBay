//
//  SongDataDatabaseRequest.swift
//  Songs App
//
//  Created by Aditya Gautam on 20/05/21.
//
import Foundation
import DatabaseManager

struct DetailedSongDataDatabaseRequest : DatabaseRequest {
    var key : String {
        return "Result"
    }
}
