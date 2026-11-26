return {
    descriptions = {
        Enhanced = {
            m_ele_div = {
                name = "Div Card",
                text = {
                    "{C:mult}+#2#{} Mult",
                    "{C:ele_amp}+#1#{} Tax",
                },
            },
            m_ele_opposite = {
                name = "Opposite Card",
                text = {
                    "{C:FF5D00}#1#{} extra chips",
                },
            },
            m_ele_invert = {
                name = "Inverted Card",
                text = {
                    "{C:5BE0E5}#1#{} Mult",
                },
            },
            m_ele_lead = {
                name = "Lead Card",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "while this card",
                    "stays in hand",
                },
            },
            m_ele_radio = {
                name = "Radioactive Card",
                text = {
                    "{C:green,E:1} -0.4 probabilities {}",
                    "while this card",
                    "stays in hand",
                },
            },
            m_ele_mag = {
                name = "Magnetic Card",
                text = {
                    "{C:attention} always selected {}",
                    "when drawn to hand",
                },
            },
            m_ele_corrupt = {
                name = "Corrupted Card",
                text = {
                    "",
                },
            },
            m_ele_fragile = {
                name = "Fragile Card",
                text = {
                    "{X:mult,C:white}X#1#{} mult",
                    "{C:green}#2# in #3#{} chance to",
                    "destroy card",
                },
            },
            m_ele_hollow = {
                name = "Hollow Card",
                text = {
                    "no rank or suit",
                    "destroy card when played",
                },
            },
        },
        Edition = {
            e_ele_iridescent = {
                name = "Bloom",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "{X:chips,C:white}X#2#{} Chips",
                },
            },
            e_ele_tinted = {
                name = "Tinted",
                text = {
                    "{C:mult}+#2#{} Mult",
                    "{C:ele_amp}+#1#{} Tax",
                },
            },
        },
        Blind = {
            bl_ele_candle_final = {
                name = "Tangerine Candle",
                text = {
                    "Base Chips and",
                    "Mult are divided by 8",
                },
            },
            bl_ele_club_final = {
                name = "Aquamarine Club",
                text = {
                    "Set level of",
                    "poker hand to 1",
                },
            },
            bl_ele_scepter_final = {
                name = "Mulberry Scepter",
                text = {
					'Blind size increases',
					'by #1#% per card played'
                },
            },
            bl_ele_coin_final = {
                name = "Emerald Coin",
                text = {
                    "1 in 3 card are drawn face down",
                    "1 in 4 card are debuffed",
                },
            },
            bl_ele_hourglass_final = {
                name = "Golden Hourglass",
                text = {
                    "Discard 2/3",
                    "of your deck",
                },
            },
            bl_ele_observer = {
                name = "The Observer",
                text = {
					'Played Diamond cards',
					'give +#1# Tax'
                },
            },
            bl_ele_boat = {
                name = "The Boat",
                text = {
					'Played Spade cards',
					'give +#1# Tax'
                },
            },
            bl_ele_smile = {
                name = "The Smile",
                text = {
					'Played Heart cards',
					'give +#1# Tax',
					':)'
                },
            },
            bl_ele_fox = {
                name = "The Fox",
                text = {
					'Played Club cards',
					'give +#1# Tax'
                },
            },
            bl_ele_laconism = {
                name = "The Laconism",
                text = {
					'Chips and Mult are',
					'Compressed after calculation'
                },
            },
        },
        Joker = {
            j_ele_cheerful = {
                name = "Cheerful Joker",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "if played hand contains",
                    "a {C:attention}#3#",
                },
            },
            j_ele_goofy = {
                name = "Goofy Joker",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "if played hand contains",
                    "a {C:attention}#3#",
                },
            },
            j_ele_bonkers = {
                name = "Bonkers Joker",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "if played hand contains",
                    "a {C:attention}#3#",
                },
            },
            j_ele_insane = {
                name = "Insane Joker",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "if played hand contains",
                    "a {C:attention}#3#",
                },
            },
            j_ele_comical = {
                name = "Comical Joker",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "if played hand contains",
                    "a {C:attention}#3#",
                },
            },
            j_ele_capacitor = {
                name = "Capacitor",
                text = {
                    "Gains {C:mult}+#1#{} Mult",
                    "at {C:attention}end of round",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                },
            },
            j_ele_magnet = {
                name = "Magnet",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "for each {C:attention}Steel Card{} played",
                },
            },
            j_ele_erratic = {
                name = "Prism",
                text = {
                    "{C:chips}+#1#{} Chips, {C:mult}+#2#{} Mult, and {C:ele_amp}+#3#{} Tax",
                    "for each played card with {V:1}#4#{} suit",
                    "{s:0.8}suit changes at end of round",
                },
            },
            j_ele_geiger = {
                name = "Geiger Counter",
                text = {
                    "Gains {C:mult}+#2#{} Mult when score catches on fire",
                    "Gains {C:ele_amp}+#4#{} Tax otherwise",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult, {C:ele_amp}+#3#{C:inactive} Tax)",
                },
            },
            j_ele_mint = {
                name = "Mint Gum",
                text = {
                    "{C:ele_amp}+#1#{} Tax, {C:mult}+#3#{} Mult",
                    "{C:ele_amp}+#2#{} Tax and {C:mult}-#4#{} Mult",
                    "per round played",
                },
            },
            j_ele_spectro = {
                name = "Abstract art",
                text = {
                    "{C:mult}+#2#{} Mult and {C:ele_amp}+#1#{} Tax",
                    "for each {C:attention}scored{} card",
                },
            },
            j_ele_speaker = {
                name = "Hypercube",
                text = {
                    "{X:mult,C:white}X#2#{} Mult before scoring",
                    "if hand contains exactly {C:attention}4{} cards",
                    "Otherwise {C:ele_amp}+#1#{} Tax",
                },
            },
            j_ele_wave = {
                name = "Sine Wave",
                text = {
                    "{C:attention}Alternates{} between",
                    "{C:ele_amp}+#1#{} Tax and",
                    "{C:ele_amp}-#1#{} Tax per",
                    "hand played",
                },
            },
            j_ele_stonks = {
                name = "Stonks",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult for",
                    "each {C:money}$#3#{} you have",
                    "{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips and {C:mult}+#5#{C:inactive} Mult )",
                },
            },
            j_ele_mixel = {
                name = "Mixel Joker",
                text = {
                    "{C:mult}+#1#{} Mult for every",
                    "{C:attention}unique rank{} in played hand",
                    "{C:ele_amp}+#2#{} Tax for every additional",
                    "{C:attention}matching rank{} in played hand",
                },
            },
            j_ele_brain = {
                name = "Big Brain",
                text = {
                    "Balance {C:chips}Chips{} and {C:mult}Mult{}",
                    "to a {C:chips}#1#{} : {C:mult}#2#{} ratio",
                },
            },
            j_ele_majestic = {
                name = "Majestic Joker",
                text = {
                    "{C:mult}+#1#{} mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                },
            },
            j_ele_deceitful = {
                name = "Deceitful Joker",
                text = {
                    "{C:chips}+#1#{} chips if played",
                    "hand contains",
                    "a {C:attention}#2#",
                },
            },
            j_ele_court = {
                name = "The Court",
                text = {
                    "{X:mult,C:white}X#1#{} mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                },
            },
            j_ele_glorious = {
                name = "Glorious Joker",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "if played hand contains",
                    "a {C:attention}#3#",
                },
            },
        },
        Tarot = {
            c_ele_effigy = {
                name = "Effigy",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected card to",
                    "a {C:attention}#2#",
                },
            },
        },
        Planet = { 
            c_ele_proximab = {
                name = "Proxima b",
                text = {
                    "({V:1}lvl.#1#{}) Level up",
                    "{C:attention}#2#",
                    "{C:chips}+#3#{} chips and",
                    "{C:mult}+#4#{} Mult",
                },
            },
            c_ele_proximac = {
                name = "Proxima c",
                text = {
                    "({V:1}lvl.#1#{}) Level up",
                    "{C:attention}#2#",
                    "{C:chips}+#3#{} chips and",
                    "{C:mult}+#4#{} Mult",
                },
            },
            c_ele_proximad = {
                name = "Proxima d",
                text = {
                    "({V:1}lvl.#1#{}) Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                },
            },
        },
        Spectral = {
            c_ele_duality = {
                name = "Duality",
                text = {
                    "Add {C:dark_edition}Polychrome{} effect",
                    "to {C:attention}#1#{} selected card in hand",
                    "and convert it into an {C:ele_attenuator}Attenuator",
                },
            },
            c_ele_invert = {
                name = "Invert",
                text = { 
                    "Select up to {C:attention}#1#{} cards",
                    "copy the {C:attention}enhancement{} of the {C:attention}rightmost{}",
                    "into the {C:attention}rest{} of the cards",
                    "Convert the {C:attention}rightmost{} into an {C:ele_attenuator}Attenuator"
                },
            },
            c_ele_tung = {
                name = "Tungsten Cube",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "Add {C:attention}#2#{} random {C:ele_attenuator}Lead{}",
                    "cards to you hand",
                },
            },
            c_ele_draw = {
                name = "Draw +4",
                text = {
                    "Gain {C:money}$#1#{}",
                    "Add {C:attention}#2#{} random {C:ele_attenuator}Attenuator{}",
                    "cards to you hand",
                },
            },
        },
        Tag = {
            tag_ele_irid = {
                name = "Iridescent Tag",
                text = {
                    "Next base edition shop",
                    "Joker is free and",
                    "becomes {C:dark_edition}Bloom",
                },
            },
            tag_ele_tint = {
                name = "Tinted Tag",
                text = {
                    "Next base edition shop",
                    "Joker is free and",
                    "becomes {C:dark_edition}Tinted",
                },
            },
        },
        Back = {
            b_ele_lightning = {
                name = "Lightning Deck",
                text = {
                    "Equalize {C:chips}Chips{} and {C:mult}Mult{}",
                    "before scoring",
                    "Required score scales",
                    "faster for each {C:attention}Ante",
                },
            },
            b_ele_luxury = {
                name = "Luxurious Deck",
                text = {
                    "{C:attention}Ace{} cards start",
                    "as {C:money,T:m_gold}Gold Cards",
                },
            },
            b_ele_crit = {
                name = "Critical Deck",
                text = {
                    "Played {C:attention}card{} has",
                    "a {C:green}#1# in #2#{} chance to {C:attention}retrigger{}",
                    "or a {C:green}#1# in #3#{} chance for {C:ele_amp}+#4#{} Tax",
                },
            },
            b_ele_bec = {
                name = "B.E.C. Deck",
                text = {
                    "{C:inactive,s:0.75}Bose-Einstein Condensate deck",
                    "Only the maximum of {C:chips}Chips{}",
                    "or {C:mult}Mult{} is picked for score",
                    "Score requirement scales {C:dark_edition}linearly",
                },
            },
            b_ele_ultraviolet = {
                name = "Utraviolet Deck",
                text = {
                    "{C:ele_amp}+#2#{} base tax when hand is played",
                    "{C:ele_attenuator}Attenuators{} give",
                    "{X:ele_amp,C:white}X#3#{} base tax when played",
                    "{C:attention}#1#{} random cards start as {C:ele_attenuator}Attenuators{}",
                },
            },
        },
        Sleeve = {
            sleeve_ele_lightning = {
                name = "Lightning Sleeve",
                text = {
                    "Equalize {C:chips}Chips{} and {C:mult}Mult{}",
                    "before scoring",
                    "Required score scales",
                    "faster for each {C:attention}Ante",
                },
            },
            sleeve_ele_lightning_alt = {
                name = "Lightning Sleeve",
                text = {
                    "Balance {C:chips}Chips{} and {C:mult}Mult{}",
                    "before scoring",
                },
            },
            sleeve_ele_luxury = {
                name = "Luxurious Sleeve",
                text = {
                    "{C:attention}Ace{} cards start",
                    "as {C:money,T:m_gold}Gold Cards",
                },
            },
            sleeve_ele_luxury_alt = {
                name = "Luxurious Sleeve",
                text = {
                    "{C:attention}King{} cards start",
                    "as {C:attention,T:m_steel}Steel Cards",
                },
            },
            sleeve_ele_crit = {
                name = "Critical Sleeve",
                text = {
                    "Played {C:attention}card{} has",
                    "a {C:green}#1# in #2#{} chance to {C:attention}retrigger{}",
                    "or a {C:green}#1# in #3#{} chance for {C:ele_amp}+#4#{} Tax",
                },
            },
            sleeve_ele_crit_alt = {
                name = "Critical Sleeve",
                text = {
                    "Played {C:attention}card{} has",
                    "an additional {C:green}#1# in #2#{} chance",
                    "to {C:attention}retrigger{}",
                },
            },
            sleeve_ele_bec = {
                name = "B.E.C. Sleeve",
                text = {
                    "{C:inactive,s:0.5}Bose-Einstein Condensate sleeve{}",
                    "Only the maximum of {C:chips}Chips{}",
                    "or {C:mult}Mult{} is picked for score",
                    "Score requirement scales {C:dark_edition}linearly",
                },
            },
            sleeve_ele_bec_alt = {
                name = "B.E.C. Sleeve",
                text = {
                    "{C:chips}Chips{} and {C:mult}Mult{} are",
                    "added instead",
                },
            },
            sleeve_ele_ultraviolet = {
                name = "Utraviolet Sleeve",
                text = {
                    "{C:ele_amp}+#2#{} base tax when hand is played",
                    "{C:ele_attenuator}Attenuators{} give",
                    "{X:ele_amp,C:white}X#3#{} base tax when played",
                    "{C:attention}#1#{} random cards start as {C:ele_attenuator}Attenuators{}",
                },
            },
            sleeve_ele_ultraviolet_alt = {
                name = "Utraviolet Sleeve",
                text = {
                    "base tax gained from hands",
                    "scales {X:ele_amp,C:white}X#4#{} slower"
                },
            },
        },
    },
    misc = {
        quips = {
        -- Showdown bosses only: the name reveal in the intro
        fb_bl_ele_final_scepter_name_1 = {"I am Mulberry Scepter.", "Prepare for doom."},

        -- The intro threat (hint at your effect, don't explain it)
        fb_bl_ele_final_scepter_intro_1 = {"My territory is expanding.", "Incomparable to your chips."},
        fb_bl_ele_final_scepter_intro_2 = {"It's a buffoon again.", "Won't take long until overwhelmed."},

        -- During the fight
        fb_bl_ele_final_scepter_big_hand_1 = {"Lucky hit.", "Won't happen twice."},   -- one hand scored 30%+
        fb_bl_ele_final_scepter_close_1 = {"Close enough.", "You still require to catch up."},             -- your total passed 75%
        fb_bl_ele_final_scepter_last_hand_1 = {"Last hand.", "Make sure to overestimate."},       -- you're down to your last hand
        fb_bl_ele_final_scepter_weak_1 = {"Effectively nothing.", "Comparable to a pile of rubble."},                 -- a hand under 10%
        fb_bl_ele_final_scepter_interrupted_1 = {"You're hasty for what I expect.", "How unresponsive."},          -- you played during the intro
        fb_bl_ele_final_scepter_disabled_1 = {"My power! Stopped...", "You will pay, derelict."},   -- the boss got disabled

        -- End of the fight
        fb_bl_ele_final_scepter_defeat_1 = {"You should consider being overconfident."},                      -- you won
        fb_bl_ele_final_scepter_gloat_1 = {"Too Slow."},                           -- you lost (Jimbo says it)

        -- Boss memory: the intro when you won or lost against this boss last time
        fb_bl_ele_final_scepter_rematch_won_1 = {"It's the delinquent again.", "prepare for reinforcement."},
        fb_bl_ele_final_scepter_rematch_lost_1 = {"", "Consider playing more cards."},

        -- Showdown bosses only: the transformations at 50% and 25% HP
        fb_bl_ele_final_scepter_phase2_1 = {"You're catching up.", "I'll grow faster."},
        fb_bl_ele_final_scepter_phase3_1 = {"You're making this worse.", "I cannot let this happen."},

        -- Lines picked by the `line` function in boss.lua
        fb_bl_ele_final_scepter_defeat_lasthand_1 = {"You managed to escape", "I will come back, bigger."},
        fb_bl_ele_final_scepter_intro_broke_1 = {"Essentially bankrupt", "Essentially nothing to my size."},

        -- Optional, usually left to the personality (see "Line keys" in the FinalBoss README):
        -- fb_bl_ele_final_scepter_jab_broke_1, fb_bl_ele_final_scepter_read_onecard_1, fb_bl_ele_final_scepter_idle_1,
        -- fb_bl_ele_final_scepter_poked_1, fb_bl_ele_final_scepter_fear_1_1, fb_bl_ele_final_scepter_last_words_1, ...
        },
        labels = {
            ele_Metal = "Metal",
            ele_iridescent = "Iridescent",
            ele_tinted = "Tinted",
        },
        dictionary = {
        k_metal = "Metal",
        b_metal_cards = "Metal Cards",
        metal_ready = "Ready!",
		scepter_up = '+X0.1',
		equalized = 'Equalized',
		balanced = 'Balanced',
		compressed = 'Compressed',
		drank = 'Drank!',
		eaten = 'Munched!',
		mint_loss = '+0.05 Tax -4 mult',
		plus_tarot = '+1 Tarot',
		oops = '+0.1 Tax',
        crit = "Critical Hit!",
        fail = "Critical Fail...",
        supercrit = "Super Critical Hit!!",
        },
        poker_hand_descriptions = {
            ele_blaze = {
                "5 Face cards",
            },
            ele_blaze_flush = {
                "5 Face cards with all",
                "cards sharing the same suit",
            },
            ele_blaze_house = {
                "5 Face cards that form",
                "a Three of a Kind and a Pair",
            },
        },
        poker_hands = {
            ele_blaze = "Blaze",
            ele_blaze_flush = "Blaze Flush",
            ele_blaze_house = "Blaze House",
        }
    }
}