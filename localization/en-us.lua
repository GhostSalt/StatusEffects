return {
    descriptions = {
        Blind = {
            bl_stateff_rise = {
                name = "The Rise",
                text = {
                    "Inflicts #1# Burnt"
                }
            },
            bl_stateff_icicle = {
                name = "The Icicle",
                text = {
                    "Inflicts #1# Frozen"
                }
            },
            bl_stateff_bolt = {
                name = "The Bolt",
                text = {
                    "Inflicts #1# Shocked"
                }
            },
            bl_stateff_crunch = {
                name = "The Crunch",
                text = {
                    "Inflicts #1# Weakened"
                }
            },
            bl_stateff_fold = {
                name = "The Fold",
                text = {
                    "Inflicts #1# Blinded"
                }
            },
            bl_stateff_heretic = {
                name = "The Heretic",
                text = {
                    "Inflicts #1# Cursed"
                }
            },
            bl_stateff_rat = {
                name = "The Rat",
                text = {
                    "Inflicts #1# Poisoned"
                }
            },
            bl_stateff_hex = {
                name = "The Hex",
                text = {
                    "Inflicts #1# Unlucky"
                }
            },
            bl_stateff_harpy = {
                name = "The Harpy",
                text = {
                    "Inflicts #1# Lunatic"
                }
            }
        },
        stateff_Potion = {
            c_stateff_unicorntears = {
                name = "Unicorn Tears",
                text = {
                    "{C:green}+#1#{} Lucky,",
                    "{C:red}+#2#{} Shocked"
                }
            },
            c_stateff_dubiousvino = {
                name = "Dubious Vino",
                text = {
                    "{C:green}+#1#{} Focused,",
                    "{C:red}+#2#{} Poisoned"
                }
            },
            c_stateff_lattemaltocaldo = {
                name = "Latte Malto Caldo",
                text = {
                    "{C:green}+#1#{} Swift,",
                    "{C:red}+#2#{} Burnt"
                }
            },
            c_stateff_homeopathiclemonade = {
                name = "Homeopathic Lemonade",
                text = {
                    "{C:green}+#1#{} Clairvoyant,",
                    "{C:red}+#2#{} Weakened"
                }
            },
            c_stateff_orcbrew = {
                name = "Orc Brew",
                text = {
                    "{C:green}+#1#{} Furious,",
                    "{C:red}+#2#{} Blinded"
                }
            },
            c_stateff_saltyspirit = {
                name = "Salty Spirit",
                text = {
                    "{C:green}+#1#{} Invisible,",
                    "{C:red}+#2#{} Cursed"
                }
            },
            c_stateff_radioactivesludge = {
                name = "Radioactive Sludge",
                text = {
                    "{C:green}+#1#{} Glowing,",
                    "{C:red}+#2#{} Unlucky"
                }
            },
            c_stateff_schradersmedicine = {
                name = "Schrader's Medicine",
                text = {
                    "{C:green}+#1#{} Guarded,",
                    "{C:red}+#2#{} Frozen"
                }
            },
            c_stateff_bafflingcocktail = {
                name = "Baffling Cocktail",
                text = {
                    "{C:green}+#1#{} Arcane,",
                    "{C:red}+#2#{} Lunatic"
                }
            },
            c_stateff_witchscanteen = {
                name = "Witch's Canteen",
                text = {
                    "{C:green}+#1#{} Mana"
                }
            },
            c_stateff_plainmilk = {
                name = "Plain Milk",
                text = {
                    "Clears all",
                    "{C:attention}status effects{}"
                }
            },
            c_stateff_miraclenectar = {
                name = "Miracle Nectar",
                text = {
                    "{C:green}+#1#{} Divine"
                }
            }
        },
        Other = {
            stateff_stateff_burnt = {
                name = "Burnt",
                text = {
                    "Leftmost {C:attention}#1#{} cards become",
                    "{C:attention}Burning{} when first hand",
                    "of round is drawn"
                }
            },
            stateff_stateff_frozen = {
                name = "Frozen",
                text = {
                    "{C:red}-#1#{} discard#2#"
                }
            },
            stateff_stateff_shocked = {
                name = "Shocked",
                text = {
                    "Lose {C:money}$#1#{} when",
                    "you {C:red}discard{}"
                }
            },
            stateff_stateff_blinded = {
                name = "Blinded",
                text = {
                    "Cards are drawn {C:attention}face{}",
                    "{C:attention}down{} if the number",
                    "of face down cards",
                    "is less than {C:attention}#1#{}"
                }
            },
            stateff_stateff_cursed = {
                name = "Cursed",
                text = {
                    "Non-final hands each",
                    "have a {C:green}#1# in #2#{} chance",
                    "to {C:red}not score{}, only",
                    "disappears once triggered"
                }
            },
            stateff_stateff_poisoned = {
                name = "Poisoned",
                text = {
                    "At the end of",
                    "the round, lose {C:money}$#1#{}"
                }
            },
            stateff_stateff_lucky = {
                name = "Lucky",
                text = {
                    "{C:attention}+#1#{} to all {C:green}probability{}",
                    "{C:green}numerators{}",
                    "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}#2# in 3{C:inactive}){}"
                }
            },
            stateff_stateff_unlucky = {
                name = "Unlucky",
                text = {
                    "{C:attention}+#1#{} to all {C:green}probability{}",
                    "{C:green}denominators{}",
                    "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}1 in #2#{C:inactive}){}"
                }
            },
            stateff_stateff_focused = {
                name = "Focused",
                text = {
                    "{C:attention}+#1#{} hand size"
                }
            },
            stateff_stateff_swift = {
                name = "Swift",
                text = {
                    "{C:blue}+#1#{} hand#2#"
                }
            },
            stateff_stateff_furious = {
                name = "Furious",
                text = {
                    "Retriggers all played",
                    "cards {C:attention}#1#{} time#2#"
                }
            },
            stateff_stateff_invisible = {
                name = "Invisible",
                text = {
                    "The next {C:attention}#1#{} round#2#",
                    "only end#3# once you",
                    "use all your {C:blue}hands{}"
                }
            },
            stateff_stateff_clairvoyant = {
                name = "Clairvoyant",
                text = {
                    "{C:attention}+#1#{} card#2# in",
                    "the shop"
                }
            },
            stateff_stateff_weakened = {
                name = "Weakened",
                text = {
                    "All poker hands",
                    "are {C:attention}-#1#{} level#2#",
                    "{C:inactive}(Minimum level 1){}"
                }
            },
            stateff_stateff_glowing = {
                name = "Glowing",
                text = {
                    "Rightmost {C:attention}#1#{} cards become",
                    "{C:attention}Shining{} when first hand",
                    "of round is drawn"
                }
            },
            stateff_stateff_guarded = {
                name = "Guarded",
                text = {
                    "For the next {C:attention}#1#{} round#2#,",
                    "if chips scored are at",
                    "least {C:attention}25%{} of required",
                    "chips, prevents Death",
                    "and lose all {C:attention}Guarded{}"
                }
            },
            stateff_stateff_arcane = {
                name = "Arcane",
                text = {
                    "Creates a {C:tarot}Tarot{} card",
                    "after the next",
                    "{C:attention}#1#{} hand#2# played",
                    "{C:inactive}(Must have room){}"
                }
            },
            stateff_stateff_lunatic = {
                name = "Lunatic",
                text = {
                    "For the next {C:attention}#1#{}",
                    "rounds, you {C:red}cannot{}",
                    "sell {C:attention}consumables{}"
                }
            },
            stateff_stateff_mana = {
                name = "Mana",
                text = {
                    "Grants {C:attention}bonus powers{}",
                    "for certain cards,",
                    "does not {C:red}deplete{} at",
                    "the end of the round"
                }
            },
            stateff_stateff_divine = {
                name = "Divine",
                text = {
                    "{C:attention}+#1#{} Joker slot#2#"
                }
            },
            stateff_burnt_info = {
                name = "Burning Card",
                text = {
                    "When selected,",
                    "{C:white,X:attention}X1.5{} Blind size",
                    "and stops burning"
                }
            },
            stateff_shining_info = {
                name = "Shining Card",
                text = {
                    "Earn {C:money}$4{}"
                }
            },

            undiscovered_stateff_potion = {
                name = "Not Discovered",
                text = {
                    "Obtain this potion in",
                    "an unseeded run to",
                    "learn what it does",
                }
            },
        }
    },
    misc = {
        dictionary = {
            b_stateff_potion_cards = "Potions",
            k_stateff_potion = "Potion",
            ph_stateff_guarded = "Saved by Guarded",

            stateff_plural = "s"
        }
    }
}
