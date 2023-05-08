//
//  ApiError.swift
//  iTunesSearchAPIExercise
//
//  Created by WillyChen on 2023/5/8.
//
import Foundation

enum ApiError: Error {
    case statusCode
    case decoding
    case invalidURL
    case other(Error)
    
    static func map(_ error: Error) -> ApiError {
        return (error as? ApiError) ?? .other(error)
    }
}
