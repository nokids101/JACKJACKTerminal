import Foundation

// Extracts the TOTALTRACKS tag from the FLAC metadata
struct ColumnTotalTracks {
    static func from(url: URL) -> String {
        // Join multiple values with "; " for consistent formatting
        return FLACMetadataExtractor.getAllTagValues("TOTALTRACKS", from: url).joined(separator: "; ")
    }
}
