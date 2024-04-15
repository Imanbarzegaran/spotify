//
//  AuthManager.swift
//  spotify
//
//  Created by MacBook Air on 4/10/24.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "36dca6a57a574d8fbf787c2078af5265"
        static let clientSecret = "83b9837cfc5b4f8f94b20f46169acc0d"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
        let redirectURI = "https://github.com/Imanbarzegaran"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
       return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    
    

    
//    public func exchangeCodeForToken(
//        code: String,
//        completion: @escaping ((Bool) -> Void)
//    ){
//        // get token
//        
//    }
//    
//    private func refreshAccessToken() {
//        
//    }
//    
//    private func cacheToken(){
//        
//        
//    }
    
}
