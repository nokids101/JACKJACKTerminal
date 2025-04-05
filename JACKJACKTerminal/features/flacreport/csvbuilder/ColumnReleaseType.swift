import Foundation

struct ColumnReleaseType {
    static func from(cache: TagCache) -> String {
        return cache.get("RELEASETYPE").joined(separator: "; ") // Join multiple values with "; " for consistent formatting
    }
}
