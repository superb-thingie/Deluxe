SMODS.Sound{
    key = "sfx_amp",
    path = "tax.wav",
}
SMODS.Sound{
    key = "sfx_xamp",
    path = "xamp.ogg",
}
SMODS.Sound{
    key = "sfx_chult",
    path = "chult.ogg",
}
SMODS.Gradient {
    key = 'amp',
    colours = {
        HEX('75A881'), HEX('6B8D73')
    },
    cycle = 5,
    interpolation = 'trig'
}
SMODS.Gradient {
    key = 'chult',
    colours = {
        mix_colours(G.C.PLASMA, G.C.UI_CHIPS, 0.75), mix_colours(G.C.PLASMA, G.C.UI_MULT, 0.75)
    },
    cycle = 5,
    interpolation = 'trig'
}
local param_colour = SMODS.Gradients.ele_amp
SMODS.Scoring_Parameter({
    key = 'amp',
    default_value = 1,
	flame_handler = function(self)
		return {
			id = 'flame_'..self.key,
			arg_tab = self.key..'_flames',
            colour = param_colour,
			accent = param_colour
		}
	end,
    colour = param_colour,
    juice_on_update = true,
    calculation_keys = {'amp', 'xamp'},
        calc_effect = function(self, effect, scored_card, key, amount, from_edition)
            if not SMODS.Calculation_Controls.chips then return end
            if key == 'amp' and amount then
                if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
                self:modify(amount)
                card_eval_status_text(scored_card, 'extra', nil, percent, nil,
                    {sound = "ele_sfx_amp", message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {amount..' Tax'}}, colour = self.colour})
                return true
            end
            if key == 'xamp' and amount then
                if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
                self:modify(self.current * (amount) - self.current)
                card_eval_status_text(scored_card, 'extra', nil, percent, nil,
                    {sound = "ele_sfx_xamp", message = localize{type = 'variable', key = amount > 1 and 'a_chips' or 'a_chips_minus', vars = {'X'..amount..' Amp'}}, colour = self.colour})
                return true
            end
        end
})
SMODS.Scoring_Parameter({
    key = 'diviser',
    default_value = 1,
    colour = param_colour,
	flame_handler = function(self)
		return {
			id = 'flame_'..self.key,
			arg_tab = self.key..'_flames',
            colour = param_colour,
            accent = param_colour,
		}
	end,
})
SMODS.Scoring_Parameter({
    key = 'chult',
    default_value = 1,
    colour = SMODS.Gradients.ele_chult,
    calculation_keys = {
        'xchult',
        'x_chips', 'xchips', 'Xchip_mod',
        'x_mult', 'Xmult', 'xmult', 'x_mult_mod', 'Xmult_mod'
    },
        calc_effect = function(self, effect, scored_card, key, amount, from_edition)
            local calculation = G.GAME and G.GAME.current_scoring_calculation
            local uses_chult = false

            if calculation and calculation.parameters then
                for _, parameter in ipairs(calculation.parameters) do
                    if parameter == self.key then
                        uses_chult = true
                        break
                    end
                end
            end
            if uses_chult and (key == 'xchult' 
                or key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod' 
                or key == 'x_mult' or key == 'xmult' or key == 'Xmult' or key == 'x_mult_mod' or key == 'Xmult_mod') 
                and amount then
                
                if uses_chult and (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod' 
                    or key == 'x_mult' or 'x_mult' or key == 'xmult' or key == 'Xmult' 
                    or key == 'x_mult_mod' or key == 'Xmult_mod') then
                    effect.message = nil
                end
                
                if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
                local calculation = G.GAME and G.GAME.current_scoring_calculation

                if calculation and calculation.key == 'ele_hyper_quantum' then
                    -- Reconstruct the original Quantum value
                    local raw_current = 1 + (self.current - 1) * 100

                    -- Apply the new multiplicative effect
                    local raw_new = raw_current * amount

                    -- Convert it back into the reduced Quantum value
                    local reduced_new = 1 + (raw_new - 1) / 100

                    self:modify(reduced_new - self.current)
                else
                    -- Normal Quantum behavior
                    self:modify(self.current * amount - self.current)
                end
                card_eval_status_text(scored_card, 'extra', nil, percent, nil,
                    {sound = "ele_sfx_chult", 
                    message = 'X'..amount..' Quantum', 
                    colour = self.colour})
                return true
            end
            if uses_chult == false and (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod') and amount ~= 1 then
                if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
			    local chips = SMODS.Scoring_Parameters["chips"]
                chips:modify(chips.current * (amount - 1))
                if not effect.remove_default_message then
                    if from_edition then
                        card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type='variable',key= amount > 0 and 'a_xchips' or 'a_xchips_minus',vars={math.abs(amount)}}, Xchips_mod =  amount, colour =  G.C.EDITION, edition = true})
                    else
                        if key ~= 'Xchip_mod' then
                            if effect.xchip_message then
                                card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.xchip_message)
                            else
                                card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'x_chips', amount, percent)
                            end
                        end
                    end
                end
                return true
            end
            if uses_chult == false and (key == 'x_mult' or key == 'xmult' or key == 'Xmult' or key == 'x_mult_mod' or key == 'Xmult_mod') and amount ~= 1 then
                if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
			    local mult = SMODS.Scoring_Parameters["mult"]
                mult:modify(mult.current * (amount - 1))
                if not effect.remove_default_message then
                    if from_edition then
                        card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type='variable',key= amount > 0 and 'a_xmult' or 'a_xmult_minus',vars={amount}}, Xmult_mod =  amount, colour =  G.C.EDITION, edition = true})
                    else
                        if key ~= 'Xmult_mod' then
                            if effect.xmult_message then
                                card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.xmult_message)
                            else
                                card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'x_mult', amount, percent)
                            end
                        end
                    end
                end
                return true
            end
        end
})
SMODS.Scoring_Calculation{
    key = "amp",
    func = function(self, chips, mult, flames)
	    return (chips * mult) / SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames) 
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local w = 2
        local h = 1 * 0.85
        local downamp = 0.8
		local scale = 0.33
            return
        {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
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
                            w = w ,
                            h = h,
                            scale = scale
                        })
                    }},
                }},
            }},
            {n=G.UIT.R, config={align='cm', padding = -0.1}, nodes={
                {n=G.UIT.C, config={align='cm'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_diviser',
                        w = w * 1.5,
                        h = 0.01,
                        scale = 0
                    })
                }}
            }},
            {n=G.UIT.R, config={align = 'cm', padding = 0.075}, nodes={
                {n=G.UIT.C, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_amp',
                        align = 'cm',
                        w = w * downamp,
                        h = h * downamp,
                        scale = scale * downamp
                    })
                }},
            }},
        }}
    end
}
SMODS.Scoring_Calculation{
    key = "quantum",
    func = function(self, chips, mult, flames)
	    return (chips * mult * SMODS.get_scoring_parameter(self.mod.prefix..'_chult', flames) ) / SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames) 
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_chult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local w = 1.3
        local h = w / 2
        local downamp = 0.9
		local scale = 0.25
            return
        {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.05}, nodes={
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'ele_chult',
                            align = 'cr',
                            w = w ,
                            h = h,
                            scale = scale
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = "cl", id = 'hand_operator_container'}, nodes={
                    {n=G.UIT.T, config={text = "X", scale = scale * 2, colour = SMODS.Gradients.ele_chult, shadow = true}},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cm',
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
                            w = w ,
                            h = h,
                            scale = scale
                        })
                    }},
                }},
            }},
            {n=G.UIT.R, config={align='cm', padding = -0.1}, nodes={
                {n=G.UIT.C, config={align='cm'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_amp',
                        w = w * 3,
                        h = 0.01,
                        scale = 0
                    })
                }}
            }},
            {n=G.UIT.R, config={align = 'cm', padding = 0.05}, nodes={
                {n=G.UIT.C, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_amp',
                        align = 'cm',
                        w = w * downamp,
                        h = h * downamp,
                        scale = scale * downamp
                    })
                }},
            }},
        }}
    end
}
SMODS.Scoring_Calculation{
    key = "hyper_quantum",
    func = function(self, chips, mult, flames)
	    return ((chips * mult) ^ SMODS.get_scoring_parameter(self.mod.prefix..'_chult', flames) ) / SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames) 
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_chult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local w = 1.2
        local h = w / 2
        local downamp = 0.9
		local scale = 0.25
            return
        {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.05}, nodes={
                {n=G.UIT.C, config={align = "cl", id = 'hand_operator_container'}, nodes={
                    {n=G.UIT.T, config={text = "(", scale = scale * 2, colour = SMODS.Gradients.ele_chult, shadow = true}},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
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
                            w = w ,
                            h = h,
                            scale = scale
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = "cl", id = 'hand_operator_container'}, nodes={
                    {n=G.UIT.T, config={text = ")", scale = scale * 2, colour = SMODS.Gradients.ele_chult, shadow = true}},
                }},
                {n=G.UIT.C, config={align = "cl", id = 'hand_operator_container'}, nodes={
                    {n=G.UIT.T, config={text = "^", scale = scale * 2, colour = SMODS.Gradients.ele_rainbow, shadow = true}},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'ele_chult',
                            align = 'cl',
                            w = w ,
                            h = h,
                            scale = scale
                        })
                    }},
                }},
            }},
            {n=G.UIT.R, config={align='cm', padding = -0.1}, nodes={
                {n=G.UIT.C, config={align='cm'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_amp',
                        w = w * 3,
                        h = 0.01,
                        scale = 0
                    })
                }}
            }},
            {n=G.UIT.R, config={align = 'cm', padding = 0.05}, nodes={
                {n=G.UIT.C, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_amp',
                        align = 'cm',
                        w = w * downamp,
                        h = h * downamp,
                        scale = scale * downamp
                    })
                }},
            }},
        }}
    end
}
local start_run_ref = Game.start_run
function Game:start_run(args)
    local ret = start_run_ref(self, args)
    SMODS.set_scoring_calculation("ele_amp")
    return ret
end