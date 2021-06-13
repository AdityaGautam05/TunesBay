//
//  SongDetailedAPIResponseDelegate.swift
//  Songs App
//
//  Created by Aditya Gautam on 08/05/21.
//

import Foundation
import NetworkManager

protocol SongsDetailedAPIResponseDelegate {
    func didFinishGatheringDetailedSongAPIResponse(result: Song)
    func trackPreviewDownloaded(Status : DownloadFileStatus)
    func setTickIcon()
    func showLoader()
    func setUploadIcon()
}
