//
//  MediaConverter.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/03/11.
//

import UIKit
import AVFoundation

class MediaConverter {
    
    enum ConvertResult {
        case success(_ path: String)
        case progress(_ value: Float)
        case failed(_ error: Error)
    }
    
    typealias ConvertCompletion = (ConvertResult) -> Void
    
    class func getLocalFileSize(fileName: String) -> String {
        do {
            let path = Constants.inDocumentFolder(fileName: fileName)
            let attr = try FileManager.default.attributesOfItem(atPath: path.absoluteString)
            let fileSize = attr[FileAttributeKey.size] as! UInt64
            return ByteCountFormatter().string(fromByteCount: Int64(bitPattern: fileSize))
        } catch {
            print("Error: \(error.localizedDescription)")
            return ""
        }
    }
    
    class func extractAudioFromVideo(fileName: String, completion: @escaping ConvertCompletion) {
        print("Extracting audio from video")
        let inputUrl = Constants.inDocumentFolder(fileName: fileName + ".mp4")
        let outputUrl = Constants.inDocumentFolder(fileName: fileName + ".m4a")
        let asset = AVURLAsset(url: inputUrl)
        asset.writeAudioTrack(to: outputUrl) {
            print("Converted video-mp4 to audio-m4a: \(outputUrl.absoluteString)")
            completion(.success(outputUrl.absoluteString))
            if deleteFileName(fileName + ".mp4") == true {
                print("delete file", fileName + ".mp4 OK")
            }
        } progress: { progress in
            print(progress)
            completion(.progress(progress))
        } failure: { error in
            print(error.localizedDescription)
            completion(.failed(error))
        }
    }
    
    class func extractDurationForSong(songID: String, songExtension: String) -> String {
        let fullName = "\(songID).\(songExtension)"
        let asset = AVAsset(url: Constants.inDocumentFolder(fileName: fullName))
        return TimeInterval(CMTimeGetSeconds(asset.duration)).stringFromTimeInterval()
    }

    class func extractSongMetadata(songID: String, songExtension: String) -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        let fullName = "\(songID).\(songExtension)"
        let asset = AVAsset(url: Constants.inDocumentFolder(fileName: fullName))
        for item in asset.metadata {
            guard let key = item.commonKey?.rawValue ?? item.key?.description, let value = item.value else {
                continue
            }
            dict[key] = value
        }
        return dict
    }

    class func saveImage(_ image: UIImage?, withName filename: String) {
        guard let img = image else {
            return
        }
        let path = Constants.inDocumentFolder(fileName: filename + ".jpg")
        let dataPath = URL(fileURLWithPath: path.absoluteString)
        do {
            try img.jpegData(compressionQuality: 1.0)?.write(to: dataPath, options: .atomic)
        } catch {
            print("file cant not be save at path \(dataPath), with error : \(error)");
        }
    }

    class func deleteFileName(_ name: String) -> Bool {
        let paths = Constants.inDocumentFolder(fileName: name)
        if FileManager.default.fileExists(atPath: paths.absoluteString) {
            do {
                try FileManager.default.removeItem(atPath: paths.absoluteString)
                print("Removed file: \(paths.absoluteString)")
            } catch let removeError {
                print("couldn't remove file at path", removeError.localizedDescription)
                return false
            }
        }
        return true
    }
    
    class func checkFileExist(_ filename: String) -> Bool {
        let paths = Constants.inDocumentFolder(fileName: filename)
        return FileManager.default.fileExists(atPath: paths.absoluteString)
    }
    
    class func clearTmpDirectory() {
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try FileManager.default.contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try FileManager.default.removeItem(atPath: fileUrl.path)
            }
        } catch {
            print("Cleaning Tmp Directory Failed: " + error.localizedDescription)
        }
    }
}
