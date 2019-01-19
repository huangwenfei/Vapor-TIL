import Vapor
import Fluent

/// Register your application's routes here.
public func routes(_ router: Router) throws {
//    // Basic "It works" example
//    router.get { req in
//        return "It works!"
//    }
//
//    // Basic "Hello, world!" example
//    router.get("hello") { req in
//        return "Hello, world!"
//    }
//
//    router.post("api", "acronyms") { req -> Future<Acronym> in
//
//        return
//            try req.content
//                .decode(Acronym.self)
//                .flatMap(to: Acronym.self, { acronym in
//                    return acronym.save(on: req)
//                })
//
//    }
//
//    router.get("api", "acronyms") { reg -> Future<[Acronym]> in
//
//        return Acronym.query(on: reg).all()
//
//    }
//
//    router.get("api", "acronyms", Acronym.parameter) { reg -> Future<Acronym> in
//
//        return try reg.parameters.next(Acronym.self)
//
//    }
//
//    router.put("api", "acronyms", Acronym.parameter) { reg -> Future<Acronym> in
//
//        return
//            try flatMap(to: Acronym.self,
//                        reg.parameters.next(Acronym.self),
//                        reg.content.decode(Acronym.self), { acronym, updateAcronym in
//
//                            acronym.short = updateAcronym.short
//                            acronym.long = updateAcronym.long
//
//                            return acronym.save(on: reg)
//                        })
//    }
//
//    router.delete("api", "acronyms", Acronym.parameter) { reg -> Future<HTTPStatus> in
//
//        return
//            try reg.parameters.next(Acronym.self)
//                .delete(on: reg)
//                .transform(to: HTTPStatus.noContent)
//    }
//
//    router.get("api", "acronyms", "search") { reg -> Future<[Acronym]> in
//
//        guard let searTerm = reg.query[String.self, at: "term"] else { throw Abort(.badRequest) }
//
//        return Acronym.query(on: reg).filter(\.short == searTerm).all()
//    }
//
//    // 1
//    router.get("api", "acronyms", "first") { req -> Future<Acronym> in
//        // 2
//        return
//            Acronym.query(on: req).first().map(to: Acronym.self) { acronym in
//                // 3
//                guard let acronym = acronym else { throw Abort(.notFound) }
//                // 4
//                return acronym
//            }
//    }
//
//    // 1
//    router.get("api", "acronyms", "sorted") { req -> Future<[Acronym]> in
//        // 2
//        return Acronym.query(on: req).sort(\.short, .ascending).all()
//    }

    
    let acronymsController = AcronymsController()
    
    try router.register(collection: acronymsController)
    
//    router.get("api", "acronyms", use: acronymsController.getAllHandler)
    
}
