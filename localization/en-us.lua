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
            }
        },
        Other = {
            stateff_stateff_burnt = {
                name = "Burnt",
                text = {
                    "Leftmost {C:attention}#1#{} cards become",
                    "{C:attention}Burnt{} when first hand",
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
            stateff_stateff_weakened = {
                name = "Weakened",
                text = {
                    "All poker hands",
                    "are {C:attention}-#1#{} level#2#",
                    "{C:inactive}(Minimum level 1){}"
                }
            }
        }
    },
    misc = {
        dictionary = {
            stateff_plural = "s"
        }
    }
}
