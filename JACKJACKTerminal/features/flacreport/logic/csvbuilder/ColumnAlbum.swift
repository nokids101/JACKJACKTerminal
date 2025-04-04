import Foundation

// Extracts the ALBUM tag from the FLAC metadata
struct ColumnAlbum {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("ALBUM", from: url).joined(separator: "; ")
    }
}
