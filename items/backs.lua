SMODS.Atlas{
	key = "backs",
	path = "back.png",
	px = 71,
	py = 95
}
SMODS.Back {
    key = "lightning",
    atlas = "backs",
    pos = { x = 0, y = 0 },
    calculate = function(self, back, context)
        if G.GAME.selected_sleeve == "sleeve_ele_lightning" then return end
        if context.initial_scoring_step then
            local equal = math.sqrt(mult * hand_chips)
            
            mult = mod_mult(equal)
            hand_chips = mod_chips(equal)

            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    local text = localize('equalized')
                        play_sound('gong', 0.94*0.75, 0.3)
                        play_sound('gong', 0.94*1.125, 0.2)
                        play_sound('tarot1', 1.5)
                        ease_colour(G.C.UI_CHIPS, G.C.GOLD)
                        ease_colour(G.C.UI_MULT, G.C.GOLD)
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
    end,
    apply = function(self, back)
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
}

SMODS.Back {
    key = "luxury",
    atlas = "backs",
    pos = { x = 1, y = 0 },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, #G.playing_cards do
                    if G.playing_cards[i]:get_id() == 14 then
                        G.playing_cards[i]:set_ability("m_gold", nil, nil)
                    end
                end
                return true
            end
        }))
    end,
}
SMODS.Back {
    key = "crit",
    atlas = "backs",
    pos = { x = 1, y = 1 },
    config = { extra = { repetitions = 1, amp = 0.1, crit_chance = 3, crit_fail = 9 } },
    loc_vars = function(self)
        local num, denom = SMODS.get_probability_vars(self, 1, self.config.extra.crit_chance, 'ele_crit')
        local e, bad_denom = SMODS.get_probability_vars(self, 1, self.config.extra.crit_fail, 'ele_crit')
        return { vars = { num, denom, bad_denom, self.config.extra.amp } }
    end,
	calculate = function(self, card, context)
        if G.GAME.selected_sleeve == "sleeve_ele_crit" then return end
		if context.repetition and context.cardarea == G.play then
			if SMODS.pseudorandom_probability(self, "ele_crit", 1, self.config.extra.crit_chance, "Critical Deck") then
                return {
                    repetitions = self.config.extra.repetitions
                },
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.crit_particles = Particles(1, 1, 0, 0, {
                            timer = 0.015,
                            scale = 0.3,
                            initialize = true,
                            lifespan = 1,
                            speed = 1.1,
                            padding = -1,
                            attach = G.ROOM_ATTACH,
                            colours = {
                                G.C.WHITE,
                                G.C.GOLD,
                                G.C.DARK_EDITION,
                            },
                            fill = true
                        })
                        G.crit_particles.fade_alpha = 1
                        G.crit_particles:fade(0.2, 0)
                        return true
                    end
                })),
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = (function()
                        local text = localize('crit')
                        play_sound('multhit2', 0.7)
                        play_sound('tarot1')
                        attention_text({
                            scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                        })
                        return true
                    end)
                })),
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        G.crit_particles:fade(0.5)
                        return true
                    end
                })),
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        G.crit_particles:remove()
                        G.crit_particles = nil
                        return true
                    end
                }))
            end
        end
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(self, "ele_crit", 1, self.config.extra.crit_chance, "Critical Deck") then return end
            if SMODS.pseudorandom_probability(self, "ele_crit", 1, self.config.extra.crit_fail, "Critical Deck") then
                return {
                    amp = self.config.extra.amp
                },
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        local text = localize('fail')
                            play_sound('tarot1')
                            attention_text({
                                scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                            })
                        return true
                    end)
                }))
            end
        end
    end
}
SMODS.Back {
    key = "bec",
    atlas = "backs",
    pos = { x = 0, y = 1 },
    apply = function(self, back)
    if G.GAME.selected_sleeve == "sleeve_ele_bec" then return end
        G.E_MANAGER:add_event(Event({
            func = function()
                if not G.HUD then return false end
                SMODS.set_scoring_calculation('ele_bec')
                play_sound('tarot1')
                return true
            end
        }))
        G.GAME.compress_scaling = true
    end,
}
SMODS.Back {
    key = "ultraviolet",
    atlas = "backs",
    pos = { x = 2, y = 0 },
    config = { extra = { cards = 8, base_tax = 0.4, base_tax_down = 0.8 } },
    loc_vars = function(self)
        return { vars = { self.config.extra.cards, self.config.extra.base_tax, self.config.extra.base_tax_down } }
    end,
    calculate = function(self, back, context)
        if context.final_scoring_step then
            local tax = SMODS.Scoring_Parameters.ele_amp
            tax.default_value = tax.default_value + self.config.extra.base_tax
            tax.current = tax.default_value
            update_hand_text({delay = 0}, {
                [tax.key] = tax.current
            })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = (function()
                    play_sound('ele_sfx_amp')
                    return true
                end)
            }))
            G.GAME.ultraviolet_pitch_count = 0
        end
        if context.individual and context.cardarea == G.play and (
            SMODS.has_enhancement(context.other_card, 'm_ele_opposite') or
            SMODS.has_enhancement(context.other_card, 'm_ele_invert') or
            SMODS.has_enhancement(context.other_card, 'm_ele_lead') or
            SMODS.has_enhancement(context.other_card, 'm_ele_corrupt') or
            SMODS.has_enhancement(context.other_card, 'm_ele_radio') or
            SMODS.has_enhancement(context.other_card, 'm_ele_mag') or
            SMODS.has_enhancement(context.other_card, 'm_ele_fragile') or
            SMODS.has_enhancement(context.other_card, 'm_ele_hollow') ) then
            
            G.GAME.ultraviolet_pitch_count =
                (G.GAME.ultraviolet_pitch_count or 0) + 0.2
            local tax = SMODS.Scoring_Parameters.ele_amp
            tax.default_value = tax.default_value * self.config.extra.base_tax_down
            tax.current = tax.default_value
            update_hand_text({delay = 0}, {
                [tax.key] = tax.current
            }) 

            local pitch = 1 - (G.GAME.ultraviolet_pitch_count - 0.999) / (#G.play - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = (function()
                    play_sound('ele_sfx_up', pitch)
                    return true
                end)
            }))
        end
    end,
apply = function(self, back)
    G.E_MANAGER:add_event(Event({
        func = function()
            local pool = {}
            for _, card in ipairs(G.playing_cards) do
                pool[#pool + 1] = card
            end
            for i = 1, math.min(self.config.extra.cards, #pool) do
                local selected = pseudorandom_element(pool, pseudoseed('ultraviolet' .. i))
                local attenuator = SMODS.poll_enhancement {
                    key = "ele_utraviolet",
                    guaranteed = true,
                    options = {
                        'm_ele_opposite', 'm_ele_invert', 'm_ele_lead',
                        'm_ele_radio', 'm_ele_mag', 'm_ele_corrupt',
                        'm_ele_fragile',
                    }
                }
                selected:set_ability(attenuator, nil, nil)
                for j, card in ipairs(pool) do
                    if card == selected then
                        table.remove(pool, j)
                        break
                    end
                end
            end
            return true
        end
    }))
end
}

