import ProjectDescription
let nameAttribute: Template.Attribute = .required("name")

let exampleContents = """
import Foundation

struct \(nameAttribute) { }
"""

let template = Template(
    description: "Common module template",
    attributes: [
        nameAttribute,
        .optional("platform", default: "iOS"),
    ],
    files: [
        .string(path: "Modules/Common/\(nameAttribute)/Sources/\(nameAttribute).swift",
                contents: exampleContents),
        .file(path: "Modules/Common/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
              templatePath: "../stencils/unitTests.stencil")
    ]
)
