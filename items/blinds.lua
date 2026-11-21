SMODS.Atlas({
    key = 'blinds',
    path = 'blinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = "candle_final",
    dollars = 8,
    mult = 1,
    atlas = 'blinds',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = HEX("e57a10"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.modify_hand then
                blind.triggered = true
                mult = mod_mult(math.max(math.floor(mult * 0.125), 1))
                hand_chips = mod_chips(math.max(math.floor(hand_chips * 0.125), 0))
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            end
        end
    end
}
SMODS.Blind {
    key = "club_final",
    dollars = 8,
    mult = 3,
    atlas = 'blinds',
    pos = { x = 0, y = 1 },
    boss = { showdown = true },
    boss_colour = HEX("5b9baa"),
    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.blind.disabled then return end
        G.GAME.blind.triggered = false
        if to_number(G.GAME.hands[handname].level) > 1 then
            G.GAME.blind.triggered = true
            if not check then
            level_up_hand(nil, handname, nil, -G.GAME.hands[handname].level + 1)
            end
        end 
    end,
}
SMODS.Blind {
    key = "scepter_final",
    dollars = 8,
    mult = 1.5,
    atlas = 'blinds',
    pos = { x = 0, y = 2 },
    boss = { showdown = true },
    config = { extra = { change = 10 } },
    boss_colour = HEX("6a3847"),
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra.change}}
    end,
    collection_loc_vars = function(self)
        return {vars = {self.config.extra.change}}
    end,
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        for _, card in pairs(cards) do
            G.E_MANAGER:add_event(Event({ trigger = 'after', func = function()
                G.GAME.blind.chips = G.GAME.blind.chips * (1 + self.config.extra.change/100)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                card:juice_up()
                play_sound('xchips', 0.75)
                return true
            end })) 
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('scepter_up')})
        end
        return mult, hand_chips, false
    end
}
SMODS.Blind {
    key = "coin_final",
    dollars = 8,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 3 },
    boss = { showdown = true },
    boss_colour = HEX("50bf7c"),
    loc_vars = function(self)
        local numerator_flip, denominator_flip = SMODS.get_probability_vars(self, 1, 3, 'coin_flip')
        local numerator_debuff, denominator_debuff = SMODS.get_probability_vars(self, 1, 4, 'coin_debuff')
        return { vars = { numerator_flip, denominator_flip, numerator_debuff, denominator_debuff } }
    end,
    calculate = function(self, blind, context)
        if context.hand_drawn then
            if not blind.disabled then
                for _, card in ipairs(context.hand_drawn) do
                    if SMODS.pseudorandom_probability(blind, 'coin_debuff', 1, 4) then
                        card:set_debuff(true)
                        if card.debuff then card.debuffed_by_blind = true end
                    end
                end
            end
        end
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                SMODS.pseudorandom_probability(blind, 'ele_coin_final', 1, 3) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
}
SMODS.Blind {
    key = "hourglass_final",
    dollars = 8,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 4 },
    boss = { showdown = true },
    boss_colour = HEX("efc03c"),
    set_blind = function(self)
        local deck_size = #G.deck.cards
        for i=1, math.floor(deck_size/3) do
            draw_card(G.deck, G.discard)
        end
    end,
}
SMODS.Blind {
    key = "observer",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 5 },
    boss = { min = 1 },
    config = { extra = { amp = 0.25, suit = 'Diamonds' } },
    boss_colour = HEX("5B7FC1"),
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra.amp}}
    end,
    collection_loc_vars = function(self)
        return {vars = {self.config.extra.amp}}
    end,
    calculate = function(self, card, context)
        if G.GAME.blind.disabled then return end
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(self.config.extra.suit) then
            return {
                amp = self.config.extra.amp
            }
        end
    end
}
SMODS.Blind {
    key = "boat",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 6 },
    boss = { min = 1 },
    config = { extra = { amp = 0.25, suit = 'Spades' } },
    boss_colour = HEX("373470"),
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra.amp}}
    end,
    collection_loc_vars = function(self)
        return {vars = {self.config.extra.amp}}
    end,
    calculate = function(self, card, context)
        if G.GAME.blind.disabled then return end
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(self.config.extra.suit) then
            return {
                amp = self.config.extra.amp
            }
        end
    end
}
SMODS.Blind {
    key = "smile",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 7 },
    boss = { min = 1 },
    config = { extra = { amp = 0.25, suit = 'Hearts' } },
    boss_colour = HEX("3F896A"),
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra.amp}}
    end,
    collection_loc_vars = function(self)
        return {vars = {self.config.extra.amp}}
    end,
    calculate = function(self, card, context)
        if G.GAME.blind.disabled then return end
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(self.config.extra.suit) then
            return {
                amp = self.config.extra.amp
            }
        end
    end
}
SMODS.Blind {
    key = "fox",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 8 },
    boss = { min = 1 },
    config = { extra = { amp = 0.25, suit = 'Clubs' } },
    boss_colour = HEX("B26F2C"),
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.extra.amp}}
    end,
    collection_loc_vars = function(self)
        return {vars = {self.config.extra.amp}}
    end,
    calculate = function(self, card, context)
        if G.GAME.blind.disabled then return end
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(self.config.extra.suit) then
            return {
                amp = self.config.extra.amp
            }
        end
    end
}
SMODS.Blind {
    key = "laconism",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 11 },
    atlas = 'blinds',
    boss = { min = 5 },
    boss_colour = HEX("B2BE36"),
    calculate = function(self, blind, context)
        if G.GAME.blind.disabled then return end
        if context.final_scoring_step then
            local compress = ( 2 * mult * hand_chips ) / ( mult + hand_chips )
            local equal = math.sqrt(mult * hand_chips)
            
            mult = mod_mult( (compress + equal) / 2 )
            hand_chips = mod_chips( (compress + equal) / 2 )

            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    local text = localize('compressed')
                        play_sound('gong', 0.94*0.4, 0.6)
                        play_sound('gong', 0.94*0.6, 0.4)
                        play_sound('tarot1', 0.75)
                        ease_colour(G.C.UI_CHIPS, HEX("B2BE36"))
                        ease_colour(G.C.UI_MULT, HEX("B2BE36"))
                        attention_text({
                            scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                        })
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
            delay(0.8)
        end
    end
}