//
//  DetailedPageAPIRequestStruct.swift
//  Songs App
//
//  Created by Aditya Gautam on 12/05/21.
//

import Foundation
import NetworkManager

struct DetailedPageAPIRequest : APIRequest {
    var httpMethod : HTTPRequestMethod = .get
    var url : String {
        return "https://itunes.apple.com/lookup?id=\(trackID)"
    }
    var postBody: [String]? = nil
    var params : [String]? = nil
    var trackID : Int
    
    init (ID : Int){
        trackID = ID
    }
}
