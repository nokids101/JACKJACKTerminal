// Extracts the COMMENT tag from the FLAC metadata

import Foundation

struct ColumnComment {
    static func from(cache: TagCache) -> String {
        return cache.get("COMMENT").joined(separator: "; ") // Join multiple values with "; " for consistent formatting
    }
}
