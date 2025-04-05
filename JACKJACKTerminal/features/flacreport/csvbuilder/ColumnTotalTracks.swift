import Foundation

struct ColumnTotalTracks {
    static func from(cache: TagCache) -> String {
        return cache.get("TOTALTRACKS").joined(separator: "; ")    // Join multiple values with "; " for consistent formatting
    }
}
