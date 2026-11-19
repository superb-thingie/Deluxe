SMODS.Atlas{
	key = "enhancers",
	path = "enhance.png",
	px = 71,
	py = 95
}

SMODS.Enhancement {
    key = 'div',
    pos = { x = 0, y = 0 },
	atlas = "enhancers",
    config = { amp = 0.1, mult = 8 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.amp, card.ability.mult } }
    end,
	calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {amp = card.ability.amp, mult = card.ability.mult}
        end
	end

}
  
  


