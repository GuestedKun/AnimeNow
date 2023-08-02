import XCTest

@testable import AnimeClient

final class AnimeClientTests: XCTestCase {
    func testFetchingAllEpisodeProviders() async throws {
        let animeClient = AnimeClient.testValue

        let providers = try await animeClient.getAnimeProviders(URL(string: "https://api.consumet.org").unsafelyUnwrapped)

        XCTAssertEqual(providers.count, 3)
    }
}
