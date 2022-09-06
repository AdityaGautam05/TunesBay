//
//  SongsListViewModel.swift
//  Songs App
//
//  Created by Aditya Gautam on 06/05/21.
//

import Foundation
import NetworkManager

class SongsListViewModel {
    
    var delegate: SongsListAPIResponseDelegate?
    var artistName : String
    
    init(name : String){
        artistName = name
    }
    
    func viewDidLoad() {
        fetchSongsList(artist: artistName)
    }
    
    private func fetchSongsList(artist : String) {
        NetworkHelper.shared.fetchSongData(artistName : artist) { (response: [Song]) in
            self.didGatherResponse(result: response)
        }
    }
    
    func isSongFavourite(trackID : Int) -> Bool {
        if DBHelper.shared.isSongFavourite(trackID: trackID).0 == true {
            return true
        } else {
            return false
        }
    }
    
    func addToFavouriteSongsList(trackID : Int) -> Bool {
        if DBHelper.shared.addToFavouriteSongsList(trackID: trackID) == true {
            return true
        } else {
            return false
            // couldn't add to the DB
        }
    }
    
    func removeFromFavouriteSongsList(trackID : Int) -> Bool{
        if DBHelper.shared.removeFromFavouriteSongsList(trackID: trackID) == true {
            return true
        } else {
            // couln't remove from the DB
            return false
        }
    }
    
    private func didGatherResponse(result: [Song]){
        delegate?.didFinishGatheringSongsListAPIResponse(result: result)
    }
}
