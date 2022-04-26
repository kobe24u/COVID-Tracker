//
//  Bundle+LoadAndDecode.swift
//  COVID Tracker VIC
//
//  Created by Vinnie Liu on 3/2/2022.
//

import Foundation

extension Bundle {
    /// Load and decode a JSON File
    /// - Parameter filename: file name in the bundle
    /// - Throws: you got to catch the error :)
    /// - Returns: a decoded object
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = url(forResource: filename, withExtension: ".json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let decodedData = try jsonDecoder.decode(D.self, from: data)
        return decodedData
    }
}
