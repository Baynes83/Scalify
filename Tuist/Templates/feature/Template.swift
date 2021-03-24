import ProjectDescription
let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Feature module template",
    attributes: [
        nameAttribute,
        .optional("platform", default: "iOS"),
    ],
    files: [
        .file(path: "Modules/Features/\(nameAttribute)/Sources/\(nameAttribute)Module.swift",
              templatePath: "../stencils/module.stencil"),
        .file(path: "Modules/Features/\(nameAttribute)/Sources/\(nameAttribute)Router.swift",
              templatePath: "../stencils/router.stencil"),
        .file(path: "Modules/Features/\(nameAttribute)/Sources/UI/\(nameAttribute)View.swift",
              templatePath: "../stencils/swiftuiView.stencil"),
        .file(path: "Modules/Features/\(nameAttribute)/Sources/UI/\(nameAttribute)ViewModel.swift",
              templatePath: "../stencils/swiftuiViewModel.stencil"),
        .file(path: "Modules/Features/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
              templatePath: "../stencils/unitTests.stencil")
    ]
)
