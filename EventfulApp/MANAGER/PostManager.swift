//
//  PostManager.swift
//  EventfulApp
//
//  Created by Lilli Cain on 10/21/24.
//

import Foundation
//import Firebase
//import FirebaseFirestore

struct PostManager {
//    static let shared = PostManager()
//    
//    static let postsCollection = Firestore.firestore().collection("posts")
//    
//    static func fetchFeedPosts() async throws -> [Post] {
//        let snapshot = try await postsCollection.getDocuments()
//        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
//        
//        for index in 0..<posts.count {
//            let post = posts[index]
//            let userUid = post.userUid
//            let postUser = try await UserManager.fetchUser(withUid: userUid)
//            posts[index].user = postUser
//        }
//        return posts
//    }
//    
//    static func fetchUserPosts(uid: String) async throws -> [Post] {
//        let snapshot = try await postsCollection.whereField("userUid", isEqualTo: uid).getDocuments()
//        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
//    }
}
