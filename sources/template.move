// Copyright (c) Aftermath Technologies, Inc.
// SPDX-License-Identifier: Apache-2.0

module template::template {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::tx_context::TxContext;
    use sui::object::UID;
    use sui::transfer;
    use sui::url;

    use std::option;
    use std::ascii;

    struct Witness has drop {}

    //******************************************* Constructor ******************************************//

    fun init(otw: Witness, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            otw,
            $DECIMALS$,
            b"$SYMBOL$",
            b"$NAME$",
            b"$DESCRIPTION$",
            option::some(url::new_unsafe(ascii::string(
                b"$URL$"
            ))),
            ctx
        );

        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

}
