public protocol BootstrapRouter {
    
    func bootstrapFinished(withResult result: Result<BootstrapState, Error>)

}
