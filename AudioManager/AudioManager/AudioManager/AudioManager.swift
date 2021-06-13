//
//  AudioManager.swift
//  Songs App
//
//  Created by Aditya Gautam on 15/05/21.
//

import Foundation
import AVFoundation

public class AudioManager {
    
    public enum Status {
        case idle
        case playing
        case paused
    }
    
    public static let shared : AudioManager = AudioManager()
    public var audioPlayer : AVAudioPlayer?
    public var status : AudioManager.Status = .idle
    private init(){
        //
    }
    
    public func playTheDownloadedPreview(previewURL : String?) {
        
        guard let preview = previewURL, let audioUrl = URL(string: preview), let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first  else {
            return
        }
        
        // lets create your destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: destinationUrl)
            guard let player = audioPlayer else { return }
            player.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSession.Category.playback)
            // to play music in the background
            player.play()
            status = .playing
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func playFromStart(track : String?){
        AudioManager.shared.playTheDownloadedPreview(previewURL: track)
        AudioManager.shared.status = .playing
    }
    
    public func dismissAudioPlayer(){
        audioPlayer?.stop()
        status = .idle
    }
    
    public func play(){
        audioPlayer?.play()
        status = .playing
    }
    
    public func pause(){
        audioPlayer?.pause()
        status = .paused
    }
    
    public func currentPlayingTime() -> Double? {
        return audioPlayer?.currentTime
    }
}
