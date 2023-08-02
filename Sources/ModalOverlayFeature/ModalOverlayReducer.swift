//  ModalOverlayReducer.swift
//  Anime Now!
//
//  Created by ErrorErrorError on 11/20/22.
//

import ComposableArchitecture
import DownloadOptionsFeature
import EditCollectionFeature
import Foundation
import NewCollectionFeature

public struct ModalOverlayReducer: ReducerProtocol {
    public enum State: Equatable {
        case addNewCollection(NewCollectionReducer.State)
        case downloadOptions(DownloadOptionsReducer.State)
        case editCollection(EditCollectionReducer.State)
    }

    public enum Action: Equatable {
        case addNewCollection(NewCollectionReducer.Action)
        case downloadOptions(DownloadOptionsReducer.Action)
        case editCollection(EditCollectionReducer.Action)
        case onClose
    }

    public init() {}

    public var body: some ReducerProtocol<State, Action> {
        Reduce(core)
            .ifCaseLet(/State.addNewCollection, action: /Action.addNewCollection) {
                NewCollectionReducer()
            }
            .ifCaseLet(/State.downloadOptions, action: /Action.downloadOptions) {
                DownloadOptionsReducer()
            }
            .ifCaseLet(/State.editCollection, action: /Action.editCollection) {
                EditCollectionReducer()
            }
    }

    func core(_: inout State, _: Action) -> EffectTask<Action> {
        .none
    }
}
