//
//  AuthManager.swift
//  spotify
//
//  Created by MacBook Air on 4/10/24.
//

import Foundation


final class AuthManager {
    static let Shared = AuthManager()
    
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
