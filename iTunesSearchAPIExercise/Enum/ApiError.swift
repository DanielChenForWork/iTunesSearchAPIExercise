//
//  ApiError.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//
import Foundation

enum ApiError: Error {
    case statusCode
    case invalidURL
    case sameURL
    case noData
    case other(Error)
    
    static func map(_ error: Error) -> ApiError {
        return (error as? ApiError) ?? .other(error)
    }
}
