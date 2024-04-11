//
//  AuthManager.swift
//  spotify
//
//  Created by MacBook Air on 4/10/24.
//

import Foundation


final class AuthManager {
    static let Shared = AuthManager()
    
    static let clientID = "36dca6a57a574d8fbf787c2078af5265"
    static let clientSecret = "83b9837cfc5b4f8f94b20f46169acc0d"
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationdate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
