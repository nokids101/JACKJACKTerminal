// ShellValidator.swift
// Checks if required command-line tools are available (flac, metaflac)

import Foundation

struct ShellValidator {
    static func checkDependencies() -> [String] {
        let requiredTools = ["flac", "metaflac"]
        var missingTools: [String] = []

        for tool in requiredTools {
            let output = FLACMetadataExtractor.runShell(["which", tool]).trimmingCharacters(in: .whitespacesAndNewlines)
            if output.isEmpty {
                missingTools.append(tool)
            }
        }

        return missingTools
    }
}

// ShellValidator.swift
// Validates presence of required shell tools

// This Swift module would check for the availability of 'flac' and 'metaflac'
// Equivalent to the Bash code:
// for cmd in flac metaflac; do
//     if ! command -v $cmd &> /dev/null; then
//         echo "Error: '$cmd' is not installed or in PATH."
//         exit 1
//     fi
// done

