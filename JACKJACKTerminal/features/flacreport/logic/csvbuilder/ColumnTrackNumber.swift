import Foundation

// Extracts the TRACKNUMBER tag from the FLAC metadata
struct ColumnTrackNumber {
    static func from(url: URL) -> String {
        // Handles possible multi-value just in case
        return FLACMetadataExtractor.getAllTagValues("TRACKNUMBER", from: url).joined(separator: "; ")
    }
}
