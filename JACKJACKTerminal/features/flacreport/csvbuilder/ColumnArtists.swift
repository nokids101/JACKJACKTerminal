// Extracts the ARTISTS tag from the FLAC metadata

import Foundation

struct ColumnArtists {
    static func from(cache: TagCache) -> String {
        return cache.get("ARTISTS").joined(separator: "; ") // Join multiple values with "; " for consistent formatting
    }
}
