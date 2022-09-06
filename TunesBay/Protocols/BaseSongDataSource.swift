//
//  BaseSongDataSource.swift
//  Songs App
//
//  Created by Aditya Gautam on 20/05/21.
//

import Foundation

protocol BaseSongDataSource {
    var shouldMakeNetworkCall : Bool { get set }
    func fetchSongData(trackID : Int, completionHandler : @escaping (Song) -> Void)
}
