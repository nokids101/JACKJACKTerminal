import Foundation

// Extracts the ARTIST tag from the FLAC metadata
struct ColumnArtist {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("ARTIST", from: url).joined(separator: "; ")
    }
}
