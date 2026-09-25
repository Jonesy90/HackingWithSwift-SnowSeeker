//
//  Bundle-Decodable.swift
//  HackingWithSwift-SnowSeeker
//
//  Created by Michael Jones on 24/09/2026.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate file in the bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load the file from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) due to missing \(key) - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing type value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle as it appears to be invalid.")
        } catch {
            fatalError("Failed to decode \(file) from bundle - \(error.localizedDescription)")
        }
    }
}
