import Foundation

// Handles reading specific metadata tags from FLAC files using metaflac
struct FLACMetadataExtractor {

    // Returns all values for a given FLAC tag (e.g., TITLE, ARTIST)
    // Trims and filters empty/malformed tag lines
    static func getAllTagValues(_ tag: String, from url: URL) -> [String] {
        let metaflacPath = ToolManager.path(for: "metaflac") ?? "metaflac"
        let output = FLACShellWrapper.run(using: metaflacPath, tag: tag, path: url)

        return output
            .split(separator: "\n")
            .compactMap { line in
                guard line.hasPrefix("\(tag)=") else { return nil }
                return line
                    .replacingOccurrences(of: "\(tag)=", with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }
    }

    // Returns raw tag values as-is (used for exact match rules)
    static func getRawTagValues(_ tag: String, from url: URL) -> [String] {
        let metaflacPath = ToolManager.path(for: "metaflac") ?? "metaflac"
        let output = FLACShellWrapper.run(using: metaflacPath, tag: tag, path: url)

        return output
            .split(separator: "\n")
            .compactMap { line in
                guard line.hasPrefix("\(tag)=") else { return nil }
                return line.replacingOccurrences(of: "\(tag)=", with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }
    }

    // Runs a raw metaflac argument (e.g., --show-total-samples) and returns a single result
    static func getRaw(_ arg: String, from url: URL) -> String? {
        let metaflacPath = ToolManager.path(for: "metaflac") ?? "metaflac"
        let output = FLACShellWrapper.runArg(using: metaflacPath, arg: arg, path: url)

        return output.isEmpty ? nil : output.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
