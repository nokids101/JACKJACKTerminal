import Foundation

// CreateHeader.swift
// Defines the exact CSV header row using custom column titles

struct CreateHeader {
    static func headerRow() -> [String] {
        return [
            "Filename", "Title", "Artist", "Album", "Track Number", "Length", "Date",
            "Album Artist", "Artists", "Comment", "Full Resolution?", "Explicit?",
            "Record Label", "Release Type", "Total Tracks", "File Specs", "Filepath", "Verify"
        ]
    }
}
