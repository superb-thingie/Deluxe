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
G.C.INSTA = HEX('383EFF')
G.C.LILY = HEX('E59499')
G.C.TRANS = HEX('E580C8')
G.C.QUAD = HEX('444444')
G.C.BROWN = HEX('7F450F')
G.C.PURECYAN = HEX('00FFFF')
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
    default_value = G.GAME and G.GAME.ampvalue or 1,
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
SMODS.Scoring_Calculation{
    key = "amp",
    func = function(self, chips, mult, flames)
	    return (chips * mult) / SMODS.get_scoring_parameter(self.mod.prefix..'_amp', flames) 
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_amp'},
    replace_ui = function (self) 
        local div = 1.75
        local w = 2 / div
        local h = 1 / div
        local downamp = 0.8
		local scale = 0.4 / div
            return
        {n=G.UIT.R, config={align = "cm", minh = 1, padding = -0.25}, nodes={
            {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.025}, nodes={
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
                    SMODS.GUI.operator(0)
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'mult',
                            align = 'cm',
                            w = w ,
                            h = h,
                            scale = scale
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cm',
                            w = w,
                            h = h,
                            scale = scale,
                            colour = G.C.GREEN
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    SMODS.GUI.operator(0)
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'mult',
                            align = 'cm',
                            w = w ,
                            h = h,
                            scale = scale,
                            colour = G.C.RARITY.Legendary
                        })
                    }},
                }},
            }},
            {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.025}, nodes={
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cm',
                            w = w,
                            h = h,
                            scale = scale,
                            colour = G.C.MONEY
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    SMODS.GUI.operator(0)
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'mult',
                            align = 'cm',
                            w = w ,
                            h = h,
                            scale = scale,
                            colour = G.C.SECONDARY_SET.Tarot
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cm',
                            w = w,
                            h = h,
                            scale = scale,
                            colour = G.C.INSTA
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    SMODS.GUI.operator(0)
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'mult',
                            align = 'cm',
                            w = w ,
                            h = h,
                            scale = scale,
                            colour = G.C.CLEAR
                        })
                    }},
                }},
            }},
            {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.025}, nodes={
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cm',
                            w = w,
                            h = h,
                            scale = scale,
                            colour = G.C.LILY
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    SMODS.GUI.operator(0)
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'mult',
                            align = 'cm',
                            w = w ,
                            h = h,
                            scale = scale,
                            colour = G.C.PLASMA
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cm',
                            w = w,
                            h = h,
                            scale = scale,
                            colour = G.C.BLACK
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    SMODS.GUI.operator(0)
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'mult',
                            align = 'cm',
                            w = w ,
                            h = h,
                            scale = scale,
                            colour = G.C.TRANS
                        })
                    }},
                }},
            }},
            {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.025}, nodes={
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cm',
                            w = w,
                            h = h,
                            scale = scale,
                            colour = G.C.QUAD
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    SMODS.GUI.operator(0)
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'mult',
                            align = 'cm',
                            w = w ,
                            h = h,
                            scale = scale,
                            colour = G.C.GOLD
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = {
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_chips'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'chips',
                            text = 'chip_text',
                            align = 'cm',
                            w = w,
                            h = h,
                            scale = scale,
                            colour = G.C.BROWN
                        })
                    }},
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    SMODS.GUI.operator(0)
                }},
                {n=G.UIT.C, config={align = 'cm'}, nodes = { 
                    {n=G.UIT.R, config={align = 'cm', id = 'hand_mult'}, nodes={
                        SMODS.GUI.score_container({
                            type = 'mult',
                            align = 'cm',
                            w = w ,
                            h = h,
                            scale = scale,
                            colour = G.C.PURECYAN
                        })
                    }},
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