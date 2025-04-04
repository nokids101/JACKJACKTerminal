import Foundation

// Extracts the RELEASETYPE tag from the FLAC metadata
struct ColumnReleaseType {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("RELEASETYPE", from: url).joined(separator: "; ")
    }
}
