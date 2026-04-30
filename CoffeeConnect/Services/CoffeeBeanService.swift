//
//  CoffeeBeanService.swift
//  CoffeeConnect
//
//  Created by Rajshri Kosurkar on 30/04/26.
//

import Foundation

// MARK: - BeanServiceProtocol

protocol BeanServiceProtocol {
    func fetchBeans() async throws -> [CoffeeBean]
}

// MARK: - BeanServiceError

enum BeanServiceError: LocalizedError {
    case fileNotFound(String)
    case decodingFailed(String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let name):
            return "Could not find file '\(name)' in the app bundle."
        case .decodingFailed(let detail):
            return "Failed to decode bean data: \(detail)"
        case .unknown:
            return "An unknown error occurred while loading bean data."
        }
    }
}

// MARK: - LocalBeanService (Primary Implementation)

/// Loads coffee bean data from the bundled JSON file.
/// Conforms to BeanServiceProtocol for easy testability / dependency injection.
final class LocalBeanService: BeanServiceProtocol {

    private let fileName: String
    private let bundle: Bundle

    init(fileName: String = "AllTheBeans", bundle: Bundle = .main) {
        self.fileName = fileName
        self.bundle = bundle
    }

    func fetchBeans() async throws -> [CoffeeBean] {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw BeanServiceError.fileNotFound(fileName)
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let beans = try decoder.decode([CoffeeBean].self, from: data)
            return beans.sorted { $0.index < $1.index }
        } catch let decodingError as DecodingError {
            throw BeanServiceError.decodingFailed(decodingError.localizedDescription)
        } catch {
            throw BeanServiceError.unknown
        }
    }
}
