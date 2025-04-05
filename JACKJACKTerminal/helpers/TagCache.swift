import Foundation

// 🎁 Loads all FLAC tags using a single metaflac shell call.
// Greatly reduces the number of shell calls per file.
struct TagCache {
    // Stores tags in [TAG: [Values]] format (e.g., "ARTIST": ["1-800-lost"])
    let tags: [String: [String]]

    // Loads tags from a FLAC file using `--export-tags-to=-`
    static func load(from url: URL) -> TagCache {
        // Run metaflac to export all tags
        let output = ShellHelper.runShell([
            ToolManager.path(for: "metaflac") ?? "metaflac",
            "--export-tags-to=-",
            url.path
        ])

        var result: [String: [String]] = [:]

        // Parse each line into TAG=Value format
        output.split(separator: "\n").forEach { line in
            let parts = line.split(separator: "=", maxSplits: 1)
            guard parts.count == 2 else { return }
            let key = String(parts[0])
            let value = String(parts[1])

            // Support multiple values per tag
            result[key, default: []].append(value)
        }

        return TagCache(tags: result)
    }

    // Retrieves all values for a given tag
    func get(_ tag: String) -> [String] {
        return tags[tag] ?? []
    }
}
