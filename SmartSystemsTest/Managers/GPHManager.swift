//
//  GPHManager.swift
//  SmartSystemsTest
//
//  Created by Dima Paliychuk on 5/4/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import Foundation
import GiphyCoreSDK

class GPHManager {
    
    static let shared = GPHManager()
    
    private let client: GPHClient
    
    private init() {
        client = GPHClient(apiKey: "u7vsBerKUnxYQh60qQSXuUUn5EInUZbI")
    }
    
    func getImagesBy(tag: String,
        completionHandler: @escaping (_ result: GPHListMediaResponse?, _ error: Error?) -> Void) {
        client.search(tag) { (mediaResponse, error) in
                completionHandler(mediaResponse, error)
        }
    }
    
}
