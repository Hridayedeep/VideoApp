//
//  VideoProvider.swift
//  VideoApp
//
//  Created by Hridayedeep Gupta on 21/09/23.
//

import Foundation

final class VideoProvider {
    class func getLocalURL(for remoteURL: URL) -> URL? {
        // Check if the video file exists in local disk
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filename = remoteURL.lastPathComponent
        let fileURL = documentsDirectory.appendingPathComponent(filename)

        if fileManager.fileExists(atPath: fileURL.path) {
            // The video file exists in local disk
            return fileURL
        }
        // The video file does not exist in local disk
        return nil
    }

    class func saveToDisk(location: URL, response: URLResponse?) -> URL? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filename = response?.suggestedFilename ?? UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent(filename)

        do {
            try fileManager.moveItem(at: location, to: fileURL)
            // Exclude the file from iCloud backups
            return fileURL
        } catch {
            print("Error saving video to local disk: \(error.localizedDescription)")
            return nil
        }
    }
}
