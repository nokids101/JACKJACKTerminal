import Foundation

// ColumnExplicit.swift
// Returns explicit warning ONLY if (E) is found in title or filename
struct ColumnExplicit {
    static func from(url: URL) -> String {
        // Get title and filename
        let title = FLACMetadataExtractor.getAllTagValues("TITLE", from: url).joined(separator: "; ")
        let filename = url.lastPathComponent

        // Show explicit warning only if (E) exists
        if title.contains("(E)") || filename.contains("(E)") {
            return "🔞 Not for minors"
        }

        // If clean, return blank
        return ""
    }
}
