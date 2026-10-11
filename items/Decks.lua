SMODS.Atlas {
    key = "Decks",
    path = "StatusEffectsDecks.png",
    px = 71,
    py = 95
}

SMODS.Back {
    key = "oracle",
    atlas = "Decks",
    pos = { x = 0, y = 0 },
    config = { extra = { mana = 10, clairvoyant = 2, arcane = 2 } },
    loc_vars = function(self, info_queue, back)
        return {
            vars = {
                self.config.extra.mana,
                self.config.extra.clairvoyant,
                self.config.extra.arcane,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = self.config.extra.mana, dark = true },
                    StatusEffects.create_hoverable_icon { key = "stateff_clairvoyant", level = self.config.extra.clairvoyant },
                    StatusEffects.create_hoverable_icon { key = "stateff_arcane", level = self.config.extra.arcane } },
            }
        }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.4,
            func = function()
                StatusEffects.change_effect_level("stateff_mana", self.config.extra.mana)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.4,
            func = function()
                StatusEffects.change_effect_level("stateff_clairvoyant", self.config.extra.clairvoyant)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.4,
            func = function()
                StatusEffects.change_effect_level("stateff_arcane", self.config.extra.arcane)
                return true
            end
        }))
    end
}
