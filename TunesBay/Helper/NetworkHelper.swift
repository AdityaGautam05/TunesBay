//
//  NetworkHelper.swift
//  Songs App
//
//  Created by Aditya Gautam on 21/05/21.
//

import Foundation
import NetworkManager

class NetworkHelper {
    
    public static let shared : NetworkHelper = NetworkHelper()
    func fetchSongData(artistName : String, completionHandler : @escaping ([Song]) -> Void) {
        print("Fetching data from Network")
        var dummy = SongListAPIRequest()
        dummy.url.append(artistName)
        NetworkManager.shared.fetchAPIData(apiCall: dummy) { (response: HomePageAPIResultItem?, error) in
            if let response = response {
                completionHandler(response.results)
            }
            else {
                // HERE you can manage the error
            }
        }
    }
}
