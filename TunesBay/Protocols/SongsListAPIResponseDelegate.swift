//
//  SongsAPIResponseProtocol.swift
//  Songs App
//
//  Created by Aditya Gautam on 06/05/21.
//

import Foundation

protocol SongsListAPIResponseDelegate {
    func didFinishGatheringSongsListAPIResponse(result: [Song])
}
