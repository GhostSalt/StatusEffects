SMODS.Atlas {
    key = "Blinds",
    path = "StatusEffectsBlinds.png",
    px = 34,
    py = 34,
    atlas_table = "ANIMATION_ATLAS",
    frames = 21
}

SMODS.Blind {
    key = "icicle",
    atlas = "Blinds",
    pos = { x = 0, y = 0 },
    boss = { min = 4 },
    config = { no_of_effect = 3 },
    boss_colour = HEX("5A9FD1"),
    collection_loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    set_blind = function(self)
        StatusEffects.change_effect_level("stateff_frozen", G.GAME.blind.effect.no_of_effect)
    end,
    disable = function(self)
        StatusEffects.change_effect_level("stateff_frozen", -G.GAME.blind.effect.no_of_effect)
    end
}

SMODS.Blind {
    key = "bolt",
    atlas = "Blinds",
    pos = { x = 0, y = 1 },
    boss = { min = 3 },
    config = { no_of_effect = 3 },
    boss_colour = HEX("FFD840"),
    collection_loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    set_blind = function(self)
        StatusEffects.change_effect_level("stateff_shocked", G.GAME.blind.effect.no_of_effect)
    end,
    disable = function(self)
        StatusEffects.change_effect_level("stateff_shocked", -G.GAME.blind.effect.no_of_effect)
    end
}

SMODS.Blind {
    key = "crunch",
    atlas = "Blinds",
    pos = { x = 0, y = 4 },
    boss = { min = 2 },
    config = { no_of_effect = 3 },
    boss_colour = HEX("927664"),
    collection_loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    set_blind = function(self)
        StatusEffects.change_effect_level("stateff_weakened", G.GAME.blind.effect.no_of_effect)
    end,
    disable = function(self)
        StatusEffects.change_effect_level("stateff_weakened", -G.GAME.blind.effect.no_of_effect)
    end
}

SMODS.Blind {
    key = "fold",
    atlas = "Blinds",
    pos = { x = 0, y = 5 },
    boss = { min = 3 },
    config = { no_of_effect = 3 },
    boss_colour = HEX("5F7F74"),
    collection_loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    set_blind = function(self)
        StatusEffects.change_effect_level("stateff_blinded", G.GAME.blind.effect.no_of_effect)
    end,
    disable = function(self)
        StatusEffects.change_effect_level("stateff_blinded", -G.GAME.blind.effect.no_of_effect)
    end
}

SMODS.Blind {
    key = "heretic",
    atlas = "Blinds",
    pos = { x = 0, y = 3 },
    boss = { min = 5 },
    config = { no_of_effect = 3 },
    boss_colour = HEX("A2A2A2"),
    collection_loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    set_blind = function(self)
        StatusEffects.change_effect_level("stateff_cursed", G.GAME.blind.effect.no_of_effect)
    end,
    disable = function(self)
        StatusEffects.change_effect_level("stateff_cursed", -G.GAME.blind.effect.no_of_effect)
    end
}

SMODS.Blind {
    key = "rat",
    atlas = "Blinds",
    pos = { x = 0, y = 2 },
    boss = { min = 3 },
    config = { no_of_effect = 5 },
    boss_colour = HEX("8C4F80"),
    collection_loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    set_blind = function(self)
        StatusEffects.change_effect_level("stateff_poisoned", G.GAME.blind.effect.no_of_effect)
    end,
    disable = function(self)
        StatusEffects.change_effect_level("stateff_poisoned", -G.GAME.blind.effect.no_of_effect)
    end
}

SMODS.Blind {
    key = "hex",
    atlas = "Blinds",
    pos = { x = 0, y = 6 },
    boss = { min = 4 },
    config = { no_of_effect = 3 },
    boss_colour = HEX("D3DEA5"),
    collection_loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    loc_vars = function(self)
        return { vars = { self.config.no_of_effect } }
    end,
    set_blind = function(self)
        StatusEffects.change_effect_level("stateff_unlucky", G.GAME.blind.effect.no_of_effect)
    end,
    disable = function(self)
        StatusEffects.change_effect_level("stateff_unlucky", -G.GAME.blind.effect.no_of_effect)
    end
}