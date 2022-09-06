//
//  HomePageAPIResponse.swift
//  Songs App
//
//  Created by Aditya Gautam on 06/05/21.
//

import Foundation

struct HomePageAPIResultItem : Decodable {
    let resultCount : Int
    let results : [Song]
}
