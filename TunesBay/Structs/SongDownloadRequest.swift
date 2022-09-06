//
//  SongDownloadRequest.swift
//  Songs App
//
//  Created by Aditya Gautam on 17/05/21.
//

import Foundation
import NetworkManager

struct SongDownloadRequest : DownloadRequest {
    var fileURL: String?
    init (song : String){
        fileURL = song
    }
}
