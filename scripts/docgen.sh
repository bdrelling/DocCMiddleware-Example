#!/bin/bash

# Sources:
#   - https://github.com/apple/swift-docc-plugin
#   - https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/
#   - https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/generating-documentation-for-hosting-online
#   - https://www.swift.org/documentation/docc/
#   - https://www.swift.org/documentation/docc/distributing-documentation-to-other-developers

# Define the target.
target='DocCMiddleware'

# Define the output directory.
# If this is left empty, the default location is used.
output_directory=${1-'Docs'}

# Recreate the output directory if it already exists.
rm -rf $output_directory
mkdir $output_directory

# Define a function for generating a .doccarchive.
generate_archive() {
    target=$1

    echo "Generating archive for ${target} in ${output_directory}..."

    # If we have defined an output directory, use it.
    # Otherwise, generate documentation in the default location.
    # At time of writing, this is: .build/plugins/Swift-DocC/outputs/
    if [ ! -z $output_directory ]; then
        swift package --allow-writing-to-directory $output_directory \
            generate-documentation \
            --hosting-base-path $target \
            --target $target \
            --output-path "${output_directory}/${target}.doccarchive"
    else
        swift package generate-documentation \
            --hosting-base-path $target \
            --target $target
    fi
}

# Add new entries for every target here.
# Note that this will only work with TARGETS within your dependency graph,
# if you need to work with products, you'll have to update this script.
generate_archive $target
