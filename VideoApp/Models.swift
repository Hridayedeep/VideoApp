//
//  Models.swift
//  VideoApp
//
//  Created by Hridayedeep Gupta on 20/09/23.
//

import Foundation

struct VideoResult: Codable {
    let videos: [Video]
}

struct Video: Codable {
    let description: String
    let sources: URL
    let subtitle: String
    let thumb: String
    let title: String
}

enum ViewModel {
    struct Video {
        let title: String
        let description: String
        let videoUrl: URL
        let isDownloaded: Bool
    }
}
