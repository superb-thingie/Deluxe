SMODS.Atlas {
    key = "sleeves",
    path = "sleeves.png",
    px = 73,
    py = 95
}

CardSleeves.Sleeve {
    key = "lightning",
    atlas = "sleeves",
    pos = { x = 0, y = 0 },
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_ele_lightning" then
            key = self.key .. "_alt"
        else
            key = self.key
        end
        return { key = key }
    end,
    calculate = function(self, sleeve, context)
        if context.initial_scoring_step then
            if self.get_current_deck_key() == "b_ele_lightning" then
                local equalize = (hand_chips + mult) / 2
                
                hand_chips = mod_chips(equalize)
                mult = mod_mult(equalize)

                update_hand_text({delay = 0}, { hand_chips = equalize, mult = equalize })
                G.E_MANAGER:add_event(Event({
                    func = (function()
                    local text = localize('balanced')
                        play_sound('gong', 1.2, 0.2)
                        play_sound('gong', 1.2*1.5, 0.1)
                        play_sound('tarot1', 1.6, 0.8)
                        ease_colour(G.C.UI_MULT, G.C.PLASMA)
                        ease_colour(G.C.UI_CHIPS, G.C.PLASMA)
                        attention_text({
                            scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            blockable = false,
                            blocking = false,
                            delay =  0.8,
                            func = (function()
                                    ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                                    ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
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
                                G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                                G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                                return true
                            end)
                        }))
                        return true
                    end)
                }))
                delay(0.8)
            else
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
                return true
            end
        end
    end,
    apply = function(self, back)
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
}
CardSleeves.Sleeve {
    key = "luxury",
    atlas = "sleeves",
    pos = { x = 1, y = 0 },
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_ele_luxury" then
            key = self.key .. "_alt"
        else
            key = self.key
        end
        return { key = key }
    end,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == "b_ele_luxury" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i = 1, #G.playing_cards do
                        if G.playing_cards[i]:get_id() == 13 then
                            G.playing_cards[i]:set_ability("m_steel", nil, nil)
                        end
                    end
                    return true
                end
            }))
        end
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
CardSleeves.Sleeve {
    key = "crit",
    atlas = "sleeves",
    pos = { x = 3, y = 0 },
    config = { extra = { repetitions = 1, amp = 0.1, crit_chance = 3, crit_fail = 9 } },
    loc_vars = function(self)
        local num, denom = SMODS.get_probability_vars(self, 1, self.config.extra.crit_chance, 'ele_crit')
        local e, bad_denom = SMODS.get_probability_vars(self, 1, self.config.extra.crit_fail, 'ele_crit')
        local key
        if self.get_current_deck_key() == "b_ele_crit" then
            key = self.key .. "_alt"
        else
            key = self.key
        end
        return { key = key, vars = { num, denom, bad_denom, self.config.extra.amp } }
    end,
	calculate = function(self, card, context)
        if self.get_current_deck_key() == "b_ele_crit" then
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
                                play_sound('ele_sfx_crit', 1, 0.7)
                                play_sound('tarot1')
                                attention_text({
                                    scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                                })
                            return true
                        end)
                    })),
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 1,
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
        end
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
                            play_sound('ele_sfx_crit', 1, 0.7)
                            play_sound('tarot1')
                            attention_text({
                                scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                            })
                        return true
                    end)
                })),
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
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
            if SMODS.pseudorandom_probability(self, "ele_crit", 1, self.config.extra.crit_fail, "Critical Deck")
            and not SMODS.pseudorandom_probability(self, "ele_crit", 1, self.config.extra.crit_chance, "Critical Deck") then
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
CardSleeves.Sleeve {
    key = "bec",
    atlas = "sleeves",
    pos = { x = 2, y = 0 },
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_ele_bec" then
            key = self.key .. "_alt"
        else
            key = self.key
        end
        return { key = key }
    end,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == "b_ele_bec" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if not G.HUD then return false end
                    SMODS.set_scoring_calculation('ele_super_bec')
                    play_sound('tarot1')
                    return true
                end
            }))
            G.GAME.compress_scaling = true
        end
        if not self.get_current_deck_key() == "b_ele_bec" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if not G.HUD then return false end
                    SMODS.set_scoring_calculation('ele_bec')
                    play_sound('tarot1')
                    return true
                end
            }))
            G.GAME.compress_scaling = true
        end
    end,
}