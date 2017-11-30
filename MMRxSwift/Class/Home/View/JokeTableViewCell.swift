//
//  JokeTableViewswift
//  MMRxSwift
//
//  Created by 未央生 on 2017/7/4.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var contentText: UILabel!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var caiBtn: UIButton!
    @IBOutlet weak var dingBtn: UIButton!
    var pictureView: JokePictureView!
    var voiceView: JokeVoiceView!
    var videoView: JokeVideoView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = 17.5
        iconView.clipsToBounds = true
        
        
        pictureView = Bundle.main.loadNibNamed("JokePictureView", owner: nil, options: nil)!.first as! JokePictureView
        contentView.addSubview(pictureView)
        pictureView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.contentText)
            maker.left.equalTo(self.contentText)
            maker.width.equalTo(0)
            maker.height.equalTo(0)
        }
        
        voiceView = Bundle.main.loadNibNamed("JokeVoiceView", owner: nil, options: nil)!.first as! JokeVoiceView
        contentView.addSubview(voiceView)
        voiceView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.contentText)
            maker.left.equalTo(self.contentText)
            maker.width.equalTo(0)
            maker.height.equalTo(0)
        }
        
        videoView = Bundle.main.loadNibNamed("JokeVideoView", owner: nil, options: nil)!.first as! JokeVideoView
        contentView.addSubview(videoView)
        videoView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.contentText)
            maker.left.equalTo(self.contentText)
            maker.width.equalTo(0)
            maker.height.equalTo(0)
        }
    }
    
    var joke: Joke! {
        didSet{
            nameView.text = joke.name
            timeView.text = joke.create_time
            dingBtn.setTitle(String(joke.ding), for: .normal)
            caiBtn.setTitle(String(joke.cai), for: .normal)
            shareBtn.setTitle(String(joke.repost), for: .normal)
            commentBtn.setTitle(String(joke.comment), for: .normal)
            contentText.text = joke.text
            if joke.typeInt == 10 {
                pictureView.joke = joke
                pictureView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentView).offset(joke.pictureFrame.origin.y + 10)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(joke.pictureFrame.width)
                    maker.height.equalTo(joke.pictureFrame.height)
                }
                videoView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                voiceView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                videoView.playBtn.isHidden = true
                voiceView.playBtn.isHidden = true
            }
            else if joke.typeInt == 31 {
                pictureView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                videoView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                voiceView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentView).offset(joke.pictureFrame.origin.y + 10)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(joke.pictureFrame.width)
                    maker.height.equalTo(joke.pictureFrame.height)
                }
                voiceView.imageView.kf.setImage(with: joke.image2Url)
                videoView.playBtn.isHidden = true
                voiceView.playBtn.isHidden = false
            }
            else if joke.typeInt == 41 {
                videoView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentView).offset(joke.pictureFrame.origin.y + 10)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(joke.pictureFrame.width)
                    maker.height.equalTo(joke.pictureFrame.height)
                }
                pictureView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                voiceView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                voiceView.playBtn.isHidden = true
                videoView.playBtn.isHidden = false
                videoView.imageView.kf.setImage(with: joke.image2Url)
            }
            else if joke.typeInt == 29 {
                pictureView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                videoView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                voiceView.snp.remakeConstraints { (maker) in
                    maker.top.equalTo(self.contentText)
                    maker.left.equalTo(self.contentText)
                    maker.width.equalTo(0)
                    maker.height.equalTo(0)
                }
                videoView.playBtn.isHidden = true
                voiceView.playBtn.isHidden = true
            }
            
            iconView.kf.setImage(with: joke.urlProfileImage)
            
        }
    }
}
