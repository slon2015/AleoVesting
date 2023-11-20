leo run  --offline create_vesting \
    "[
        {part_type: 1u8, bias_blocks: 1000u32, duration: 100u32, constant_amount: 100000u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128},
        {part_type: 0u8, bias_blocks: 1100u32, duration: 0u32, constant_amount: 0u128, cliff_blocks_duration: 0u32, cliff_amount: 0u128, linear_koef_numerator: 1u128, linear_koef_denominator: 1u128}
    ]" \
    "{owner: aleo1atrnqapasav6hh2ja52d797734qafvq5ay0cn34q2yfrjprvfy9qn02tsp.private,microcredits: 500000u64.private,_nonce: 4924411302922514099144601816647851943525756103855864279792770509209181258793group.public}" \
    aleo1wlgqzyyd6lxv6qf9z6unx2npqvv83vgulw8kfexwrl3mqh8zug9qszmyzz