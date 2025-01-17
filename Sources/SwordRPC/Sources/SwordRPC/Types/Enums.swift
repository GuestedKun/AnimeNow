//
//  Enums.swift
//  SwordRPC
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

// MARK: - CommandType

/// Command types to send over  RPC.
/// https://discord.com/developers/docs/topics/rpc#commands-and-events-rpc-commands
enum CommandType: String, Codable {
    case dispatch = "DISPATCH"
    case authorize = "AUTHORIZE"
    case subscribe = "SUBSCRIBE"
    case setActivity = "SET_ACTIVITY"
    case sendActivityJoinInvite = "SEND_ACTIVITY_JOIN_INVITE"
    case closeActivityJoinRequest = "CLOSE_ACTIVITY_JOIN_REQUEST"
}

// MARK: - EventType

/// Possible event types.
/// https://discord.com/developers/docs/topics/rpc#commands-and-events-rpc-events
enum EventType: String, Codable, CaseIterable {
    case error = "ERROR"
    case join = "ACTIVITY_JOIN"
    case joinRequest = "ACTIVITY_JOIN_REQUEST"
    case ready = "READY"
    case spectate = "ACTIVITY_SPECTATE"

    static var activities: [Self] = [.join, .spectate, .joinRequest]
}

// MARK: - JoinReply

/// An enum for a reply to a join request, defining yes or ignore/no types.
public enum JoinReply {
    case no
    case yes
    case ignore
}

// MARK: - OpCode

enum OpCode: UInt32 {
    case handshake = 0
    case frame
    case close
    case ping
    case pong
}
