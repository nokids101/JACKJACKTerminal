import Foundation

struct ColumnTrackNumber {
    static func from(cache: TagCache) -> String {
        return cache.get("TRACKNUMBER").joined(separator: "; ") // Handles possible multi-value just in case
    }
}
