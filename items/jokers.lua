SMODS.Atlas{
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95
}
SMODS.Atlas{
	key = "mixol",
	path = "mixel.png",
	px = 142,
	py = 190
}


SMODS.Joker {
    key = "cheerful",
	atlas = "jokers",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 3,
    config = { extra = { chips = 30, mult = 4, type = 'Pair' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "goofy",
	atlas = "jokers",
    pos = { x = 1, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    config = { extra = { chips = 50, mult = 6, type = 'Three of a Kind' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "bonkers",
	atlas = "jokers",
    pos = { x = 2, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    config = { extra = { chips = 40, mult = 5, type = 'Two Pair' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "insane",
	atlas = "jokers",
    pos = { x = 3, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    config = { extra = { chips = 50, mult = 6, type = 'Straight' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "comical",
	atlas = "jokers",
    pos = { x = 4, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    config = { extra = { chips = 40, mult = 5, type = 'Flush' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "cardboard_joker",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 1 },
	atlas = "jokers",
    config = { extra = { mult_up = 2, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } },
                colour = G.C.RED,
                delay = 0.45
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}
SMODS.Joker {
    key = "magnet",
    atlas = "jokers",
    pos = { x = 1, y = 1 },
    cost = 7,
    rarity = 2,
    config = {
        extra = {
            mult = 10,
            chips = 50
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_steel') then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker {
    key = "erratic",
    atlas = "jokers",
    pos = { x = 2, y = 1 },
    cost = 9,
    rarity = 3,
    config = { extra = { chips = 40, mult = 7, amp = 0.1 } },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.ele_erratic_card or {}).suit or 'Spades'
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.amp, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
		if not G.GAME.current_round.ele_erratic_card then
			G.GAME.current_round.ele_erratic_card = { suit = 'Spades' }
		end
		local current = G.GAME.current_round.ele_erratic_card
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(current.suit) then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                amp = card.ability.extra.amp
            }
        end
    end
}

local function reset_ele_erratic_card()
	G.GAME.current_round.ele_erratic_card = G.GAME.current_round.ele_erratic_card or { suit = 'Spades' }
	local erratic_suits = {}
	for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
		if v ~= G.GAME.current_round.ele_erratic_card.suit then erratic_suits[#erratic_suits + 1] = v end
	end
	local erratic_card = pseudorandom_element(erratic_suits, 'ele_erratic' .. G.GAME.round_resets.ante)
	G.GAME.current_round.ele_erratic_card.suit = erratic_card
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_ele_erratic_card()
end
SMODS.Joker {
    key = "geiger",
    atlas = "jokers",
    pos = { x = 3, y = 1 },
    cost = 7,
    rarity = 2,
    config = { extra = { mult = 0, gain = 4, amp = 0, amp_gain = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.mult, card.ability.extra.gain, card.ability.extra.amp, card.ability.extra.amp_gain}
        }
    end,
    calculate = function (self, card, context)
        if context.after and not context.blueprint then
            if SMODS.last_hand_oneshot then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                return{
                    message = (localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.gain}}),
                }
            else
                card.ability.extra.amp = card.ability.extra.amp + card.ability.extra.amp_gain
                return{
                    message = localize('oops'),
                    colour = SMODS.Gradient.ele_amp,
                }
            end
        end
        if context.joker_main then
            return{
                mult = card.ability.extra.mult,
                amp = card.ability.extra.amp
            }
        end
    end
}
SMODS.Joker {
    key = "mint",
    atlas = "jokers",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    pos = { x = 4, y = 1 },
    config = { extra = { mult_loss = 4, mult = 40, amp_gain = 0.05, amp = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amp, card.ability.extra.amp_gain, card.ability.extra.mult, card.ability.extra.mult_loss,  } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.amp - card.ability.extra.amp_loss <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('eaten'),
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.amp = card.ability.extra.amp + card.ability.extra.amp_gain
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_loss
                return {
                    message = localize('mint_loss'), colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                amp = card.ability.extra.amp,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "spectro",
    atlas = "jokers",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    pos = { x = 0, y = 2 },
    config = { extra = { mult = 7, amp = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amp, card.ability.extra.mult } }
    end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			return {
				amp = card.ability.extra.amp,
				mult = card.ability.extra.mult
			}
		end
	end
}
SMODS.Joker {
    key = "speaker",
    atlas = "jokers",
    pos = { x = 1, y = 2 },
    cost = 8,
    rarity = 2,
    config = {
        extra = {
            amp = 0.5,
            xmult = 4
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amp, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if  context.before and #context.full_hand == 4 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.joker_main and #context.full_hand ~= 4 then
            return {
                amp = card.ability.extra.amp
            }
        end
    end
}
SMODS.Joker {
    key = 'wave',
    config = { extra = { amp = 0.5, positive = true } },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    pos = { x = 4, y = 2 },
    atlas = 'jokers',
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amp } }
    end,
    calculate = function(self, card, context)
        local config = card.ability.extra
        if context.joker_main then
            return {
                amp = card.ability.extra.positive and card.ability.extra.amp or -card.ability.extra.amp
            }
        end
        if context.after and not context.blueprint then
            card.ability.extra.positive = not card.ability.extra.positive
        end
    end
}
SMODS.Joker {
    key = "stonks",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'jokers',
    pos = { x = 0, y = 3 },
    config = { extra = { mult = 1, chips = 5, dollars = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.dollars, card.ability.extra.chips * math.max(math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars), 0), card.ability.extra.mult * math.max(math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars), 0) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars),
                mult = card.ability.extra.mult * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)
            }
        end
    end,
}
SMODS.Joker {
    key = "brain",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'jokers',
    pos = { x = 2, y = 2 },
    config = { extra = { ratio_chips = 4, ratio_mult = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ratio_chips, card.ability.extra.ratio_mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local balance = (mult + hand_chips) / 5
            
            mult = mod_mult(balance)
            hand_chips = mod_chips(balance * 4)
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, mix_colours(G.C.PLASMA, G.C.UI_CHIPS, 0.25))
                    ease_colour(G.C.UI_MULT, mix_colours(G.C.PLASMA, G.C.UI_MULT, 0.25))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  0.8,
                        func = (function()
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
                                ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  1.3,
                        func = (function()
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
            return {
                message = localize('balanced'),
                colour = G.C.PLASMA
            }
        end       
    end,
}
SMODS.Joker {
    key = "majestic",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = 'jokers',
    pos = { x = 2, y = 3 },
    config = { extra = { mult = 12, type = 'ele_blaze' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "deceitful",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = 'jokers',
    pos = { x = 3, y = 3 },
    config = { extra = { chips = 80, type = 'ele_blaze' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker {
    key = "court",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'jokers',
    pos = { x = 4, y = 3 },
    config = { extra = { xmult = 3, type = 'ele_blaze' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
SMODS.Joker {
    key = "glorious",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = 'jokers',
    pos = { x = 1, y = 3 },
    config = { extra = { chips = 40, mult = 6, type = 'ele_blaze' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "mixel",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'mixol',
    pos = { x = 0, y = 0 },
    display_size = { w = 71, h = 95 },
    config = { extra = { mult = 6, amp = 0.1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.amp } }
    end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local ranks = {}
			local unique_ranks = 0
			for _, m in ipairs(context.scoring_hand) do
				if not SMODS.has_no_rank(m) and not m.debuff then
					local id = m:get_id()
					if not ranks[id] then
						ranks[id] = true
						unique_ranks = unique_ranks + 1
					end
				end
                
            local matching_ranks = 0

            for _, m in ipairs(context.scoring_hand) do
                if not SMODS.has_no_rank(m) and not m.debuff then
                    local id = m:get_id()

                    if ranks[id] then
                        matching_ranks = matching_ranks + 1
                    else
                        ranks[id] = true
                    end
                end
            end

            return {
                mult = card.ability.extra.mult * unique_ranks,
                amp = card.ability.extra.amp * matching_ranks - card.ability.extra.amp,
            }
            end
		end
	end,
}