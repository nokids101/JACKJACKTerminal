import Foundation

struct ColumnRecordLabel {
    static func from(cache: TagCache) -> String {
        return cache.get("LABEL").joined(separator: "; ") // Join multiple values with "; " for consistent formatting
    }
}
