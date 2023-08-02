//
//  AnimeClient+Test.swift
//  Anime Now!
//
//  Created by ErrorErrorError on 9/12/22.
//

import ComposableArchitecture
import SharedModels

public extension AnimeClient {
    static let testValue: AnimeClient = Self {
        []
    } getTopUpcomingAnime: {
        []
    } getTopAiringAnime: {
        []
    } getHighestRatedAnime: {
        []
    } getMostPopularAnime: {
        []
    } getAnimes: { _ in
        []
    } getAnime: { _ in
        throw AnimeClient.Error.providerNotAvailable
    } searchAnimes: { _ in
        []
    } getRecentlyUpdated: {
        []
    } getEpisodes: { _, _, _ in
        .init(name: "", episodes: [Episode(title: "", number: 0, description: "", isFiller: true)])
    } getSources: { _, _, _ in
        .init([])
    } getSkipTimes: { _, _ in
        .init()
    } getAnimeProviders: { _ in
        [.init(name: "First"), .init(name: "Second"), .init(name: "Third")]
		} invalidateAnimeProvider: { _, _ in }
}
