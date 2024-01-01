//
//  Content.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/30.
//

import Foundation

struct ContentPage {
    let data: [ContentInfo]
    let nextCursor: String
}

struct ContentInfo {
    let likeUsers: [String]
    let imagePaths: [String]
    let hashTags: [String]
    let comments: [Comment]
    let id: String
    let creator: Creator
    let time: Date
    let content: String
    let productId: String?
}

struct Comment {
    let id: String
    let content: String
    let time: Date
    let creator: Creator
}

struct Creator {
    let id: String
    let nickName: String
    let profileImagePath: String?
}
