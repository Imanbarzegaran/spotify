////
////  APICaller.swift
////  spotify
////
////  Created by MacBook Air on 4/10/24.
////

import Foundation

final class APICaller {
    static let Shared = APICaller()
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    
    // MARK: - Albums
    
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/albums/" + album.id),
            type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                   // print(result)
                    completion(.success(result))
                    
                }catch {
                //    print(error)
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
    }
    
    // MARK: - Playlist

    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id),
            type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                 //   print(result)
                    completion(.success(result))
                    
                }catch {
                  //  print(error)
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
    }
    
    public func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me/playlists/?limit=50"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(LibraryPlaylistsResponse.self, from: data)
                    completion(.success(result.items))
                   
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(json)
                    
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                let urlString = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
                self?.createRequest(with: URL(string: urlString), type: .POST) { baseRequest in
                    var request = baseRequest
                    let json = [
                        "name" : name
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            completion(false)
                            return
                        }
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            //JSONDecoder().decode(Playlist.self, from: data)
                            if let response = result as? [String: Any], response["id"] as? String != nil {
                               print("Created")
                                completion(true)
                            }else{
                                print("failed to get id")
                                completion(false)
                            }
                        }
                        catch {
                            print(error.localizedDescription)
                            completion(false)
                        }
                    }
                    task.resume()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func addTrackToPlaylist(
        track: AudioTrack,
        playlist: Playlist,
        completion: @escaping (Bool) -> Void
    ) {
        
    }
    
    public func removeTrackFromPlaylist(
        track: AudioTrack,
        playlist: Playlist,
        completion: @escaping (Bool) -> Void
    ) {
        
    }
   
    
    // MARK: - Profile
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>)-> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    
                    return
                }
               
                do {
                 
                     let result = try JSONDecoder().decode(UserProfile.self, from: data)
                  //  print(result)
                      completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
           
            
        }
    }
    
    // MARK: - browse
    
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                  
                    let result =  try JSONDecoder().decode(NewReleasesResponse.self, from: data)
               
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                    
                }
            }
            task.resume()
        }
        
    }
    
    
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistResponse, Error>) -> Void)) {
        
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                  
                    let result =  try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
               
                  //  print(result)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                    
                }
            }
            task.resume()
        }
    }
    
    
    
    public func getRecommandations(genres: Set<String>, completion: @escaping ((Result<RecommandationsResponse, Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/recommendations?limit=20&seed_genres=\(seeds)"),
            type: .GET
        ) { request in
       
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result =  try JSONDecoder().decode(RecommandationsResponse.self, from: data)
                   completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getRecommandedGenres(completion: @escaping ((Result<RecommandedGenresResponse, Error>) -> Void)) {
        
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let result =  try JSONDecoder().decode(RecommandedGenresResponse.self, from: data)
                    
                    //print(result)
                     completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                    
                }
            }
            task.resume()
        }
    }
        
      // MARK: - Category
    
    public func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"),
            type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                    
                }
                catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
            }
    }
    
    
    public func getCategoryPlaylists(category: Category, completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=50"),
            type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(CategoryPlaylistResponse.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                }
                catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
            }
    }
    
    // MARK: - Search
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL+"/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
            type: .GET
        ) { request in
            print(request.url?.absoluteString ?? "none")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.tracks.items.compactMap({.track(model: $0) }))
                    searchResults.append(contentsOf: result.albums.items.compactMap({.album(model: $0) }))
                    searchResults.append(contentsOf: result.artists.items.compactMap({.artist(model: $0) }))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({.playlist(model: $0) }))
                    
                    completion(.success(searchResults))
                }catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
        
        
    // MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void
    ) {
        
        
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
            
            
        }
    }
}




