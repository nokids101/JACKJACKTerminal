import Foundation

// Extracts the ALBUMARTIST tag from the FLAC metadata
struct ColumnAlbumArtist {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("ALBUMARTIST", from: url).joined(separator: "; ")
    }
}
