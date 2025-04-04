import Foundation

// Extracts the LABEL tag from the FLAC metadata
struct ColumnRecordLabel {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("LABEL", from: url).joined(separator: "; ")
    }
}
