// Copyright © 2022 Brian Drelling. All rights reserved.

import DocCMiddleware
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // We do not need to enable FileMiddleware as we're not serving the files directly.
    // In a typical use-case, it would still likely be best to keep your documentation
    // within the Public/ directory so it is easily understood that the files are made public almost exactly as-is.

    // Define our middleware.
    let doccMiddleware = DocCMiddleware(
        // The directory we're providing is the same as the default directory, 
        // this is just an example of how to override the document directory.
        documentationDirectory: app.directory.workingDirectory.appending("Docs/"),
        // Additionally, we leverage the --hosting-base-path to show a slightly more complex example, but you don't need to do it this way.
        // If you're just looking to host your DocC documentation, you can generate it without passing in
        // the --hosting-base-path option and remove the property from the initializer.
        archive: .init(name: "DocCMiddleware", hostingBasePath: "DocCMiddleware")
    )

    // Use the middleware.
    app.middleware.use(doccMiddleware)
}
