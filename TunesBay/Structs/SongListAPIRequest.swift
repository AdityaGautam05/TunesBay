//
//  SongListAPIRequestStruct.swift
//  Songs App
//
//  Created by Aditya Gautam on 12/05/21.
//

import Foundation
import NetworkManager

struct SongListAPIRequest : APIRequest {
    var httpMethod : HTTPRequestMethod = .get
    var url : String = "https://itunes.apple.com/search?term="
    var postBody: [String]? = nil
    var params : [String]? = nil
}
