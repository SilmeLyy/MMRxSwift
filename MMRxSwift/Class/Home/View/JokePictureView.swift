//
//  JokePictureView.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/7/5.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class JokePictureView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bigImageBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.gray
    }
    
    var joke: Joke! {
        didSet{
            imageView.kf.setImage(with: joke.image2Url, placeholder: nil, options: [KingfisherOptionsInfoItem.backgroundDecode], progressBlock: nil) { (image, error, cache, url) in
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
                if (image != nil && self.joke.isBigPic) {
                    let height = self.joke.pictureFrame.size.width * (image?.size.height)! / (image?.size.width)!
                    image?.draw(in: CGRect(x: 0, y: 0, width: self.joke.pictureFrame.size.width, height: height))
                    let img = UIGraphicsGetImageFromCurrentImageContext()
                    self.imageView.image = img
                }
                UIGraphicsEndImageContext()
            }

            bigImageBtn.isHidden = !joke.isBigPic
        }
    }
}
