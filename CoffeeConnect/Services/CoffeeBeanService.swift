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
    case invalidURL
    case invalidResponse
    case unknown

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let name):
            return "Could not find file '\(name)' in the app bundle."
        case .decodingFailed(let detail):
            return "Failed to decode bean data: \(detail)"
        case .invalidURL:
            return "Invalid URL provided for bean data."
        case .invalidResponse:
            return "Invalid response format from bean data API."
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

// MARK: - MockBeanService (For Testing & Previews)

final class MockBeanService: BeanServiceProtocol {

    var mockedBeans: [CoffeeBean]
    var mockedError: Error?

    init(mockedBeans: [CoffeeBean] = CoffeeBean.mockBeans, mockedError: Error? = nil) {
        self.mockedBeans = mockedBeans
        self.mockedError = mockedError
    }

    func fetchBeans() async throws -> [CoffeeBean] {
        if let error = mockedError { throw error }
        return mockedBeans
    }
}

// MARK: - NetworkBeanService (From API - Future Implementation)

final class NetworkBeanService: BeanServiceProtocol {
    
    func fetchBeans() async throws -> [CoffeeBean] {
        
        guard let url = URL(string: "https://testURL.com") else {
            throw BeanServiceError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
            throw BeanServiceError.invalidResponse
        }
        return try JSONDecoder().decode([CoffeeBean].self, from: data)
            .sorted { $0.index < $1.index }
        
    }
}
