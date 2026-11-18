-- FinalBoss lines for the template boss (bl_ele_final_scepter).
--
-- `misc` sits next to `descriptions`, not inside it, or Balatro never loads the quips.
-- Each line is 1 or 2 strings of about 24 characters (the speech bubble fits 2 short lines).
-- Add variants with _2, _3, ... (no gaps): FinalBoss picks one at random and never repeats the last.
-- Delete any line you don't want: that moment falls back to your boss's personality.
-- #1# is your boss's name.
return {
  descriptions = {
    Blind = {
      bl_ele_scepter_final = {
        name = 'Mulberry Scepter',
        text = {'Your boss effect here'},
      },
    },
  },
  misc = {
    quips = {
      -- Showdown bosses only: the name reveal in the intro
      fb_bl_ele_final_scepter_name_1 = {"I am Mulberry Scepter.", "Prepare for doom."},

      -- The intro threat (hint at your effect, don't explain it)
      fb_bl_ele_final_scepter_intro_1 = {"My territory is expanding.", "Incomparable to your chips."},
      fb_bl_ele_final_scepter_intro_2 = {"It's a buffoon again.", "This won't take long."},

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
  },
}
