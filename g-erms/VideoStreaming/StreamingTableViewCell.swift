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
    func videoButtonPressedWithUrl(videoUrlName: String)
}

class StreamingTableViewCell: UITableViewCell {
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer : AVPlayer?
    
    var videoUrlName = ""
    weak var delegate: StreamingTableViewCellDelegate?
    
    @IBOutlet weak var videoPlayButton: UIButton!
    
    @IBOutlet weak var videoNameLabel: UILabel!
    
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    @IBAction func videoButtonPressed(_ sender: Any) {
        delegate?.videoButtonPressedWithUrl(videoUrlName: self.videoUrlName)
    }
    
}
