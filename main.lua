SMODS.Atlas{
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}
SMODS.Atlas({
  key = "balatro",
  path = "balatro.png",
  px = 333,
  py = 216,
  prefix_config = { key = false },
})
SMODS.Sound{
    key = "sfx_crit",
    path = "critical_hit.ogg",
}
G.C.MINT = HEX('75A881')
G.C.PLASMA = HEX('C863D6')
G.C.METAL = HEX('d4b79b')
G.C.GOLD = HEX('E0AC55')
G.C.BAD_CHIPS = HEX('FF5D00')
G.C.BAD_MULT = HEX('5BE0E5')
SMODS.Gradient {
    key = "rainbow",
    colours = {
        HEX("e0483e"),
        HEX("fda200"),
        HEX("8dae5f"),
        HEX("33966e"),
        HEX("403fb2"),
        HEX("726ca0"),
        HEX("ae6c98"),

    },
    cycle = 5
}
SMODS.Gradient {
    key = "attenuator",
    colours = {
        HEX("FF5D00"),
        HEX("5BE0E5"),

    },
    cycle = 4
}

assert(SMODS.load_file("items/tax.lua"))()
assert(SMODS.load_file("items/enhancers.lua"))()
assert(SMODS.load_file("items/attenuators.lua"))()
assert(SMODS.load_file("items/editions.lua"))()
assert(SMODS.load_file("items/backs.lua"))()
assert(SMODS.load_file("items/tarots.lua"))()
assert(SMODS.load_file("items/spectrals.lua"))()
assert(SMODS.load_file("items/jokers.lua"))()
assert(SMODS.load_file("items/blinds.lua"))()
assert(SMODS.load_file("items/tags.lua"))()
assert(SMODS.load_file("crossmod/boss.lua"))()

if next(SMODS.find_mod("CardSleeves")) then
    assert(SMODS.load_file("crossmod/sleeves.lua"))()
end
if next(SMODS.find_mod("Maximus")) then
    assert(SMODS.load_file("crossmod/maximus.lua"))()
end
if next(SMODS.find_mod("abandonia")) then
    assert(SMODS.load_file("crossmod/abandonia.lua"))()
end


local linear_ante_scaling = get_blind_amount
get_blind_amount = function(ante)
    if G.GAME.compress_scaling == true then
        return ante * 50
    end
    return linear_ante_scaling(ante)
end


