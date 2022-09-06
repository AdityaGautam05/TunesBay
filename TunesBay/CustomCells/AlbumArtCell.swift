//
//  albumArtCell.swift
//  Songs App
//
//  Created by Aditya Gautam on 05/05/21.
//

import UIKit
import AudioManager

class AlbumArtCell: UITableViewCell {
    
    var collectionURL : String = ""
    let artworkImage = UIImageView()
    let mediaControlButton = UIButton()
    var delegate: AlbumArtcellDelegate?
    var slider = UISlider()
    var spinner = UIActivityIndicatorView(style: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(artworkImage)
        artworkImage.translatesAutoresizingMaskIntoConstraints = false
        artworkImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive=true
        artworkImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive=true
        artworkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive=true
        artworkImage.heightAnchor.constraint(equalToConstant: contentView.bounds.width + 40).isActive=true
        artworkImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive=true
        
        contentView.addSubview(mediaControlButton)
        mediaControlButton.translatesAutoresizingMaskIntoConstraints = false
        mediaControlButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive=true
        mediaControlButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive=true
        mediaControlButton.widthAnchor.constraint(equalToConstant: 30).isActive=true
        mediaControlButton.heightAnchor.constraint(equalToConstant: 30).isActive=true
        setPlayButton()
        
        contentView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive=true
        spinner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive=true
        spinner.widthAnchor.constraint(equalToConstant: 30).isActive=true
        spinner.heightAnchor.constraint(equalToConstant: 30).isActive=true
        spinner.color = .black
        
        contentView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints=false
        slider.topAnchor.constraint(equalTo: mediaControlButton.topAnchor, constant: 10).isActive=true
        slider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive=true
        slider.widthAnchor.constraint(equalToConstant: 50).isActive=true
        slider.heightAnchor.constraint(equalToConstant: 50).isActive=true
        slider.tintColor = .black
        slider.isHidden = true
    }
    
    public func enableSlider() {
        if slider.isHidden == true {
            slider.isEnabled=false
            slider.setThumbImage(UIImage(), for: .disabled)
            slider.isHidden = false
        }
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
    
    public func setURLData(urlString : String){
        collectionURL = urlString
        collectionURL.removeLast(13)
        collectionURL.append("\(600)x\(600).jpg")
        artworkImage.load(urlString: collectionURL)
    }
    
    func setPlayButton(){
        mediaControlButton.setImage(UIImage(named: "Play-Button"), for: .normal)
    }
    
    func setPauseButton(){
        mediaControlButton.setImage(UIImage(named: "Pause-Button"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
