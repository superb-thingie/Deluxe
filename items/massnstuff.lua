SMODS.Sound{
    key = "sfx_amp",
    path = "amp_old.ogg",
}
SMODS.Sound{
    key = "sfx_xamp",
    path = "xamp.ogg",
}

SMODS.Scoring_Parameter({
  key = 'amp',
  default_value = G.GAME and G.GAME.ampvalue or 1,
	flame_handler = function(self)
		return {
			id = 'flame_'..self.key,
			arg_tab = self.key..'_flames',
			colour = G.C.AMP,
			accent = SMODS.Scoring_Parameters.chips.lick
		}
	end,
  colour = G.C.AMP,
  calculation_keys = {'amp', 'xamp'},
    calc_effect = function(self, effect, scored_card, key, amount, from_edition)
		if not SMODS.Calculation_Controls.chips then return end
	    if key == 'amp' and amount then
	        if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
	        self:modify(amount)
	        card_eval_status_text(scored_card, 'extra', nil, percent, nil,
	            {sound = "ele_sfx_amp", message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {amount..' Amp'}}, colour = self.colour})
	        return true
        end
        if key == 'xamp' and amount then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
            self:modify(self.current * (amount) - self.current)
            card_eval_status_text(scored_card, 'extra', nil, percent, nil,
                {sound = "ele_sfx_xamp", message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {'X'..amount}}, colour = self.colour})
            return true
        end
    end
})

SMODS.Scoring_Calculation{
    key = "amp",
    func = function(self, chips, mult, flames)
	    return ( chips * mult ) * SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames)
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local down = 0.8
        local w = 1.775
        local h = 1
		local scale = 0.4
		local downop = 0.75
        return
        {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.075}, nodes={
            {n=G.UIT.C, config={align = 'cm'}, nodes = { 
    			{n=G.UIT.R, config={align = 'cl', id = 'hand_ele_amp'}, nodes={
    				SMODS.GUI.score_container({
    					type = 'ele_amp',
    					align = 'cr',
    					w = w * down,
    					h = h * down,
    					scale = scale * down
    				})
    			}},
    		}},
			{n=G.UIT.C, config={align = "cl", id = 'hand_operator_container'}, nodes={
				{n=G.UIT.T, config={text = "X", scale = scale * 1.5 * downop, colour = G.C.AMP, shadow = true}},
			}},
            {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'chips',
                        text = 'chip_text',
                        align = 'cm',
                        w = w * down,
                        h = h * down,
						scale = scale * down,
                    })
                }},
            }},
            {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                SMODS.GUI.operator(scale * down * downop)
            }},
            {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'mult',
                        align = 'cl',
                        w = w * down,
                        h = h * down,
						scale = scale * down,
                    })
                }},
            }},
        }}
    end
}


SMODS.Scoring_Calculation{
    key = "default",
    func = function(self, chips, mult, flames)
	    return ( chips * mult ) * SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames)
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local down = 1
        local w = 2
        local h = 1
		local scale = 0.4
		local downop = 1
        return
        {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
            {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                {n=G.UIT.R, config={align = 'cr', id = 'hand_chips'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'chips',
                        text = 'chip_text',
                        align = 'cr',
                        w = w,
                        h = h,
						scale = scale
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
                        w = w,
                        h = h,
						scale = scale,
                    })
                }},
            }},
        }}
    end
}

SMODS.Scoring_Calculation{
    key = "xtra",
    func = function(self, chips, mult, flames)
	    return ( chips + SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames) ) * mult
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local wamp = 1.4
        local hamp = 0.5
        local scamp = 0.2
        local w = 2
        local h = 1
		local scale = 0.4
        return
            {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cr',
                            w = w,
                            h = h,
    						scale = scale,
                            })
                        }},
        			{n=G.UIT.R, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
            			{n=G.UIT.R, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
            				SMODS.GUI.score_container({
            					type = 'ele_amp',
            					align = 'cr',
            					w = wamp,
            					h = hamp,
            					scale = scamp,
            					colour = G.C.GOLD
            				}),
            			{n=G.UIT.R, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
                    			{n=G.UIT.T, config={text = "+", scale = scale * 1.4,
                    	colour = G.C.GOLD, shadow = true}},
                        }},
                        }},
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
                                w = w,
                                h = h,
        						scale = scale
                            })
                        }},
                    }},
                }}
    end
}

SMODS.Scoring_Calculation{
    key = "quantum",
    func = function(self, chips, mult, flames)
	    return chips * mult * SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames)
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local w = 3
        local h = 1
		local scale = 0.4
        return
        {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
            {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                SMODS.GUI.operator(scale)
            }},
            {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'mult',
                        align = 'cl',
                        w = w,
                        h = h,
						scale = scale,
                    })
                }},
            }},
        }}
    end
}
    local start_run_ref = Game.start_run
    function Game:start_run(args)
        local ret = start_run_ref(self, args)
        SMODS.set_scoring_calculation("ele_default")
        return ret
    end