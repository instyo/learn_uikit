//
//  VideoModel.swift
//  WebViewVideo
//
//  Created by Ikhwan on 11/12/22.
//

import Foundation

struct VideoModel {
    let title: String
    let thumbnail: String
    let videoURL: URL
}

final class VideoModelProvider {
    static func all() -> [VideoModel] {
        return [
        VideoModel(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", thumbnail: "pic1", videoURL: URL(string: "https://raw.githubusercontent.com/instyo/scheme_tester/main/video-1.mp4")!),
        VideoModel(title: "Sed do eiusmod tempor incididunt ut labore et dolore", thumbnail: "pic2", videoURL: URL(string: "https://raw.githubusercontent.com/instyo/scheme_tester/main/video-2.mp4")!),
        VideoModel(title: "Ut enim ad minim veniam", thumbnail: "pic3", videoURL: URL(string: "https://raw.githubusercontent.com/instyo/scheme_tester/main/video-3.mp4")!),
        VideoModel(title: "Duis aute irure dolor in reprehenderit in voluptate", thumbnail: "pic4", videoURL: URL(string: "https://raw.githubusercontent.com/instyo/scheme_tester/main/video-4.mp4")!)
        ]
    }
}
