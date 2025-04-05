// Extracts the ALBUMARTIST tag from the FLAC metadata

import Foundation

struct ColumnAlbumArtist {
    static func from(cache: TagCache) -> String {
        return cache.get("ALBUMARTIST").joined(separator: "; ")  // Join multiple values with "; " for consistent formatting
    }
}
