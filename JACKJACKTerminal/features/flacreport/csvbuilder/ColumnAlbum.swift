// Extracts the ALBUM tag from the FLAC metadata

import Foundation

struct ColumnAlbum {
    static func from(cache: TagCache) -> String {
        return cache.get("ALBUM").joined(separator: "; ") // Join multiple values with "; " for consistent formatting
    }
}
