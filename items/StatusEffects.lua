SMODS.Atlas {
    key = "StatusEffects",
    path = "StatusEffectsStatusIcons.png",
    px = 17,
    py = 17
}

SMODS.Atlas {
    key = "StatusEffects_dark",
    path = "StatusEffectsStatusIconsDark.png",
    px = 17,
    py = 17
}

SMODS.Atlas {
    key = "CardEffects",
    path = "StatusEffectsCardEffects.png",
    px = 71,
    py = 95
}

-- Thanks, YMA from Cold Beans!
function stateff_change_blind_requirement(mod_add, pitch_base, pitch_direction)
    if not G.GAME.blind.original_chips then G.GAME.blind.original_chips = G.GAME.blind.chips end
    local original_chips = G.GAME.blind.original_chips > 0 and G.GAME.blind.original_chips or G.GAME.blind.chips
    -- This is the value we should base our calculations on
    -- If we just use G.GAME.blind.chips and click during an animation is uses that value instead
    local working_chips = (G.GAME.blind.burn_chips or G.GAME.blind.chips)
    mod_add = mod_add or 0
    mod_add = -math.ceil(working_chips * mod_add / 100)
    pitch_base = pitch_base or 0.8
    pitch_direction = pitch_direction or 0.005

    local current_mult = working_chips / (original_chips / G.GAME.blind.mult)
    local final_chips = (original_chips / G.GAME.blind.mult) * (current_mult) + mod_add
    local chip_mod
    if type(working_chips) ~= "table" then
        chip_mod = math.ceil(math.abs(final_chips - working_chips) / 120)
    else
        chip_mod = ((final_chips - working_chips):abs() / 120):ceil()
    end
    local step = 0
    G.GAME.blind.burn_chips = final_chips

    local mod_direction = (mod_add < 0) and -1 or 1

    G.E_MANAGER:add_event(Event({
        trigger = "after",
        blockable = false,
        blocking = true,
        func = function()
            G.GAME.blind.chips = G.GAME.blind.chips + G.SETTINGS.GAMESPEED * chip_mod * mod_direction
            if G.GAME.blind.chips * mod_direction < final_chips * mod_direction then
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                if step % 5 == 0 then
                    play_sound("chips1", pitch_base + (step * pitch_direction))
                end
                step = step + 1
            else
                G.GAME.blind.chips = final_chips
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                if G.GAME.blind.burn_chips == final_chips then G.GAME.blind.burn_chips = nil end
                G.GAME.blind:wiggle()
                return true
            end
        end
    }))
end

local function stateff_get_current_burn_pos(card)
    return { x = math.floor(os.clock() * 8) % 3, y = 0 }
end

local function stateff_get_current_shining_pos(card)
    return { x = math.floor(os.clock() * 6) % 3, y = 1 }
end

local click_ref = Card.click
function Card:click()
    local ret = click_ref(self)
    if self.ability and self.ability.stateff_burnt and self.area == G.hand then
        self.ability.stateff_burnt = nil
        stateff_change_blind_requirement(-50)
        play_sound("stateff_burnt_off", 1, 0.7)
    end
    return ret
end

SMODS.DrawStep {
    key = "burnt",
    order = 22.1,
    func = function(self, layer)
        if self.ability.stateff_burnt then
            if not StatusEffects.shared_stateff_burnt then
                local atlas = G.ASSET_ATLAS["stateff_CardEffects"]
                StatusEffects.shared_stateff_burnt = Sprite(0, 0, atlas.px, atlas.py, atlas, { x = 0, y = 0 })
            end
            StatusEffects.shared_stateff_burnt.role.draw_major = self
            StatusEffects.shared_stateff_burnt:set_sprite_pos(stateff_get_current_burn_pos())
            StatusEffects.shared_stateff_burnt:draw_shader("dissolve", nil, nil, nil, self.children.center)
        end
    end,
    conditions = { vortex = false }
}

SMODS.Shader {
    key = "shining",
    path = "stateff_shining.fs"
}

SMODS.DrawStep {
    key = "shining",
    order = 22,
    func = function(self, layer)
        if self.ability.stateff_shining then
            if not StatusEffects.shared_stateff_shining then
                local atlas = G.ASSET_ATLAS["stateff_CardEffects"]
                StatusEffects.shared_stateff_shining = Sprite(0, 0, atlas.px, atlas.py, atlas, { x = 0, y = 1 })
            end
            if self.facing == "front" then
                self.children.center:draw_shader("stateff_shining", nil, self.ARGS.send_to_shader)
                if self.children.front and not self:should_hide_front() then
                    self.children.front:draw_shader("stateff_shining", nil, self.ARGS.send_to_shader)
                end
            else
                self.children.back:draw_shader("stateff_shining", nil, self.ARGS.send_to_shader)
            end
            StatusEffects.shared_stateff_shining.role.draw_major = self
            StatusEffects.shared_stateff_shining:set_sprite_pos(stateff_get_current_shining_pos())
            StatusEffects.shared_stateff_shining:draw_shader("dissolve", nil, nil, nil, self.children.center)
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
    loc_vars = function(self, info_queue, config)
        info_queue[#info_queue + 1] = { key = "stateff_burnt_info", set = "Other" }
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_burnt_apply", 1, 0.5) end
    end,
    calculate = function(self, config, context)
        if context.first_hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("stateff_burnt_on", 1, 0.8)
                    return true
                end
            }))
            for i = 1, math.min(config.level, #G.hand.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.5 / (math.min(config.level, #G.hand.cards)),
                    func = function()
                        if G.hand.cards[i].ability then
                            G.hand.cards[i].ability.stateff_burnt = true
                            G.hand.cards[i]:juice_up()
                        end
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.2,
                func = function()
                    save_run()
                    return true
                end
            }))
        end
    end,
    calculate_always = function(self, context)
        if context.end_of_round and not context.individual and not context.repetition then
            if G.playing_cards then
                for _, card in pairs(G.playing_cards) do
                    if card.ability and card.ability.stateff_burnt then
                        card.ability.stateff_burnt = nil
                    end
                end
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
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_frozen_apply", 1, 0.8) end
        local change = math.min(added, G.GAME.current_round.discards_left)
        config.removed = (config.removed or 0) + change
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - change
        ease_discard(-change)
    end,
    remove_effect = function(self, config, removal, args)
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
    loc_vars = function(self, info_queue, config)
        return { config.level * config.money_per_level }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_shocked_apply", 1, 0.6) end
    end,
    calculate = function(self, config, context)
        if context.pre_discard then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("stateff_shocked_on", 1, 0.6)
                    return true
                end
            }))
            return { dollars = -config.level * config.money_per_level }
        end
    end
}

StatusEffects.define_effect {
    key = "blinded",
    pos = { x = 0, y = 1 },
    colour = HEX("FFFFFF"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_blinded_apply", 1, 0.5) end
    end,
    calculate = function(self, config, context)
        if context.stay_flipped and context.to_area == G.hand then
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
    config = { num = 1, denom = 3 },
    loc_vars = function(self, info_queue, config)
        local num, denom = SMODS.get_probability_vars(self, config.num, config.denom, "stateff_cursed")
        return { num, denom }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_cursed_apply", 1, 0.45) end
    end,
    calculate = function(self, config, context)
        if context.debuff_hand and not context.check and G.GAME.current_round.hands_left > 0 and SMODS.pseudorandom_probability(self, "stateff_cursed", config.num, config.denom) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("stateff_cursed_on", 1, 0.35)
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
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_poisoned_apply", 1, 0.5) end
    end,
    calculate = function(self, config, context)
        if context.end_of_round and not context.individual and not context.repetition then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("stateff_poisoned_on", 1, 0.5)
                    return true
                end
            }))
            return { dollars = -config.level }
        end
    end
}

StatusEffects.define_effect {
    key = "lucky",
    pos = { x = 3, y = 1 },
    colour = HEX("D9DD61"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level + 1 }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_lucky_apply", 1, 0.4) end
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
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level + 3 }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_unlucky_apply", 1, 0.45) end
    end,
    calculate = function(self, config, context)
        if context.mod_probability and not context.blueprint then
            return { denominator = context.denominator + config.level }
        end
    end
}

StatusEffects.define_effect {
    key = "focused",
    pos = { x = 0, y = 2 },
    colour = HEX("FD5F55"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_focused_apply", 1, 0.4) end
        G.hand:change_size(added)
    end,
    remove_effect = function(self, config, removal, args)
        G.hand:change_size(-removal)
    end
}

StatusEffects.define_effect {
    key = "clairvoyant",
    pos = { x = 3, y = 2 },
    colour = HEX("8A71E1"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_clairvoyant_apply", 1, 0.4) end
        change_shop_size(added)
    end,
    remove_effect = function(self, config, removal, args)
        change_shop_size(-removal)
    end
}

StatusEffects.define_effect {
    key = "weakened",
    pos = { x = 3, y = 0 },
    colour = HEX("927E5C"),
    config = {},
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    calculate = function(self, config, context)
        if context.poker_hand_changed and not stateff_ignore_these_upgrades_please then
            stateff_ignore_these_upgrades_please = true
            local v = G.GAME.hands[context.scoring_name]
            SMODS.upgrade_poker_hands { hands = context.scoring_name, level_up = config.affected_hands[context.scoring_name], instant = true }
            if v.level >= 2 then
                local levels = math.min(config.level, v.level - 1)
                SMODS.upgrade_poker_hands { hands = context.scoring_name, level_up = -levels, instant = true }
                config.affected_hands[context.scoring_name] = levels
            else
                config.affected_hands[context.scoring_name] = nil
            end
            stateff_ignore_these_upgrades_please = nil
        end
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_weakened_apply", 1, 0.3) end
        stateff_ignore_these_upgrades_please = true
        if config.affected_hands then
            for k, v in pairs(config.affected_hands) do
                SMODS.upgrade_poker_hands { hands = k, level_up = v, instant = true }
            end
        end
        config.affected_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.level >= 2 then
                local levels = math.min(added, v.level - 1)
                SMODS.upgrade_poker_hands { hands = k, level_up = -levels, instant = true }
                config.affected_hands[k] = levels
            end
        end
        stateff_ignore_these_upgrades_please = nil
    end,
    remove_effect = function(self, config, removal, args)
        stateff_ignore_these_upgrades_please = true
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
        stateff_ignore_these_upgrades_please = nil
    end
}

StatusEffects.define_effect {
    key = "swift",
    pos = { x = 1, y = 2 },
    colour = HEX("41B7FF"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_swift_apply", 1, 0.5) end
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + added
        ease_hands_played(added)
    end,
    remove_effect = function(self, config, removal, args)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - removal
        ease_hands_played(-removal)
    end
}

StatusEffects.define_effect {
    key = "furious",
    pos = { x = 2, y = 3 },
    colour = HEX("FD5F55"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_furious_apply", 1, 0.4) end
    end,
    calculate = function(self, config, context)
        if context.cardarea == G.play and context.repetition then
            return { repetitions = config.level }
        end
    end
}

StatusEffects.define_effect {
    key = "invisible",
    pos = { x = 3, y = 3 },
    colour = HEX("927E5C"),
    decrease_at_eor = 1,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_invisible_apply", 1, 0.6) end
    end,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural"), config.level ~= 1 and "" or localize("stateff_plural") }
    end
}

StatusEffects.define_effect {
    key = "glowing",
    pos = { x = 0, y = 4 },
    colour = HEX("FDA200"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        info_queue[#info_queue + 1] = { key = "stateff_shining_info", set = "Other" }
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_glowing_apply", 1, 0.5) end
    end,
    calculate = function(self, config, context)
        if context.first_hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("stateff_glowing_on", 1, 0.7)
                    return true
                end
            }))
            for i = #G.hand.cards, #G.hand.cards - math.min(config.level, #G.hand.cards) + 1, -1 do
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.5 / (math.min(config.level, #G.hand.cards)),
                    func = function()
                        if G.hand.cards[i].ability then
                            G.hand.cards[i].ability.stateff_shining = true
                            G.hand.cards[i]:juice_up()
                        end
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.2,
                func = function()
                    save_run()
                    return true
                end
            }))
        end
    end,
    calculate_always = function(self, context)
        if context.end_of_round and not context.individual and not context.repetition then
            if G.playing_cards then
                for _, card in pairs(G.playing_cards) do
                    if card.ability and card.ability.stateff_shining then
                        card.ability.stateff_shining = nil
                    end
                end
            end
        end

        if context.individual and context.cardarea == G.play and context.other_card.ability.stateff_shining then
            return { dollars = 4, message_card = context.other_card }
        end
    end
}

StatusEffects.define_effect {
    key = "guarded",
    pos = { x = 1, y = 4 },
    colour = HEX("927E5C"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_guarded_apply", 1, 0.7) end
    end,
    calculate = function(self, config, context)
        if context.end_of_round and context.game_over and context.main_eval and not context.blueprint then
            if to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) >= to_big(0.25) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound("tarot1")
                        StatusEffects.clear_effect("stateff_guarded")
                        return true
                    end
                }))
                return {
                    message = localize("k_saved_ex"),
                    saved = "ph_stateff_guarded",
                    colour = G.C.RED
                }
            end
        end
    end
}

StatusEffects.define_effect {
    key = "arcane",
    pos = { x = 2, y = 4 },
    colour = HEX("8A71E1"),
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_arcane_apply", 1, 0.5) end
    end,
    calculate = function(self, config, context)
        if context.after then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card { set = "Tarot", key_append = "stateff_arcane" }
                        G.GAME.consumeable_buffer = 0
                        StatusEffects.change_effect_level("stateff_arcane", -1)
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_tarot"),
                    colour = G.C.SECONDARY_SET.Tarot
                }
            else
                return {
                    message = localize("k_no_room_ex"),
                    colour = G.C.RED
                }
            end
        end
    end
}

StatusEffects.define_effect {
    key = "lunatic",
    pos = { x = 3, y = 4 },
    colour = HEX("41B7FF"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_lunatic_apply", 1, 0.5) end
    end
}

local can_sell_card_ref = Card.can_sell_card
function Card:can_sell_card(context)
    if self.ability.consumeable and StatusEffects.get_effect("stateff_lunatic") > 0 then
        return false
    end
    return can_sell_card_ref(self, context)
end

StatusEffects.define_effect {
    key = "mana",
    pos = { x = 0, y = 3 },
    colour = HEX("FFFFFF"),
    loc_vars = function(self, info_queue, config)
        return { config.level }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_mana_apply", 1, 0.6) end
    end
}

StatusEffects.define_effect {
    key = "divine",
    pos = { x = 1, y = 3 },
    colour = HEX("FDA200"),
    decrease_at_eor = 1,
    loc_vars = function(self, info_queue, config)
        return { config.level, config.level == 1 and "" or localize("stateff_plural") }
    end,
    apply_effect = function(self, config, added, args)
        if not (args and args.silent) then play_sound("stateff_divine_apply", 1, 0.7) end
        G.jokers.config.card_limit = G.jokers.config.card_limit + added
    end,
    remove_effect = function(self, config, removal, args)
        G.jokers.config.card_limit = G.jokers.config.card_limit - removal
    end
}
