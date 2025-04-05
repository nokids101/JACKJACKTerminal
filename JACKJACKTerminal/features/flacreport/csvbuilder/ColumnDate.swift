// Extracts the DATE tag from the FLAC metadata

import Foundation

struct ColumnDate {
    static func from(cache: TagCache) -> String {
        return cache.get("DATE").joined(separator: "; ")  // Join multiple values with "; " for consistent formatting
    }
}
