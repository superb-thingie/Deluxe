SMODS.Atlas{
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}
G.C.AMP = HEX('9C51C1')
G.C.MINT = HEX('75A881')
G.C.DARK_PURP = HEX('9C51C1')
G.C.PLASMA = HEX('C863D6')
G.C.METAL = HEX('d4b79b')
G.C.GOLD = HEX('E0AC55')
G.C.ELEC = HEX('a59a63')
G.C.SALT = HEX('A1B7C7')

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

assert(SMODS.load_file("items/tax.lua"))()
assert(SMODS.load_file("items/enhancers.lua"))()
assert(SMODS.load_file("items/editions.lua"))()
assert(SMODS.load_file("items/backs.lua"))()
assert(SMODS.load_file("items/vouchers.lua"))()
assert(SMODS.load_file("items/tarots.lua"))()
assert(SMODS.load_file("items/jokers.lua"))()
assert(SMODS.load_file("items/blinds.lua"))()
assert(SMODS.load_file("items/poker_hands.lua"))()
assert(SMODS.load_file("items/planets.lua"))()
assert(SMODS.load_file("items/tags.lua"))()
assert(SMODS.load_file("crossmod/boss.lua"))()

if next(SMODS.find_mod("CardSleeves")) then
    assert(SMODS.load_file("crossmod/sleeves.lua"))()
end
if next(SMODS.find_mod("Maximus")) then
    assert(SMODS.load_file("crossmod/maximus.lua"))()
end
if next(SMODS.find_mod("Oblivion")) then
    assert(SMODS.load_file("crossmod/oblivion.lua"))()
end


