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
    key = "quantum",
    atlas = "backs",
    pos = { x = 0, y = 1 },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                if not G.HUD then return false end
                SMODS.set_scoring_calculation('ele_quantum')
                return true
            end
        }))
    end,
}
