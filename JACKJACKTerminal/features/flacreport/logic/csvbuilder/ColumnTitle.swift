import Foundation

// Extracts the TITLE tag from the FLAC metadata
struct ColumnTitle {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("TITLE", from: url).joined(separator: "; ")
    }
}
