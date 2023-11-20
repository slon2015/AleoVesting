program clr.aleo {
    transition get_self_caller() -> address {
        let result: address = self.caller;
        return result;
    }
}