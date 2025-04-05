import Foundation

// Extracts the COMMENT tag from the FLAC metadata
struct ColumnComment {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("COMMENT", from: url).joined(separator: "; ")
    }
}
