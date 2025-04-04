import Foundation

struct FLACMetadataExtractor {
    //  Returns all values for a given FLAC tag (e.g., ARTIST, ALBUMARTIST, etc.)
    //  If multiple values exist, all are returned as a string array
    static func getAllTagValues(_ tag: String, from url: URL) -> [String] {
        let output = FLACShellWrapper.run(tag: tag, path: url)

        // Extract all lines matching TAG=VALUE and remove the prefix
        return output
            .split(separator: "\n") // If not included it would output "TITLE=Track 01\nTITLE=Track 01 (E)\nARTIST=JackJack" and your code wouldn’t be able to loop through and extract values. You’d be stuck trying to process the whole thing as one chunk.
            .compactMap { line in
                guard line.hasPrefix("\(tag)=") else { return nil } // Filters out lines that don’t belong
                return line.replacingOccurrences(of: "\(tag)=", with: "") // ✅ It’s removing the "TAG=" prefix from each line so you get just the value.
                           .trimmingCharacters(in: .whitespacesAndNewlines)
            }
    }

    //  NEW FUNCTION: Returns raw tag values without any cleanup — no trimming, no decoding.
    //  This is used for strict matching (e.g., 'Lossless' vs 'Lossy' validation)
    //  If multiple values exist, they are returned exactly as-is, even if malformed or unexpected
    static func getRawTagValues(_ tag: String, from url: URL) -> [String] {
        let output = FLACShellWrapper.run(tag: tag, path: url)

        return output
            .split(separator: "\n") // 🪓 Split into individual lines
            .compactMap { line in
                guard line.hasPrefix("\(tag)=") else { return nil }
                return line.replacingOccurrences(of: "\(tag)=", with: "")
                // ⛔ No trimming or case-changing!
            }
    }

    //  Run a raw metaflac terminal command (like --show-sample-rate or --show-total-samples)
    //  and return the result as an optional string — nil if output is empty
    static func getRaw(_ arg: String, from url: URL) -> String? {
        let output = FLACShellWrapper.runArg(arg: arg, path: url)
            .trimmingCharacters(in: .whitespacesAndNewlines)

        return output.isEmpty ? nil : output
    }

    //  Shell helper for running any metaflac command and capturing the result as text (simple read-only metaflac commands)
    static func runShell(_ args: [String]) -> String {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe

        task.launch()
        task.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? ""
    }
}
