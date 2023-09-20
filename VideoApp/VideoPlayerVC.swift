//
//  VideoPlayerVC.swift
//  VideoApp
//
//  Created by Hridayedeep Gupta on 20/09/23.
//

import UIKit
import AVKit

class VideoPlayerVC: UIViewController {

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    private var containerView: UIView!

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
        setupContainerView()
        downloadAndCacheVideoIfNeeded()
    }

    private func setupContainerView() {
        containerView = UIImageView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func downloadAndCacheVideoIfNeeded() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let cachedVideoURL = documentsDirectory.appendingPathComponent(viewModel.videoUrl.pathExtension)
        if FileManager.default.fileExists(atPath: cachedVideoURL.path) {
            playVideoFromCache(cachedVideoURL)
        } else {
            downloadAndCacheVideo(cachedVideoURL)
        }
    }

    func playVideoFromCache(_ videoURL: URL) {
        DispatchQueue.main.async {
            self.player = AVPlayer(url: videoURL)
            self.playerLayer = AVPlayerLayer(player: self.player)
            self.playerLayer?.frame = self.containerView.bounds
            self.containerView.layer.addSublayer(self.playerLayer!)
            self.player?.play()
        }
    }

    func downloadAndCacheVideo(_ cachedVideoURL: URL) {
        let downloadTask = URLSession.shared.downloadTask(with: viewModel.videoUrl) { (url, response, error) in
            guard let sourceURL = url else { return }
            do {
                try FileManager.default.moveItem(at: sourceURL, to: cachedVideoURL)
                print("Video downloaded and cached at: \(cachedVideoURL)")
                self.playVideoFromCache(cachedVideoURL)
            } catch {
                print("Error caching video: \(error)")
            }
        }
        downloadTask.resume()
    }

}
