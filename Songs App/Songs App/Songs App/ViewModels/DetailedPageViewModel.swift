//
//  DetailedPageViewModel.swift
//  Songs App
//
//  Created by Aditya Gautam on 08/05/21.
//

import Foundation
import DatabaseManager
import NetworkManager
import AudioManager

class DetailedPageViewModel {
    
    var delegate: SongsDetailedAPIResponseDelegate?
    var trackID = Int()
    var song = Song()
    var Error : DatabaseConnectionError?
    var downloadingStatus : DownloadFileStatus = .none
    private var dataSource : BaseSongDataSource
    
    init(ID : Int) {
        self.trackID = ID
        Error = .none
        if DBHelper.shared.isSongDetailedDataPresentInDB(trackId: trackID) == true {
            dataSource = DBSongDataSource()
        } else {
            dataSource = NetworkSongDataSource()
        }
    }
    
    func viewDidLoad() {
        fetchSongDetailedData(trackID: trackID)
        if dataSource.shouldMakeNetworkCall == false {
            delegate?.setTickIcon()
        } else {
            delegate?.showLoader()
            delegate?.setUploadIcon()
        }
    }
    
    func viewWillDisappear(){
        AudioManager.shared.dismissAudioPlayer()
    }
    
    func isSongDetailedDataPresentInDB(trackId: Int) -> Bool {
        return DBHelper.shared.isSongDetailedDataPresentInDB(trackId: trackId)
    }
    
    func fetchSongDetailedData(trackID : Int) {
        dataSource.fetchSongData(trackID : trackID) { (response: Song) in
            self.song.isEmpty = false
            self.song = response;
            self.didGatherResponse(result: self.song)
        }
        song.isEmpty = false
        self.didGatherResponse(result: song)
    }
    
    func addSongDetailedDataToDB(song : Song) -> Bool {
        return DBHelper.shared.addSongDetailedDataToDB(song: song)
    }
    
    func downloadTrackPreview(trackURL : String?){
        downloadingStatus = .inProgress
        guard let URL = trackURL else { return }
        NetworkManager.shared.downloadFile(request: SongDownloadRequest(song: URL)) { downloadStatus in
            guard let DownloadStatus = downloadStatus else { return }
            if DownloadStatus == .successful {
                self.downloadingStatus = .successful
                self.delegate?.trackPreviewDownloaded(Status: DownloadStatus)
            }
        }
    }
    
    private func didGatherResponse(result: Song){
        delegate?.didFinishGatheringDetailedSongAPIResponse(result: result)
    }
}
