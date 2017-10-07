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

class StreamingTableViewCell: UITableViewCell {
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer : AVPlayer?
    
    var videoInfo : VideoInfo? {
        didSet {
            guard let videoName = videoInfo?.videoName else { return }
            guard let videoDescription = videoInfo?.videoDescription else { return }
            guard let videoUrl = videoInfo?.videoUrl else { return }
        }
    }
    
    
    @IBOutlet weak var videoNameLabel: UILabel!
    
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
