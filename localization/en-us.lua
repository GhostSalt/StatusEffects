return {
    descriptions = {
        Back = {
            b_stateff_oracle = {
                name = "Oracle Deck",
                text = {
                    "Start run with",
                    "#1# {element:1}Mana,",
                    "#2# {element:2}{C:stateff_purple}Clairvoyant{}",
                    "and #3# {element:3}{C:stateff_purple}Arcane{}"
                }
            }
        },
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
                    "{C:green}+#1#{} Confident,",
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
                    "{C:attention}status effects{}",
                    "{C:inactive,s:0.8}(Only available in",
                    "{C:inactive,s:0.8}Remedy Packs){}"
                }
            },
            c_stateff_miraclenectar = {
                name = "Miracle Nectar",
                text = {
                    "{C:green}+#1#{} Divine"
                }
            }
        },
        Joker = {
            j_joker_mana = {
                name = "Joker",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "If {element:1}Mana >= #2#:",
                    "gives double {C:mult}Mult{}"
                }
            },
            j_greedy_joker_mana = {
                name = "Greedy Joker",
                text = {
                    {
                        "Played cards with",
                        "{C:diamonds}#2#{} suit give",
                        "{C:mult}+#1#{} Mult when scored"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "convert {C:attention}leftmost{} played",
                        "card into {C:diamonds}#4#{}"
                    }
                }
            },
            j_lusty_joker_mana = {
                name = "Lusty Joker",
                text = {
                    {
                        "Played cards with",
                        "{C:hearts}#2#{} suit give",
                        "{C:mult}+#1#{} Mult when scored"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "convert {C:attention}leftmost{} played",
                        "card into {C:hearts}#4#{}"
                    }
                }
            },
            j_wrathful_joker_mana = {
                name = "Wrathful Joker",
                text = {
                    {
                        "Played cards with",
                        "{C:spades}#2#{} suit give",
                        "{C:mult}+#1#{} Mult when scored"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "convert {C:attention}leftmost{} played",
                        "card into {C:spades}#4#{}"
                    }
                }
            },
            j_gluttenous_joker_mana = {
                name = "Gluttonous Joker",
                text = {
                    {
                        "Played cards with",
                        "{C:clubs}#2#{} suit give",
                        "{C:mult}+#1#{} Mult when scored"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "convert {C:attention}leftmost{} played",
                        "card into {C:clubs}#4#{}"
                    }
                }
            },
            j_jolly_mana = {
                name = "Jolly Joker",
                text = {
                    "{C:red}+#1#{} Mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:mult}Mult{}"
                }
            },
            j_zany_mana = {
                name = "Zany Joker",
                text = {
                    "{C:red}+#1#{} Mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:mult}Mult{}"
                }
            },
            j_mad_mana = {
                name = "Mad Joker",
                text = {
                    "{C:red}+#1#{} Mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:mult}Mult{}"
                }
            },
            j_crazy_mana = {
                name = "Crazy Joker",
                text = {
                    "{C:red}+#1#{} Mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:mult}Mult{}"
                }
            },
            j_droll_mana = {
                name = "Droll Joker",
                text = {
                    "{C:red}+#1#{} Mult if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:mult}Mult{}"
                }
            },
            j_sly_mana = {
                name = "Sly Joker",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:chips}Chips{}"
                },
            },
            j_wily_mana = {
                name = "Wily Joker",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:chips}Chips{}"
                },
            },
            j_clever_mana = {
                name = "Clever Joker",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:chips}Chips{}"
                },
            },
            j_devious_mana = {
                name = "Devious Joker",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:chips}Chips{}"
                },
            },
            j_crafty_mana = {
                name = "Crafty Joker",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand contains",
                    "a {C:attention}#2#",
                    "If {element:1}Mana >= #3#:",
                    "gives double {C:chips}Chips{}"
                },
            },
            j_stencil_mana = {
                name = "Joker Stencil",
                text = {
                    "{X:red,C:white} X1 {} Mult for each",
                    "empty {C:attention}Joker{} slot",
                    "{s:0.8}Joker Stencil included{}",
                    "If {element:1}Mana >= #2#:",
                    "gives an extra {X:red,C:white} X#3# {} Mult",
                    "for each {C:attention}Joker{} to the right",
                    "{C:inactive}(Currently {X:red,C:white} X#1# {C:inactive})",
                },
            },
            j_credit_card_mana = {
                name = "Credit Card",
                text = {
                    {
                        "Go up to",
                        "{C:red}-$#1#{} in debt"
                    },
                    {
                        "At the end of the round,",
                        "earn {C:money}money{} equal to",
                        "your current {element:1}Mana"
                    }
                },
            },
            j_banner_mana = {
                name = "Banner",
                text = {
                    {
                        "{C:chips}+#1#{} Chips for each",
                        "remaining {C:attention}discard{}"
                    },
                    {
                        "Cost #2# {element:1}Mana:",
                        "When hand is played,",
                        "permanently add {C:chips}+#3#{} Chips",
                        "to this Joker's bonus"
                    }
                }
            },
            j_loyalty_card_mana = {
                name = "Loyalty Card",
                text = {
                    "{X:red,C:white} X#1# {} Mult every",
                    "{C:attention}#2#{} hands played",
                    "If {element:1}Mana >= #4#:",
                    "goes {C:attention}twice{} as fast",
                    "{C:inactive}#3#"
                }
            },
            j_8_ball_mana = {
                name = "8 Ball",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance for each",
                        "played {C:attention}8{} to create a",
                        "{C:tarot}Tarot{} card when scored"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "odds are {C:green}guaranteed{}",
                        "{C:inactive}(Must have room)"
                    }
                }
            },
            j_misprint_mana = {
                name = "Misprint",
                text = {
                    "If {element:1}Mana >= #1#:"
                },
            },
            j_gros_michel_mana = {
                name = "Gros Michel",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:green}#2# in #3#{} chance this",
                    "card is destroyed",
                    "at end of round,",
                    "gain #4# {element:1}{C:stateff_odds}Lucky{}",
                    "when it does"
                },
            },
            j_space_mana = {
                name = "Space Joker",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance to",
                        "upgrade level of",
                        "played {C:attention}poker hand{}"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "odds are {C:green}guaranteed{}"
                    }
                }
            },
            j_burglar_mana = {
                name = "Burglar",
                text = {
                    {
                        "When {C:attention}Blind{} is selected,",
                        "gain {C:blue}+#1#{} Hands and",
                        "{C:attention}lose all discards{}"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "gain {C:blue}+#2#{} more Hands"
                    }
                }
            },
            j_ice_cream_mana = {
                name = "Ice Cream",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:chips}-#2#{} Chips for",
                    "every hand played,",
                    "gain #3# {element:1}{C:stateff_blue}Swift{}",
                    "when consumed"
                },
            },
            j_dna_mana = {
                name = "DNA",
                text = {
                    {
                        "If {C:attention}first hand{} of round",
                        "has only {C:attention}1{} card, add a",
                        "permanent copy to deck",
                        "and draw it to {C:attention}hand"
                    },
                    {
                        "Cost #1# {element:1}Mana:",
                        "copy it {C:attention}twice{}"
                    }
                }
            },
            j_sixth_sense_mana = {
                name = "Sixth Sense",
                text = {
                    "If {C:attention}first hand{} of round is",
                    "a single {C:attention}6{}, destroy it and",
                    "create a {C:spectral}Spectral{} card",
                    "and gain #1# {element:1}Mana",
                    "{C:inactive}(Must have room)"
                }
            },
            j_hiker_mana = {
                name = "Hiker",
                text = {
                    "Every played {C:attention}card{}",
                    "permanently gains",
                    "{C:chips}+(#1#+{element:1}Mana{C:chips}){} Chips",
                    "when scored"
                },
            },
            j_superposition_mana = {
                name = "Superposition",
                text = {
                    {
                        "Create a {C:tarot}Tarot{} card if",
                        "poker hand contains an",
                        "{C:attention}Ace{} and a {C:attention}Straight{}",
                        "{C:inactive}(Must have room)"
                    },
                    {
                        "Cost #1# {element:1}Mana:",
                        "gain #2# {element:2}{C:stateff_brown}Invisible{}"
                    }
                },
            },
            j_todo_list_mana = {
                name = "To Do List",
                text = {
                    {
                        "Earn {C:money}$#1#{} if {C:attention}poker hand{}",
                        "is a {C:attention}#2#{},",
                        "poker hand changes",
                        "at end of round"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "poker hand changes to",
                        "{C:attention}High Card{} at end of round"
                    }
                }
            },
            j_cavendish_mana = {
                name = "Cavendish",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "{C:green}#2# in #3#{} chance this",
                    "card is destroyed",
                    "at end of round,",
                    "gain #4# {element:1}{C:stateff_odds}Unlucky{}",
                    "when it does"
                },
            },
            j_madness_mana = {
                name = "Madness",
                text = {
                    {
                        "When {C:attention}Small Blind{} or {C:attention}Big Blind{}",
                        "is selected, gain {X:mult,C:white} X#1# {} Mult",
                        "and {C:attention}destroy{} a random Joker",
                        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
                    },
                    {
                        "If {element:1}Mana >= #3#:",
                        "{C:red}Doesn't{} {C:attention}destroy{} Jokers, but",
                        "only gains {X:mult,C:white}X#4#{} Mult"
                    }
                }
            },
            j_seance_mana = {
                name = "Séance",
                text = {
                    "If {C:attention}poker hand{} is a",
                    "{C:attention}#1#{}, create a",
                    "random {C:spectral}Spectral{} card",
                    "and gain #2# {element:1}Mana",
                    "{C:inactive}(Must have room)"
                },
            },
            j_vampire_mana = {
                name = "Vampire",
                text = {
                    {
                        "This Joker gains {X:mult,C:white} X#1# {} Mult",
                        "per scoring {C:attention}Enhanced card{} played,",
                        "removes card {C:attention}Enhancement{}",
                        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "keep all {C:attention}Enhancements{}",
                        "in played hand"
                    }
                },
            },
            j_golden_mana = {
                name = "Golden Joker",
                text = {
                    "Earn {C:money}$#1#{} and",
                    "gain #2# {element:1}Mana at",
                    "end of round",
                },
            },
            j_diet_cola_mana = {
                name = "Diet Cola",
                text = {
                    "Sell this card to",
                    "create a free",
                    "{C:attention}#1#{} and",
                    "gain #2# {element:1}Mana"
                }
            },
            j_popcorn_mana = {
                name = "Popcorn",
                text = {
                    {
                        "{C:mult}+#1#{} Mult",
                        "{C:mult}-#2#{} Mult per",
                        "round played"
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "gains {C:mult}+#2#{} Mult per",
                        "round played instead"
                    }
                }
            },
            j_ramen_mana = {
                name = "Ramen",
                text = {
                    "{X:mult,C:white} X#1# {} Mult,",
                    "loses {X:mult,C:white} X#2# {} Mult",
                    "per {C:attention}card{} discarded,",
                    "gain #3# {element:1}{C:stateff_red}Furious{}",
                    "when consumed"
                }
            },
            j_selzer_mana = {
                name = "Seltzer",
                text = {
                    "Retrigger all",
                    "cards played for",
                    "the next {C:attention}#1#{} hands,",
                    "gain #2# {element:1}{C:stateff_red}Confident{}",
                    "when consumed"
                }
            },
            j_flower_pot_mana = {
                name = "Flower Pot",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if poker",
                    "hand contains a",
                    "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
                    "{C:hearts}Heart{} card, and {C:spades}Spade{} card,",
                    "gain #2# {element:1}Mana otherwise"
                },
                unlock = {
                    "Reach Ante",
                    "level {E:1,C:attention}#1#"
                }
            },
            j_cartomancer_mana = {
                name = "Cartomancer",
                text = {
                    {
                        "Create a {C:tarot}Tarot{} card",
                        "when {C:attention}Blind{} is selected",
                        "{C:inactive}(Must have room)",
                    },
                    {
                        "Cost #1# {element:1}Mana:",
                        "creates a {C:dark_edition}Negative{}",
                        "{C:tarot}Tarot{} card"
                    }
                },
                unlock = {
                    "Discover every",
                    "{E:1,C:tarot}Tarot{} card",
                },
            },
            j_caino_mana = {
                name = "Canio",
                text = {
                    {
                        "This Joker gains {X:mult,C:white} X#1# {} Mult",
                        "when a {C:attention}face{} card",
                        "is destroyed",
                        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                    },
                    {
                        "Cost #3# {element:1}Mana:",
                        "destroy a {C:red}discarded{}",
                        "{C:attention}face{} card"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_triboulet_mana = {
                name = "Triboulet",
                text = {
                    {
                        "Played {C:attention}Kings{} and",
                        "{C:attention}Queens{} each give",
                        "{X:mult,C:white} X#1# {} Mult when scored"
                    },
                    {
                        "Cost #2# {element:1}Mana:",
                        "gains {X:mult,C:white}X#3#{} Mult"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_yorick_mana = {
                name = "Yorick",
                text = {
                    {
                        "This Joker gains",
                        "{X:mult,C:white} X#1# {} Mult every {C:attention}#2#{C:inactive} [#3#]{}",
                        "cards discarded",
                        "{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)"
                    },
                    {
                        "Cost #5# {element:1}Mana:",
                        "on {C:red}discard{}, gain",
                        "{C:red}+#6#{} discard"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_chicot_mana = {
                name = "Chicot",
                text = {
                    "Disables effect of",
                    "every {C:attention}Boss Blind{},",
                    "gain #1# {element:1}Mana at",
                    "end of round"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_perkeo_mana = {
                name = "Perkeo",
                text = {
                    {
                        "Creates a {C:dark_edition}Negative{} copy of",
                        "{C:attention}1{} random {C:attention}consumable{}",
                        "card in your possession",
                        "at the end of the {C:attention}shop"
                    },
                    {
                        "If {element:1}Mana >= #1#:",
                        "guaranteed to copy your",
                        "{C:attention}leftmost{} consumable card"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
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
            stateff_stateff_confident = {
                name = "Confident",
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


            p_stateff_potion_normal1 = {
                name = "Remedy Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:stateff_potion}Potions{} to drink",
                    "immediately, always",
                    "contains {C:attention}Plain Milk{}"
                }
            },
            p_stateff_potion_normal2 = {
                name = "Remedy Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:stateff_potion}Potions{} to drink",
                    "immediately, always",
                    "contains {C:attention}Plain Milk{}"
                }
            },
            p_stateff_potion_jumbo1 = {
                name = "Jumbo Remedy Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:stateff_potion}Potions{} to drink",
                    "immediately, always",
                    "contains {C:attention}Plain Milk{}"
                }
            },
            p_stateff_potion_mega1 = {
                name = "Mega Remedy Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:stateff_potion}Potions{} to drink",
                    "immediately, always",
                    "contains {C:attention}Plain Milk{}"
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
            k_stateff_potion_pack = "Remedy Pack",
            b_stateff_drink = "DRINK",

            ph_stateff_guarded = "Saved by Guarded",

            stateff_plural = "s",
        },
        v_dictionary = {
            a_mana = "+#1# Mana",
            a_discard = "+#1# Discard"
        }
    }
}
