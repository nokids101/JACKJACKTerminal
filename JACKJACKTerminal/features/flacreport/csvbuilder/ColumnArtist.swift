// Extracts the ARTIST tag from the FLAC metadata

import Foundation

struct ColumnArtist {
    static func from(cache: TagCache) -> String {
        return cache.get("ARTIST").joined(separator: "; ")  // Join multiple values with "; " for consistent formatting
    }
}
