import Foundation

struct ColumnTitle {
    static func from(cache: TagCache) -> String {
        return cache.get("TITLE").joined(separator: "; ") // Join multiple values with "; " for consistent formatting
    }
}
