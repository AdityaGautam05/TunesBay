//
//  NetworkSongDataSource.swift
//  Songs App
//
//  Created by Aditya Gautam on 20/05/21.
//

import Foundation
import NetworkManager

class NetworkSongDataSource : BaseSongDataSource {
    
    var shouldMakeNetworkCall: Bool = true
    
    func fetchSongData(trackID: Int, completionHandler : @escaping (Song) -> Void) {
        print("Fetching data from Network")
        NetworkManager.shared.fetchAPIData(apiCall: DetailedPageAPIRequest(ID: trackID)) { (response: HomePageAPIResultItem?, error) in
            if let response = response, let song = response.results.first {
                completionHandler(song)
            }
            else {
                // Didn't receive response.
            }
        }
    }
}
