//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import AVFoundation

class QuoteDisplayViewController : UIViewController, AVSpeechSynthesizerDelegate {
    var button: UIButton!
    var speechSynthesizer: AVSpeechSynthesizer!
    var speechUtterance: AVSpeechUtterance!
    var speechSynthesisVoice : AVSpeechSynthesisVoice!

    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view

        let playerItem = createPlayerItem()
        
        player = AVPlayer(playerItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.videoGravity = .resizeAspect
        
        button = UIButton(type: .system)
        button.addTarget(self, action: #selector(startPlaying), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        
        speechSynthesisVoice = AVSpeechSynthesisVoice(language: "en-US")
        
        speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer.delegate = self

        speechUtterance = AVSpeechUtterance(attributedString: attributedText(nil))
        
        speechUtterance.voice = speechSynthesisVoice
        
        view.layer.addSublayer(playerLayer)
        view.addSubview(button)
        
        setupConstraints()
    }
    
    func createPlayerItem() -> AVPlayerItem {
        let videoURL = Bundle.main.url(forResource: "crazy_ones", withExtension: "m4v")!
        
        let asset = AVURLAsset(url: videoURL)
        
        let playerItem = AVPlayerItem(asset: asset)

        return playerItem
//
//
//        let subtitlesURL = Bundle.main.url(forResource: "subtitles", withExtension: "json")!
//        
//        let subtitlesData = try! Data(contentsOf: subtitlesURL)
//
//        let subtitles: [Dictionary<String, Any>] = try! JSONSerialization.jsonObject(with: subtitlesData, options: []) as! [Dictionary<String, Any>]
//
//        let videoURL = Bundle.main.url(forResource: "crazy_ones", withExtension: "m4v")!
//
//        let asset = AVURLAsset(url: videoURL)
//
//        let playerItem = AVPlayerItem(asset: asset)
//
//        let videoTrack = asset.tracks(withMediaType: .video).first!
//
//        let size = videoTrack.naturalSize
//
//        var videoComposition = AVMutableComposition()
//
//        let videoLayer = CALayer()
//
//        videoLayer.frame.size = size
//
//        videoLayer.opacity = 1
//
//        let parentLayer = CALayer()
//
//        parentLayer.addSublayer(videoLayer)
//
//        parentLayer.frame.size = size
//
//        let layerComposition = AVMutableVideoComposition()
//
//        layerComposition.frameDuration = videoTrack.timeRange.duration
//
//        layerComposition.renderSize = size
//
//        var layerInstructions = [AVVideoCompositionInstructionProtocol]()
//
//        for aSubtitleDictionary in subtitles {
//            let compositionVideoTrack = videoComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)!
//
//            let startTimeInterval = CFTimeInterval(aSubtitleDictionary["from"] as! Double)
//
//            let endTimeInterval = CFTimeInterval(aSubtitleDictionary["to"] as! Double)
//
//            let startTime = CMTime(seconds: startTimeInterval, preferredTimescale: 600)
//
//            let endTime = CMTime(seconds: endTimeInterval, preferredTimescale: 600)
//
//            let timeRange = CMTimeRange(start: startTime, end: endTime)
//
//            try! compositionVideoTrack.insertTimeRange(timeRange, of: videoTrack, at: startTime)
//
//            compositionVideoTrack.preferredTransform = videoTrack.preferredTransform
//
//            let label = UILabel()
//
//            let currentText = aSubtitleDictionary["text"] as! String
//
//            label.attributedText = NSAttributedString(string: currentText, attributes: [.font : UIFont.preferredFont(forTextStyle: .caption1)])
//
//            label.sizeToFit()
//
//            parentLayer.addSublayer(label.layer)
//
//            let compositionInstruction = AVMutableVideoCompositionInstruction()
//
//            compositionInstruction.timeRange = timeRange
//
//            let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
//
//            layerInstruction.setTransform(videoTrack.preferredTransform, at: startTime)
//
//            compositionInstruction.layerInstructions = [layerInstruction]
//
//            layerInstructions.append(compositionInstruction)
//        }
//
//        layerComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
//
//        playerItem.videoComposition = layerComposition
//
//        return playerItem
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        playerLayer.frame = view.bounds
    }
    
    @objc func startPlaying() {
        player.play()
        speechSynthesizer.speak(speechUtterance)
    }
    
    func setupConstraints() {
//        textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant : 20).isActive = true
//        textView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant : 80).isActive = true
//        textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant : -20).isActive = true
        
//        button.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -40).isActive = true
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    }
    
    func attributedText(_ highlightedRange: NSRange?) -> NSAttributedString {
        let quoteString = """
Here's to the crazy ones.
The misfits. The rebels.
The troublemakers.
The round pegs in the square holes.
The ones who see things differently.
They're not fond of rules.
And they have no respect for the status quo.
You can quote them, disagree with them, glorify or vilify them.
About the only thing you can't do is ignore them.
Because they change things.
They push the human race forward.
And while some may see them as the crazy ones, we see genius.
Because the people who are crazy enough to think they can change the world, are the ones who do.
"""
        let attributedText = NSMutableAttributedString(string: quoteString, attributes: [.font : UIFont.preferredFont(forTextStyle: .body)])
 
        if let _ = highlightedRange {
            attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: highlightedRange!)
        }

        return attributedText
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = QuoteDisplayViewController()
