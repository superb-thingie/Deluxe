SMODS.Sound{
    key = "sfx_amp",
    path = "tax.wav",
}
SMODS.Sound{
    key = "sfx_xamp",
    path = "xamp.ogg",
}
SMODS.Gradient {
    key = 'amp',
    colours = {
        HEX('75A881'), HEX('6B8D73')
    },
    cycle = 5,
    interpolation = 'trig'
}

SMODS.Scoring_Parameter({
    key = 'amp',
    default_value = G.GAME and G.GAME.ampvalue or 1,
    colour = SMODS.Gradients.ele_amp,
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
    default_value = G.GAME and G.GAME.ampvalue or 1,
    colour = SMODS.Gradients.ele_amp,
    juice_on_update = true,
})
SMODS.Scoring_Calculation{
    key = "amp",
    func = function(self, chips, mult, flames)
	    return (chips * mult) / SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames) 
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local w = 2
        local h = 1
        local downamp = 0.8
		local scale = 0.4
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
                            scale = scale,
                            colour = G.C.UI_CHIPS
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
                            colour = G.C.UI_MULT
                        })
                    }},
                }},
            }},
            {n=G.UIT.R, config={align='cm', padding = -0.1}, nodes={
                {n=G.UIT.C, config={align='cm'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_diviser',
                        w = w * 2,
                        h = 0.05,
                        scale = 0,
                        -- colour = SMODS.Gradients.ele_amp
                        colour = G.C.SALT
                    })
                }}
            }},
            {n=G.UIT.R, config={align = 'cm', padding = 0.075}, nodes={
                {n=G.UIT.C, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_amp',
                        align = 'cr',
                        w = w * 0.9 * downamp,
                        h = h * 0.9 * downamp,
                        scale = scale * 0.9 * downamp,
                        colour = SMODS.Gradients.ele_amp
                    })
                }},
                {n=G.UIT.C, config={align = "cl", id = 'hand_operator_container'}, nodes={
                    {n=G.UIT.T, config={text = "X", scale = scale * 2 * downamp, colour = G.C.ELEC, shadow = true}},
                }},
                {n=G.UIT.C, config={align = 'cm', id = 'hand_ele_amp'}, nodes={
                    SMODS.GUI.score_container({
                        type = 'ele_amp',
                        align = 'cl',
                        w = w * 0.9 * downamp,
                        h = h * 0.9 * downamp,
                        scale = scale * 0.9 * downamp,
                        colour = G.C.ELEC
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