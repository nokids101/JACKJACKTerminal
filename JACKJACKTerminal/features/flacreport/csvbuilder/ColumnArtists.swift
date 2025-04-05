import Foundation

// Extracts the ARTISTS tag from the FLAC metadata
struct ColumnArtists {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("ARTISTS", from: url).joined(separator: "; ")
    }
}
