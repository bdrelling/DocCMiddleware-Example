// Copyright © 2022 Brian Drelling. All rights reserved.

import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configure(app)
try routes(app)
try app.run()
