import Foundation

// Extracts the DATE tag from the FLAC metadata
struct ColumnDate {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("DATE", from: url).joined(separator: "; ")
    }
}
