SMODS.Atlas {
    key = "StatusEffects",
    path = "StatusEffectsStatusIcons.png",
    px = 17,
    py = 17
}

SMODS.Atlas {
    key = "Burnt",
    path = "StatusEffectsBurnt.png",
    px = 17,
    py = 17
}

-- Thanks, YMA from Cold Beans!
function stateff_change_blind_requirement(mod_add)
    if not G.GAME.blind.original_chips then G.GAME.blind.original_chips = G.GAME.blind.chips end
    local original_chips = G.GAME.blind.original_chips > 0 and G.GAME.blind.original_chips or G.GAME.blind.chips
    mod_add = mod_add or 0
    mod_add = -math.ceil(G.GAME.blind.chips * mod_add / 100)

    local current_mult = G.GAME.blind.chips / (original_chips / G.GAME.blind.mult)
    local final_chips = (original_chips / G.GAME.blind.mult) * (current_mult) + mod_add
    local chip_mod
    if type(G.GAME.blind.chips) ~= "table" then
        chip_mod = math.ceil(math.abs(final_chips - G.GAME.blind.chips) / 120)
    else
        chip_mod = ((final_chips - G.GAME.blind.chips):abs() / 120):ceil()
    end
    local step = 0
    if G.GAME.blind.chips < final_chips then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            blockable = false,
            blocking = true,
            func = function()
                G.GAME.blind.chips = G.GAME.blind.chips + G.SETTINGS.GAMESPEED * chip_mod
                if G.GAME.blind.chips < final_chips then
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    if step % 5 == 0 then
                        play_sound("chips1", 0.8 + (step * 0.005))
                    end
                    step = step + 1
                else
                    G.GAME.blind.chips = final_chips
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.GAME.blind:wiggle()
                    return true
                end
            end
        }))
    else
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            blockable = false,
            blocking = true,
            func = function()
                G.GAME.blind.chips = G.GAME.blind.chips - G.SETTINGS.GAMESPEED * chip_mod
                if G.GAME.blind.chips > final_chips then
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    if step % 5 == 0 then
                        play_sound("chips1", 0.8 + (step * 0.005))
                    end
                    step = step - 1
                else
                    G.GAME.blind.chips = final_chips
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.GAME.blind:wiggle()
                    return true
                end
            end
        }))
    end
end

local function stateff_get_current_burn_pos()
    return { x = math.floor(os.time() * 3) % 3, y = 0 }
end

local click_ref = Card.click
function Card:click()
    local ret = click_ref(self)
    if self.ability and self.ability.stateff_burnt then
        self.ability.stateff_burnt = nil
        stateff_change_blind_requirement(-50)
    end
    return ret
end

SMODS.DrawStep {
    key = "burnt",
    order = 22,
    func = function(self, layer)
        if not self.stateff_burnt and self.ability and self.ability.stateff_burnt then
            local atlas = G.ASSET_ATLAS["stateff_Burnt"]
            self.stateff_burnt = Sprite(0, 0, atlas.px, atlas.py, atlas, stateff_get_current_burn_pos())
        end
        if self.stateff_burnt then
            self.stateff_burnt:set_sprite_pos(stateff_get_current_burn_pos())
            self.stateff_burnt.role.draw_major = self
            if not self.greyed then
                self.stateff_burnt:draw_shader("dissolve", nil, nil, nil, self.children.center)
            end
        end
    end,
    conditions = { vortex = false }
}

StatusEffects.define_effect {
    key = "burnt",
    pos = { x = 0, y = 0 },
    colour = HEX("FD5F55"),
    config = {},
    decrease_at_eor = 1,
    loc_vars = function(self, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    calculate = function(self, config, context)
        if context.first_hand_drawn then
            for i = 1, math.min(config.level, #G.hand.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.2,
                    func = function()
                        if G.hand.cards[i].ability then
                            G.hand.cards[i].ability.stateff_burnt = true
                        end
                        return true
                    end
                }))
            end
        end
    end
}

StatusEffects.define_effect {
    key = "frozen",
    pos = { x = 1, y = 0 },
    colour = HEX("41B7FF"),
    config = {},
    decrease_at_eor = 1,
    loc_vars = function(self, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config)
        local change = math.min(config.level, G.GAME.current_round.discards_left)
        config.removed = (config.removed or 0) + change
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - change
        ease_discard(-change)
    end,
    remove_effect = function(self, config, removal)
        local delta = config.removed
        local change = math.min(config.level, G.GAME.current_round.discards_left + config.removed)
        delta = delta - change
        config.removed = change
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + delta
        ease_discard(delta)
    end
}

StatusEffects.define_effect {
    key = "shocked",
    pos = { x = 2, y = 0 },
    colour = HEX("FDA200"),
    config = { money_per_level = 1 },
    decrease_at_eor = 1,
    loc_vars = function(self, config)
        return { config.level * config.money_per_level }
    end,
    calculate = function(self, config, context)
        if context.pre_discard then
            return { dollars = -config.level * config.money_per_level }
        end
    end
}

StatusEffects.define_effect {
    key = "blinded",
    pos = { x = 0, y = 1 },
    colour = HEX("FFFFFF"),
    decrease_at_eor = 1,
    loc_vars = function(self, config)
        return { config.level }
    end,
    calculate = function(self, config, context)
        if context.stay_flipped then
            local back_cards = 0
            for i = 1, #G.hand.cards do if G.hand.cards[i].facing == "back" then back_cards = back_cards + 1 end end

            if back_cards < config.level then
                return { stay_flipped = true }
            end
        end
    end
}

StatusEffects.define_effect {
    key = "cursed",
    pos = { x = 1, y = 1 },
    colour = HEX("FFFFFF"),
    config = { num = 1, denom = 2 },
    loc_vars = function(self, config)
        local num, denom = SMODS.get_probability_vars(self, config.num, config.denom, "stateff_cursed")
        return { num, denom }
    end,
    calculate = function(self, config, context)
        if context.debuff_hand and not context.check and G.GAME.current_round.hands_left > 0 and SMODS.pseudorandom_probability(self, "stateff_cursed", config.num, config.denom) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_cursed", -1)
                    return true
                end
            }))
            return { debuff = true }
        end
    end
}

StatusEffects.define_effect {
    key = "poisoned",
    pos = { x = 2, y = 1 },
    colour = HEX("8A71E1"),
    loc_vars = function(self, config)
        return { config.level }
    end,
    calculate = function(self, config, context)
        if context.end_of_round and not context.individual and not context.repetition then
            return { dollars = -config.level }
        end
    end
}

StatusEffects.define_effect {
    key = "lucky",
    pos = { x = 3, y = 1 },
    colour = HEX("D9DD61"),
    decrease_at_eor = 1,
    loc_vars = function(self, config)
        return { config.level, config.level + 1 }
    end,
    calculate = function(self, config, context)
        if context.mod_probability and not context.blueprint then
            return { numerator = context.numerator + config.level }
        end
    end
}

StatusEffects.define_effect {
    key = "unlucky",
    pos = { x = 2, y = 2 },
    colour = HEX("D9DD61"),
    decrease_at_eor = 1,
    loc_vars = function(self, config)
        return { config.level, config.level + 3 }
    end,
    calculate = function(self, config, context)
        if context.mod_probability and not context.blueprint then
            return { denominator = context.denominator + config.level }
        end
    end
}

StatusEffects.define_effect {
    key = "focused",
    pos = { x = 0, y = 3 },
    colour = HEX("FD5F55"),
    decrease_at_eor = 1,
    loc_vars = function(self, config)
        return { config.level, config.level + 3 }
    end,
    apply_effect = function(self, config)
        G.hand:change_size(config.level)
    end,
    remove_effect = function(self, config, removal)
        G.hand:change_size(-removal)
    end
}

StatusEffects.define_effect {
    key = "weakened",
    pos = { x = 3, y = 0 },
    colour = HEX("927E5C"),
    config = {},
    decrease_at_eor = 1,
    loc_vars = function(self, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config)
        if config.affected_hands then
            for k, v in pairs(config.affected_hands) do
                SMODS.upgrade_poker_hands { hands = k, level_up = v, instant = true }
            end
        end
        config.affected_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.level >= 2 then
                local levels = math.min(config.level, v.level - 1)
                SMODS.upgrade_poker_hands { hands = k, level_up = -levels, instant = true }
                config.affected_hands[k] = levels
            end
        end
    end,
    remove_effect = function(self, config, removal)
        if config.affected_hands then
            for k, v in pairs(config.affected_hands) do
                SMODS.upgrade_poker_hands { hands = k, level_up = v, instant = true }
            end
        end
        config.affected_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.level >= 2 then
                local levels = math.min(config.level, v.level - 1)
                SMODS.upgrade_poker_hands { hands = k, level_up = -levels, instant = true }
                config.affected_hands[k] = levels
            end
        end
    end
}
