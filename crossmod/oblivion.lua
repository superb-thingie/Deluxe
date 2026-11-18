SMODS.Scoring_Calculation:take_ownership("ovn_instable", { 
    func = function(self, chips, mult, flames)
		local instability = G.GAME.ovn_instability
		---@diagnostic disable-next-line: redundant-return-value
		return ((chips * mult) / SMODS.get_scoring_parameter('ele_amp', flames)) ^ instability
	end,
	replace_ui = function (self)
		local function op(text, scale, colour)
			return
			{n=G.UIT.C, config={align = "cm"}, nodes={
				{n=G.UIT.T, config={text = text, lang = G.LANGUAGES['en-us'], scale = scale, colour = colour or G.C.WHITE, shadow = true}},
			}}
		end

		local function container(type, id, scale, w, h, colour)
			return
			{n=G.UIT.C, config={align = 'cm', id = id}, nodes = {
				SMODS.GUI.score_container({
					type = type,
					align = 'cl',
					scale = scale,
					w = w, h = h,
					colour = colour
				})
			}}
		end

		local w = 1.2
		local h = 0.7
		local scale = 0.25
		local op_scale = 0.375
		local downamp = 0.8

		return
		---@diagnostic disable-next-line: redundant-return-value
			-- {n=G.UIT.C, config={align = "cm", minh = 1, padding = 0.1}, nodes={
			-- 		{n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
			-- 			container("chips", "hand_chips_container", text_scale, w, h),
			-- 			SMODS.GUI.operator(op_scale/2),
			-- 			container("mult", "hand_mult_container", text_scale, w, h),
			-- 		}},
			-- 		{n=G.UIT.R, config={align='cm', padding = -0.1}, nodes={
			-- 			container("ele_diviser", "hand_ele_amp", 0, w * 2, 0.05),
			-- 		}},
			-- 		{n=G.UIT.R, config={align = 'cm', padding = 0.075}, nodes={
			-- 			container("ele_amp", "hand_ele_amp", text_scale, w, h),
			-- 		}},
			-- }}
			
        {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
            {n=G.UIT.C, config={align = "cm", minh = 1, padding = 0.05}, nodes={
				op("(", op_scale, G.C.RARITY['ovn_corrupted']),
        	}},
			{n=G.UIT.C, config={align = "cm", minh = 1, padding = -0.1}, nodes={
				{n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.05}, nodes={
					{n=G.UIT.C, config={align = 'cm'}, nodes = {
						{n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
							SMODS.GUI.score_container({
								type = 'chips',
								text = 'chip_text',
								align = 'cr',
								w = w,
								h = h,
								scale = scale,
								colour = G.C.CHIPS
							})
						}},
					}},
					{n=G.UIT.C, config={align = 'cm'}, nodes = { 
						SMODS.GUI.operator(scale)
					}},
					{n=G.UIT.C, config={align = 'cm'}, nodes = { 
						{n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
							SMODS.GUI.score_container({
								type = 'mult',
								align = 'cl',
								w = w ,
								h = h,
								scale = scale,
								colour = G.C.MULT
							})
						}},
					}},
				}},
				{n=G.UIT.R, config={align='cm', padding = 0.05}, nodes={
					{n=G.UIT.C, config={align='cm'}, nodes={
						SMODS.GUI.score_container({
							type = 'ele_diviser',
							w = w * 2,
							h = 0.05,
							scale = 0,
							colour = SMODS.Gradients.ele_amp
						})
					}}
				}},
				{n=G.UIT.R, config={align = 'cm', padding = 0.075}, nodes={
					{n=G.UIT.C, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
						SMODS.GUI.score_container({
							type = 'ele_amp',
							align = 'cm',
							w = w * 0.9 * downamp,
							h = h * 0.9 * downamp,
							scale = scale * 0.9 * downamp,
							colour = SMODS.Gradients.ele_amp
						})
					}},
				}},
			}},
            {n=G.UIT.C, config={align = "cm", minh = 1, padding = 0.05}, nodes={
				op(")", op_scale, G.C.RARITY['ovn_corrupted']),
				op("^", op_scale, G.C.RARITY['ovn_corrupted']),
				container("ovn_instability", "instability_container", scale, w, h, G.C.RARITY['ovn_corrupted']),
        	}}
        }}
			-- op("(", op_scale, G.C.RARITY['ovn_corrupted']),
			-- container("ele_amp", "hand_ele_amp", text_scale, w, h),
			-- op("X", op_scale, G.C.AMP),
			-- container("chips", "hand_chips_container", text_scale, w, h),
			-- SMODS.GUI.operator(op_scale/2),
			-- container("mult", "hand_mult_container", text_scale, w, h),
			-- op(")", op_scale, G.C.RARITY['ovn_corrupted']),
			-- op("^", op_scale, G.C.RARITY['ovn_corrupted']),
			-- container("ovn_instability", "instability_container", text_scale, w, h, G.C.RARITY['ovn_corrupted']),
	end
	},
true
)