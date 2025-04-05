import Foundation

// Resolves and caches full paths to CLI tools (like flac or metaflac).
// Uses `/usr/bin/which` + fallback paths for Homebrew/MacPorts
struct ToolManager {

    private static var pathCache: [String: String] = [:]

    static func path(for tool: String) -> String? {
        if let cached = pathCache[tool] {
            return cached
        }

        // 🧠 Try /usr/bin/which (default sandbox-safe method)
        let output = ShellHelper.runShell(["/usr/bin/which", tool])
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if !output.isEmpty {
            pathCache[tool] = output
            return output
        }

        // 🔁 Fallback to known tool install locations (Homebrew, MacPorts)
        let fallbackPaths = [
            "/opt/homebrew/bin/\(tool)", // Apple Silicon Homebrew
            "/usr/local/bin/\(tool)",    // Intel Homebrew
            "/opt/local/bin/\(tool)"     // MacPorts
        ]

        for path in fallbackPaths {
            if FileManager.default.fileExists(atPath: path) {
                pathCache[tool] = path
                return path
            }
        }

        // ❌ Not found anywhere
        return nil
    }

    // Returns any tools that couldn't be found — can be used for alerts
    static func missingDependencies(_ required: [String] = ["flac", "metaflac"]) -> [String] {
        return required.compactMap { path(for: $0) == nil ? $0 : nil }
    }
}
