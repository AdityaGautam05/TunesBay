//
//  HomePageViewModel.swift
//  Songs App
//
//  Created by Aditya Gautam on 22/05/21.
//

import Foundation
import DatabaseManager

class HomePageViewModel {
    
    private var dataSource : BaseSongDataSource
    private var trackID = Int()
    private var songList : [Song] = []
    var delegate : SongsListAPIResponseDelegate?
    
    init(){
        dataSource = DBSongDataSource()
    }
    
    func viewDidLoad(){
        songList = DatabaseManager.shared.retrieveStructDataFromDB(call: DetailedSongDataDatabaseRequest()) ?? []
        if songList.isEmpty == false {
            didGatherResponse()
        }
    }
    
    private func didGatherResponse(){
        delegate?.didFinishGatheringSongsListAPIResponse(result: songList)
    }
}
