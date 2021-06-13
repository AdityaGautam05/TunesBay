//
//  DatabaseConnectionError.swift
//  Songs App
//
//  Created by Aditya Gautam on 13/05/21.
//

import Foundation

public enum DatabaseConnectionError {
    case resolvingHostUnsuccessful
    case connectionRefused
    case unknown
    case addingEntryFailed
    case removingEntryFailed
}
