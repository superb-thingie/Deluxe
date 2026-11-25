SMODS.Atlas{
	key = "spectrals",
	path = "spectrals.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = 'duality',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    atlas = 'spectrals',
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound("card1", percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local aura_card = G.hand.highlighted[1]
                aura_card:set_edition('e_polychrome', true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local attenuator = SMODS.poll_enhancement { 
                    key = "ele_duality", 
                    guaranteed = true, 
                    options = { 
                        'm_ele_opposite', 'm_ele_invert','m_ele_lead',
                        'm_ele_radio', 'm_ele_mag','m_ele_corrupt', 
                        'm_ele_fragile',
                    } 
                }
                local aura_card = G.hand.highlighted[1]
                aura_card:set_ability(attenuator, true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound("card1", percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted > 0 and
            (not G.hand.highlighted[1].edition)
    end
}

SMODS.Consumable {
    key = 'invert',
    set = 'Spectral',
    pos = { x = 1, y = 0 },
    atlas = 'spectrals',
    config = { max_highlighted = 4, min_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        local rightmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand.highlighted[i]
            end
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i] ~= rightmost then
                    G.hand.highlighted[i]:set_ability(rightmost.config.center)
                    card:juice_up(0.3, 0.5)
                end
            return true end }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local attenuator = SMODS.poll_enhancement { 
                    key = "ele_duality", 
                    guaranteed = true, 
                    options = { 
                        'm_ele_opposite', 'm_ele_invert','m_ele_lead',
                        'm_ele_radio', 'm_ele_mag','m_ele_corrupt', 
                        'm_ele_fragile',
                    } 
                }
                rightmost:set_ability(attenuator, true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted > 1
    end
}

SMODS.Consumable {
    key = 'tung',
    set = 'Spectral',
    pos = { x = 0, y = 1 },
    atlas = 'spectrals',
    config = { extra = { cards = 4 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_ele_lead
        return { vars = { G.GAME.ele_tung_hand or 1, card.ability.extra.cards } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                G.GAME.ele_tung_hand = G.GAME.ele_tung_hand or 1
                G.hand:change_size(G.GAME.ele_tung_hand)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra.cards do
                    local numbers = {}
                    for _, rank_key in ipairs(SMODS.Rank.obj_buffer) do
                        local rank = SMODS.Ranks[rank_key]
                        table.insert(numbers, rank)
                    end
                    local _rank = pseudorandom_element(numbers, 'ele_tung_create').card_key
                    cards[i] = SMODS.add_card { set = "Base", rank = _rank, enhancement = 'm_ele_lead', key_append = "ele_tung_card" }
                end
                SMODS.calculate_context({ playing_card_added = true, cards = cards })
                return true
            end
        }))
        delay(0.3)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 1
    end,
}
SMODS.Consumable {
    key = 'draw',
    set = 'Spectral',
    pos = { x = 1, y = 1 },
    atlas = 'spectrals',
    config = { extra = { cards = 4, dollars = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.cards } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra.cards do
                    local numbers = {}
                    for _, rank_key in ipairs(SMODS.Rank.obj_buffer) do
                        local rank = SMODS.Ranks[rank_key]
                        table.insert(numbers, rank)
                    end
                    local _rank = pseudorandom_element(numbers, 'ele_draw_cards').card_key
                    local attenuator = SMODS.poll_enhancement { 
                        key = "ele_duality", 
                        guaranteed = true, 
                        options = { 
                            'm_ele_opposite', 'm_ele_invert','m_ele_lead',
                            'm_ele_radio', 'm_ele_mag','m_ele_corrupt', 
                            'm_ele_fragile',
                        } 
                    }
                    cards[i] = SMODS.add_card { set = "Base", rank = _rank, enhancement = attenuator, key_append = "vremade_incantation_card" }
                end
                SMODS.calculate_context({ playing_card_added = true, cards = cards })
                return true
            end
        }))
        ease_dollars(card.ability.extra.dollars)
        delay(0.3)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 1
    end,
}
