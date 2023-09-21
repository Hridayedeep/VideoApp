//
//  VideoPlayerVC.swift
//  VideoApp
//
//  Created by Hridayedeep Gupta on 20/09/23.
//

import UIKit
import AVKit

class VideoPlayerVC: UIViewController {

    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var playerItem: AVPlayerItem?
    private var viewModel: ViewModel.Video

    init(viewModel: ViewModel.Video) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        // Check if the video is already cached
        if let localURL = VideoProvider.getLocalURL(for: viewModel.videoUrl) {
            // The video is already cached, so play it
            playVideo(with: localURL)
        } else {
            // The video is not cached, so download it
            downloadVideo()
        }
    }

    private func downloadVideo() {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.downloadTask(with: viewModel.videoUrl) { (location, response, error) in
            guard error == nil, let location = location else {
                // Handle the error
                print("Error downloading video: \(error!.localizedDescription)")
                return
            }

            // Save the video to local disk
            if let localURL = VideoProvider.saveToDisk(location: location, response: response) {
                // The video has been saved, so play it
                DispatchQueue.main.async {
                    self.playVideo(with: localURL)
                }
            } else {
                // Failed to save the video, so handle the error
                print("Error saving video to local disk")
            }
        }
        task.resume()
    }

    func playVideo(with url: URL) {
        self.playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: self.playerItem!)
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.playerLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(self.playerLayer!)
        self.player?.play()
    }
}
