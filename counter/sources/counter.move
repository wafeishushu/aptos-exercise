module publisher::counter {
    use std::signer;

    // resource
    struct Counter has key, store {
        value: u64,
    }

    #[view]
    public fun get_count(addr: address): u64 acquires Counter {
        let counter = borrow_global<Counter>(addr);
        counter.value
    }

    // internal funcitons
    public fun init(account: &signer){
        move_to(account, Counter{value: 0});
    }

    public fun incr(account: &signer) acquires Counter {
        let counter = borrow_global_mut<Counter>(signer::address_of(account));
        counter.value = counter.value + 1;
    }

    // upgraded
    public fun incr_by(account: &signer, increasement: u64) acquires Counter {
        let counter = borrow_global_mut<Counter>(signer::address_of(account));
        counter.value = counter.value + increasement;
    }

    // entry functions
    public entry fun init_counter(account: signer) {
        Self::init(&account)
    }

    public entry fun incr_counter(account: signer) acquires Counter {
        Self::incr(&account)
    }

    public entry fun incr_counter_by(account: signer, increasement: u64) acquires Counter {
        Self::incr_by(&account, increasement)
    }

    // upgraded
    public entry fun incr_counter_by2(account: signer, increasement: u64, increasement2: u64) acquires Counter {
        Self::incr_by(&account, increasement + increasement2)
    }
}