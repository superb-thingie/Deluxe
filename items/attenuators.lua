SMODS.Atlas{
	key = "attens",
	path = "attenuators.png",
	px = 71,
	py = 95
}

SMODS.Enhancement {
    key = 'opposite',
    pos = { x = 0, y = 0 },
	atlas = "attens",
    config = { bonus = -20 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus } }
    end
}
SMODS.Enhancement {
    key = 'invert',
    pos = { x = 1, y = 0 },
	atlas = "attens",
    config = { mult = -3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end
}
SMODS.Enhancement {
    key = 'lead',
    pos = { x = 0, y = 1 },
	atlas = "attens",
    config = { h_x_mult = 0.8 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_mult } }
    end
}
SMODS.Enhancement {
    key = 'radio',
    pos = { x = 1, y = 1 },
	atlas = "attens",
    config = { extra = { nope = 0.4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.nope } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.before then
            G.GAME.probabilities.normal = G.GAME.probabilities.normal - 0.4
        end
        if context.cardarea == G.hand and context.after then
            G.GAME.probabilities.normal = G.GAME.probabilities.normal + 0.4
        end
    end,
}
SMODS.Enhancement {
    key = 'mag',
    pos = { x = 2, y = 1 },
	atlas = "attens",
    calculate = function(self, card, context)
        if context.hand_drawn then
            local any_forced = nil
            if card.ability.forced_selection then
                any_forced = true
            end
            if not any_forced then
                G.hand:unhighlight_all()
                card.ability.forced_selection = true
                G.hand:add_to_highlighted(card, true)
            end
        end
    end,
}
SMODS.Enhancement {
    key = 'corrupt',
    pos = { x = 0, y = 2 },
	atlas = "attens",
    config = { extra = { 
		min_mult = -2,
		max_mult = 0,
		min_chips = -10,
		max_chips = 0,
		min_amp = 0,
		max_amp = 10,
		max_amp_actual = 1,
    } },
    loc_vars = function(self, info_queue, card)
        local r_mults = {}
        for i = card.ability.extra.min_chips, card.ability.extra.max_amp_actual do
            r_mults[#r_mults + 1] = tostring(i)
        end
        local loc_mult = ' ' .. (localize('k_mult')) .. ' '
        local main_start = {
            { n = G.UIT.T, config = { text = '  ', colour = G.C.MULT, scale = 0.32 } },
            { n = G.UIT.O, config = { 
                object = DynaText({ string = r_mults, colours = { G.C.RED }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'chips', colour = G.C.UI.TEXT_DARK }, { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#1#", colour = G.C.RED },
                            loc_mult, { string = 'chips', colour = G.C.UI.TEXT_DARK }, { string = 'Tax', colour = G.C.UI.TEXT_DARK }, { string = "#2#", colour = G.C.BLUE }, 
                            loc_mult, { string = 'chips', colour = G.C.UI.TEXT_DARK }, { string = 'Tax', colour = G.C.UI.TEXT_DARK }, { string = "#3#", colour = SMODS.Gradients.ele_amp }, 
                            loc_mult, { string = 'chips', colour = G.C.UI.TEXT_DARK }, { string = 'Tax', colour = G.C.UI.TEXT_DARK },
                            loc_mult, { string = 'chips', colour = G.C.UI.TEXT_DARK }, { string = 'Tax', colour = G.C.UI.TEXT_DARK } },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { main_start = main_start }
    end,
    calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			return {
				mult = pseudorandom("ele_corrupt_mult", card.ability.extra.min_mult, card.ability.extra.max_mult),
				chips = pseudorandom("ele_corrupt_chips", card.ability.extra.min_chips, card.ability.extra.max_chips),
                amp = pseudorandom("ele_corrupt_amp", card.ability.extra.min_amp, card.ability.extra.max_amp) * 0.1,
			}
		end
    end,
}
SMODS.Enhancement {
    key = 'fragile',
    pos = { x = 1, y = 2 },
    atlas = "attens",
    config = { Xmult = 0.75, extra = { odds = 2 } },
    shatters = true,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'ele_fragile')
        return { vars = { card.ability.Xmult, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and
            SMODS.pseudorandom_probability(card, 'ele_fragile', 1, card.ability.extra.odds) then
            card.glass_trigger = true
            return { remove = true }
        end
    end,
}
SMODS.Enhancement {
    key = 'hollow',
    pos = { x = 2, y = 0 },
    atlas = "attens",
    shatters = true,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
            return { remove = true }
        end
    end,
}
  
  


