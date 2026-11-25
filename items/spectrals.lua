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
