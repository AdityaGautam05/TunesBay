//
//  Song.swift
//  Songs App
//
//  Created by Aditya Gautam on 06/05/21.
//

import Foundation

public struct Song : Codable {
    let wrapperType: String?
    let kind : String?
    let artistId : Int?
    let collectionId : Int?
    let trackId : Int
    let artistName : String?
    let collectionName : String?
    let trackName : String?
    let collectionCensoredName : String?
    let trackCensoredName : String?
    let artistViewUrl : String?
    let collectionViewUrl : String?
    let trackViewUrl : String?
    let previewUrl : String?
    let artworkUrl30 : String?
    let artworkUrl60 : String?
    let artworkUrl100 : String?
    let collectionPrice : Float?
    let trackPrice : Float?
    let releaseDate : String?
    let collectionExplicitness : String?
    let trackExplicitness : String?
    let discCount : Int?
    let discNumber : Int?
    let trackCount : Int?
    let trackNumber : Int?
    let trackTimeMillis : Int?
    let country : String?
    let currency : String?
    let primaryGenreName : String?
    let isStreamable : Bool?
    var isEmpty : Bool?
    
    init() {
        wrapperType = ""
        kind = ""
        artistId = 0
        collectionId = 0
        trackId = 0
        artistName = ""
        collectionName = ""
        trackName = ""
        collectionCensoredName = ""
        trackCensoredName = ""
        artistViewUrl = ""
        collectionViewUrl = ""
        trackViewUrl = ""
        previewUrl = ""
        artworkUrl30 = ""
        artworkUrl60 = ""
        artworkUrl100 = ""
        collectionPrice = 0
        trackPrice = 0
        releaseDate = ""
        collectionExplicitness = ""
        trackExplicitness = ""
        discCount = 0
        discNumber = 0
        trackCount = 0
        trackNumber = 0
        trackTimeMillis = 0
        country = ""
        currency = ""
        primaryGenreName = ""
        isStreamable = false
        isEmpty = true
    }
}
