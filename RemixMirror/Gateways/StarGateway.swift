protocol StarGateway {
    func loadAll(completion: @escaping AsyncResult<[Star]>)
}
