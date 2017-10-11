//
//  StreamingTableViewCell.swift
//  g-erms
//
//  Created by Jae Kee Li on 10/6/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

protocol StreamingTableViewCellDelegate: class {
    func videoButtonPressedWithUrl(videoPost: VideoInfo)
}

class StreamingTableViewCell: UITableViewCell {
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer : AVPlayer?
    
    var videoUrlName = ""
    var videoPost : VideoInfo?
    weak var delegate: StreamingTableViewCellDelegate?
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    @IBOutlet weak var videoPlayButton: UIButton!
    
    @IBOutlet weak var videoNameLabel: UILabel!
    
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    @IBAction func videoButtonPressed(_ sender: Any) {
        if delegate != nil,
            let post = videoPost {
            delegate?.videoButtonPressedWithUrl(videoPost: post)
        }
    }
    
    @IBOutlet weak var videoImageView: UIImageView!
    
    
}
