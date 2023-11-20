import credits.leo;
// import clr.leo;

// The 'vesting' program.
program vesting.aleo {

    const EMPTY_CURVE_PART_TYPE: u8 = 0u8;
    const CONSTANT_CURVE_PART_TYPE: u8 = 1u8;
    const CLIFF_CURVE_PART_TYPE: u8 = 2u8;
    const LINEAR_CURVE_PART_TYPE: u8 = 3u8;

    struct VestingCurvePart {
        part_type: u8

        bias_blocks: u32
        duration: u32

        constant_amount: u128

        cliff_blocks_duration: u32
        cliff_amount: u128

        linear_koef_numerator: u128
        linear_koef_denominator: u128
    }

    record VestingCurve {
        owner: address,
        parts: [VestingCurvePart; 10],
        claimed: u128,
        max_available: u128,
    }

    function calculate_amount_from_part(part: VestingCurvePart, block_height: u32) -> u128 {
        if (part.part_type == CONSTANT_CURVE_PART_TYPE) {
            return part.constant_amount;
        }
        if (part.part_type == CLIFF_CURVE_PART_TYPE && block_height.sub_wrapped(part.bias_blocks) >= part.cliff_blocks_duration) {
            return part.cliff_amount;
        }
        if (part.part_type == LINEAR_CURVE_PART_TYPE) {
            let x: u128 = block_height.sub_wrapped(part.bias_blocks) as u128;
            return (x * part.linear_koef_numerator) / part.linear_koef_denominator;
        }
        return 0u128;
    }



    transition create_vesting(
        parts: [VestingCurvePart; 10], 
        value: credits.leo/credits,
        to: address
    ) -> (VestingCurve, credits.leo/credits) {

        assert_neq(parts[0u8].part_type, EMPTY_CURVE_PART_TYPE);

        let sum: u128 = 0u128;

        let prev_bias: u32 = parts[0u8].bias_blocks;
        let prev_duration: u32 = 0u32;
        for part_idx: u8 in 0u8..10u8 {
            let part: VestingCurvePart = parts[part_idx];
            assert_eq(part.bias_blocks, prev_bias + prev_duration);
            assert(part.linear_koef_numerator > 0u128 && part.linear_koef_denominator > 0u128);

            sum += calculate_amount_from_part(part, part.bias_blocks + part.duration);

            prev_bias = part.bias_blocks;
            prev_duration = part.duration;
        }

        assert(value.microcredits as u128 >= sum);

        let change: credits = credits.leo/transfer_private_to_public(value, aleo1gdvhm99vhja8m6y2l5xagct2c3mazaevwe9mm9w0enhz3pfrmc9qmuzgtf, sum as u64);

        let curve: VestingCurve = VestingCurve {
            owner: to,
            parts,
            claimed: 0u128,
            max_available: sum
        };

        return (curve, change);
    }

    transition claim_tokens(curve: VestingCurve, amount: u128, target_block_number: u32, to: address) -> (VestingCurve, credits.leo/credits) {
        
        let accrued_sum: u128 = 0u128;

        let is_claimable: bool = true;

        for part_idx: u8 in 0u8..10u8 {
            let part: VestingCurvePart = curve.parts[part_idx];

            let part_finish_block: u32 = part.bias_blocks + part.duration;
            if (is_claimable) {
                if (part_finish_block < target_block_number) {
                    accrued_sum += calculate_amount_from_part(part, part_finish_block);
                } else {
                    accrued_sum += calculate_amount_from_part(part, target_block_number);
                    is_claimable = false;
                }
            }
        }

        let claimable_amount: u128 = accrued_sum - curve.claimed;
        assert(claimable_amount >= amount);

        let claimed: credits = credits.leo/transfer_public_to_private(to, amount as u64);

        let new_curve: VestingCurve = VestingCurve {
            owner: curve.owner,
            parts: curve.parts,
            claimed: curve.claimed + amount,
            max_available: curve.max_available
        };

        return (new_curve, claimed) then finalize(target_block_number);
    }

    finalize claim_tokens(target_block: u32) {
        assert(block.height + 100u32 > target_block);
    }

    // transition get_address() -> address {
    //     let addr: address = clr.leo/get_self_caller();
    //     return addr;
    // }
}
