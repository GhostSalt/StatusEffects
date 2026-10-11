SMODS.Joker:take_ownership("joker", {
    config = { extra = { mult = 4, mana = 1 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return { key = key, vars = { card.ability.extra.mult, card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } } } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                return { mult = card.ability.extra.mult * 2 }
            else
                return { mult = card.ability.extra.mult }
            end
        end
    end
}, true)

local sin_jokers = { "greedy_joker", "lusty_joker", "wrathful_joker", "gluttenous_joker" }
local sin_extras = {
    { mana = 1, s_mult = 3, suit = "Diamonds" },
    { mana = 1, s_mult = 3, suit = "Hearts" },
    { mana = 1, s_mult = 3, suit = "Spades" },
    { mana = 1, s_mult = 3, suit = "Clubs" }
}
for i = 1, #sin_jokers do
    SMODS.Joker:take_ownership(sin_jokers[i], {
        config = { extra = sin_extras[i] },
        loc_vars = function(self, info_queue, card)
            local key = self.key .. "_mana"
            return {
                key = key,
                vars = {
                    card.ability.extra.s_mult,
                    localize(card.ability.extra.suit, "suits_singular"),
                    card.ability.extra.mana,
                    localize(card.ability.extra.suit, "suits_plural"),
                    elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
                }
            }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
                if context.other_card:is_suit(card.ability.extra.suit) then
                    return {
                        mult = card.ability.extra.s_mult
                    }
                elseif StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                    local _card = context.other_card
                    StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                            StatusEffects.clear_effect_buffer("stateff_mana")
                            play_sound("tarot1")
                            card:juice_up()
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.20,
                        func = function()
                            _card:flip()
                            play_sound("card1", 1)
                            _card:juice_up(0.30, 0.3)
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.50,
                        func = function()
                            _card:change_suit(card.ability.extra.suit)
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        delay = 0.20,
                        func = function()
                            _card:flip()
                            play_sound("tarot2", 1)
                            _card:juice_up(0.30, 0.3)
                            return true
                        end
                    }))
                    return { message = localize(card.ability.extra.suit, "suits_plural"), colour = G.C.SUITS[card.ability.extra.suit] }
                end
            end
        end
    }, true)
end

local hand_type_mults = { "jolly", "zany", "mad", "crazy", "droll" }
local hand_type_mult_extras = {
    { mana = 2, t_mult = 8,  type = "Pair" },
    { mana = 2, t_mult = 12, type = "Three of a Kind" },
    { mana = 2, t_mult = 10, type = "Two Pair" },
    { mana = 2, t_mult = 12, type = "Straight" },
    { mana = 2, t_mult = 10, type = "Flush" }
}
for i = 1, #hand_type_mults do
    SMODS.Joker:take_ownership(hand_type_mults[i], {
        config = { extra = hand_type_mult_extras[i] },
        loc_vars = function(self, info_queue, card)
            local key = self.key .. "_mana"
            return {
                key = key,
                vars = {
                    card.ability.extra.t_mult,
                    localize(card.ability.extra.type, "poker_hands"),
                    card.ability.extra.mana,
                    elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
                }
            }
        end,
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
                if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                    return { mult = card.ability.extra.t_mult * 2 }
                else
                    return { mult = card.ability.extra.t_mult }
                end
            end
        end
    }, true)
end

local hand_type_chips = { "sly", "wily", "clever", "devious", "crafty" }
local hand_type_chip_extras = {
    { mana = 3, t_chips = 50,  type = "Pair" },
    { mana = 3, t_chips = 100, type = "Three of a Kind" },
    { mana = 3, t_chips = 80,  type = "Two Pair" },
    { mana = 3, t_chips = 100, type = "Straight" },
    { mana = 3, t_chips = 80,  type = "Flush" }
}
for i = 1, #hand_type_chips do
    SMODS.Joker:take_ownership(hand_type_chips[i], {
        config = { extra = hand_type_chip_extras[i] },
        loc_vars = function(self, info_queue, card)
            local key = self.key .. "_mana"
            return {
                key = key,
                vars = {
                    card.ability.extra.t_chips,
                    localize(card.ability.extra.type, "poker_hands"),
                    card.ability.extra.mana,
                    elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
                }
            }
        end,
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
                if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                    return { chips = card.ability.extra.t_chips * 2 }
                else
                    return { chips = card.ability.extra.t_chips }
                end
            end
        end
    }, true)
end

SMODS.Joker:take_ownership("stencil", {
    config = { extra = { mana = 4, extra_per_right = 0.5 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local my_pos
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
        end
        local added_bonus = (not my_pos or (StatusEffects.get_effect("stateff_mana") < card.ability.extra.mana)) and 0 or
            card.ability.extra.extra_per_right * (#G.jokers.cards - my_pos)

        return {
            key = key,
            vars = {
                (G.jokers and math.max(1, (G.jokers.config.card_limit - #G.jokers.cards) + #SMODS.find_card("j_stencil", true)) or 1) + added_bonus,
                card.ability.extra.mana,
                card.ability.extra.extra_per_right,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            local added_bonus = (not my_pos or (StatusEffects.get_effect("stateff_mana") < card.ability.extra.mana)) and 0 or
                card.ability.extra.extra_per_right * (#G.jokers.cards - my_pos)
            return { xmult = math.max(1, (G.jokers.config.card_limit - #G.jokers.cards) + #SMODS.find_card("j_stencil", true)) + added_bonus }
        end
    end
}, true)

SMODS.Joker:take_ownership("credit_card", {
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } }
            }
        }
    end,
    calc_dollar_bonus = function(self, card)
        local dollars = StatusEffects.get_effect("stateff_mana")
        if dollars > 0 then return dollars end
    end
}, true)

SMODS.Joker:take_ownership("banner", {
    config = { extra = { chips = 30, mana = 1, added_chips = 4 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mana,
                card.ability.extra.added_chips,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
            StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    return true
                end
            }))
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.added_chips
            return { message = localize("k_upgrade_ex") }
        end

        if context.joker_main then
            return {
                chips = G.GAME.current_round.discards_left * card.ability.extra.chips
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("8_ball", {
    config = { extra = 4, stateff_mana = 1 },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra, "8ball")
        return { key = key, vars = { num, denom, card.ability.stateff_mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.stateff_mana, dark = true } } } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if (context.other_card:get_id() == 8) and (SMODS.pseudorandom_probability(card, "8ball", 1, card.ability.extra)
                    or StatusEffects.get_effect("stateff_mana") >= card.ability.stateff_mana) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                if StatusEffects.get_effect("stateff_mana") >= card.ability.stateff_mana then
                    StatusEffects.change_effect_buffer("stateff_mana", -card.ability.stateff_mana)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            StatusEffects.change_effect_level("stateff_mana", -card.ability.stateff_mana)
                            StatusEffects.clear_effect_buffer("stateff_mana")
                            return true
                        end
                    }))
                end
                return {
                    extra = {
                        message = localize("k_plus_tarot"),
                        message_card = card,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card { set = "Tarot", key_append = "8ba" }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    }
                }
            end
        end
    end
}, true)

SMODS.Joker:take_ownership("misprint", {
    config = { extra = { max = 23, min = 0, mana = 2, money_max = 2, money_min = 0 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local r_money = {}
        for i = card.ability.extra.money_min, card.ability.extra.money_max do
            r_money[#r_money + 1] = tostring(i)
        end
        r_money[#r_money + 1] = "#"
        r_money[#r_money + 1] = "?"
        local main_end = {
            { n = G.UIT.T, config = { text = " +$", colour = G.C.GOLD, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_money, colours = { G.C.GOLD }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
        }
        return {
            key = key,
            main_end = main_end,
            vars = {
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.stateff_mana, dark = true } }
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local money
            if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                money = pseudorandom("misprint", card.ability.extra.money_min, card.ability.extra.money_max)
                if money == 0 then money = nil end
            end
            return {
                mult = pseudorandom("misprint", card.ability.extra.min, card.ability.extra.max),
                dollars = money
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("gros_michel", {
    config = { extra = { odds = 6, lucky = 2, mult = 15 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "gros_michel")
        local eff = StatusEffects.ALL_EFFECTS["stateff_lucky"]
        local config = copy_table(StatusEffects.ALL_EFFECTS["stateff_lucky"].config or {})
        config.level = card.ability.extra.lucky
        info_queue[#info_queue + 1] = { set = "Other", key = "stateff_stateff_lucky", specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, config) or {}) }
        return {
            key = key,
            vars = {
                card.ability.extra.mult,
                num,
                denom,
                card.ability.extra.lucky,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_lucky", level = card.ability.extra.lucky } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, "gros_michel", 1, card.ability.extra.odds) then
                StatusEffects.change_effect_buffer("stateff_lucky", card.ability.extra.lucky)
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    timer = "REAL",
                    delay = 1,
                    func = function()
                        play_sound("stateff_eat", 1, 0.6)
                        card:juice_up()
                        StatusEffects.change_effect_level("stateff_lucky", card.ability.extra.lucky)
                        StatusEffects.clear_effect_buffer("stateff_lucky")
                        return true
                    end
                }))
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.gros_michel_extinct = true
                return { message = localize("k_extinct_ex") }
            else
                return { message = localize("k_safe_ex") }
            end
        end

        if context.joker_main then return { mult = card.ability.extra.mult } end
    end
}, true)

SMODS.Joker:take_ownership("loyalty_card", {
    config = { extra = { Xmult = 4, every = 5, loyalty_remaining = 5, mana = 4, extra_m = 1 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.every + 1,
                localize { type = "variable", key = (card.ability.extra.loyalty_remaining == 0 and "loyalty_active" or "loyalty_inactive"), vars = { card.ability.extra.loyalty_remaining } },
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.loyalty_remaining = card.ability.extra.loyalty_remaining - 1
            if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                card.ability.extra.loyalty_remaining = card.ability.extra.loyalty_remaining - card.ability.extra.extra_m
            end
        end
        if context.joker_main then
            if not context.blueprint then
                if card.ability.extra.loyalty_remaining == 0 then
                    local eval = function(card) return card.ability.extra.loyalty_remaining == 0 and not G.RESET_JIGGLES end
                    juice_card_until(card, eval, true)
                end
            end
            if card.ability.extra.loyalty_remaining < 0 then
                card.ability.extra.loyalty_remaining = card.ability.extra.every
                return { xmult = card.ability.extra.Xmult }
            end
        end
    end
}, true)

SMODS.Joker:take_ownership("space", {
    config = { extra = 4, stateff_mana = 1 },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra, "space")
        return { key = key, vars = { num, denom, card.ability.stateff_mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.stateff_mana, dark = true } } } }
    end,
    calculate = function(self, card, context)
        if context.before and (SMODS.pseudorandom_probability(card, "space", 1, card.ability.extra)
                or StatusEffects.get_effect("stateff_mana") >= card.ability.stateff_mana) then
            if StatusEffects.get_effect("stateff_mana") >= card.ability.stateff_mana then
                StatusEffects.change_effect_buffer("stateff_mana", -card.ability.stateff_mana)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        StatusEffects.change_effect_level("stateff_mana", -card.ability.stateff_mana)
                        StatusEffects.clear_effect_buffer("stateff_mana")
                        return true
                    end
                }))
            end
            return {
                level_up = true,
                message = localize("k_level_up_ex")
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("burglar", {
    config = { extra = { hands = 3, bonus_hands = 2, mana = 2 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.hands,
                card.ability.extra.bonus_hands,
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local hands = card.ability.extra.hands
            if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                hands = card.ability.extra.hands + card.ability.extra.bonus_hands
                StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                        StatusEffects.clear_effect_buffer("stateff_mana")
                        return true
                    end
                }))
            end
            local _card = context.blueprint_card or card
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(-G.GAME.current_round.discards_left, nil, true)
                    ease_hands_played(hands)
                    SMODS.calculate_effect({ message = localize { type = "variable", key = "a_hands", vars = { hands } } }, _card)
                    return true
                end
            }))
            return nil, true
        end
    end
}, true)

SMODS.Joker:take_ownership("ice_cream", {
    config = { extra = { chips = 100, chip_mod = 5, swift = 4 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local eff = StatusEffects.ALL_EFFECTS["stateff_swift"]
        local config = copy_table(StatusEffects.ALL_EFFECTS["stateff_swift"].config or {})
        config.level = card.ability.extra.swift
        info_queue[#info_queue + 1] = { set = "Other", key = "stateff_stateff_swift", specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, config) or {}) }
        return {
            key = key,
            vars = { card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.swift, elements = { StatusEffects.create_hoverable_icon { key = "stateff_swift", level = card.ability.extra.swift } } }
        }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.chips - card.ability.extra.chip_mod <= 0 then
                StatusEffects.change_effect_buffer("stateff_swift", card.ability.extra.swift)
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    timer = "REAL",
                    delay = 1,
                    func = function()
                        play_sound("stateff_eat", 1, 0.6)
                        card:juice_up()
                        StatusEffects.change_effect_level("stateff_swift", card.ability.extra.swift)
                        StatusEffects.clear_effect_buffer("stateff_swift")
                        return true
                    end
                }))
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_melted_ex"),
                    colour = G.C.CHIPS
                }
            else
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_mod
                return {
                    message = localize { type = "variable", key = "a_chips_minus", vars = { card.ability.extra.chip_mod } },
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main then return { chips = card.ability.extra.chips } end
    end
}, true)

SMODS.Joker:take_ownership("dna", {
    config = { extra = { mana = 3 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = { card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } } }
        }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local card_copied = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            card_copied:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, card_copied)
            G.hand:emplace(card_copied)
            card_copied.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    card_copied:start_materialize()
                    return true
                end
            }))

            local card_copied_dos
            if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                card_copied_dos = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                card_copied_dos:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card_copied_dos)
                G.hand:emplace(card_copied_dos)
                card_copied_dos.states.visible = nil
                StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)

                G.E_MANAGER:add_event(Event({
                    func = function()
                        StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                        StatusEffects.clear_effect_buffer("stateff_mana")
                        card_copied_dos:start_materialize(nil, true)
                        return true
                    end
                }))
            end
            return {
                message = localize("k_copied_ex"),
                colour = G.C.CHIPS,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                            if card_copied_dos then SMODS.calculate_context({ playing_card_added = true, cards = { card_copied_dos } }) end
                            return true
                        end
                    }))
                end
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("sixth_sense", {
    config = { extra = { mana = 3 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = { card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } } }
        }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and not context.blueprint then
            if #context.full_hand == 1 and context.destroy_card == context.full_hand[1] and context.full_hand[1]:get_id() == 6 and G.GAME.current_round.hands_played == 0 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    StatusEffects.change_effect_buffer("stateff_mana", card.ability.extra.mana)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            StatusEffects.change_effect_level("stateff_mana", card.ability.extra.mana)
                            StatusEffects.clear_effect_buffer("stateff_mana")
                            SMODS.add_card {
                                set = "Spectral",
                                key_append = "sixth_sense"
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    return {
                        message = localize("k_plus_spectral"),
                        colour = G.C.SECONDARY_SET.Spectral,
                        remove = true
                    }
                end
                return { remove = true }
            end
        end
    end
}, true)

SMODS.Joker:take_ownership("hiker", {
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = { card.ability.extra, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra, dark = true } } }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra + StatusEffects.get_effect("stateff_mana")
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("superposition", {
    config = { extra = { mana = 1, invisible = 1 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local eff = StatusEffects.ALL_EFFECTS["stateff_invisible"]
        local config = copy_table(StatusEffects.ALL_EFFECTS["stateff_invisible"].config or {})
        config.level = card.ability.extra.invisible
        info_queue[#info_queue + 1] = { set = "Other", key = "stateff_stateff_invisible", specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, config) or {}) }
        return {
            key = key,
            vars = {
                card.ability.extra.mana,
                card.ability.extra.invisible,
                elements = {
                    StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra, dark = true },
                    StatusEffects.create_hoverable_icon { key = "stateff_invisible", level = card.ability.extra.invisible }
                }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Straight"]) and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local ace_check = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 then
                    ace_check = true
                    break
                end
            end
            if ace_check then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                    StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
                    StatusEffects.change_effect_buffer("stateff_invisible", card.ability.extra.invisible)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                            StatusEffects.clear_effect_buffer("stateff_mana")
                            StatusEffects.change_effect_level("stateff_invisible", card.ability.extra.invisible)
                            StatusEffects.clear_effect_buffer("stateff_invisible")
                            return true
                        end
                    }))
                end
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = "Tarot",
                            key_append = "sup"
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize("k_plus_tarot"),
                    colour = G.C.SECONDARY_SET.Tarot,
                }
            end
        end
    end
}, true)

SMODS.Joker:take_ownership("todo_list", {
    config = { to_do_poker_hand = "High Card", extra = { dollars = 4, mana = 1 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.dollars,
                localize(card.ability.to_do_poker_hand, "poker_hands"),
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.to_do_poker_hand then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.to_do_poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.to_do_poker_hand = pseudorandom_element(_poker_hands, "to_do")
            if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
                card.ability.to_do_poker_hand = "High Card"
                G.E_MANAGER:add_event(Event({
                    func = function()
                        StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                        StatusEffects.clear_effect_buffer("stateff_mana")
                        return true
                    end
                }))
            end
            return { message = localize("k_reset") }
        end
    end
}, true)

SMODS.Joker:take_ownership("cavendish", {
    config = { extra = { odds = 1000, unlucky = 3, Xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "gros_michel")
        local eff = StatusEffects.ALL_EFFECTS["stateff_unlucky"]
        local config = copy_table(StatusEffects.ALL_EFFECTS["stateff_unlucky"].config or {})
        config.level = card.ability.extra.unlucky
        info_queue[#info_queue + 1] = { set = "Other", key = "stateff_stateff_unlucky", specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, config) or {}) }
        return {
            key = key,
            vars = {
                card.ability.extra.Xmult,
                num,
                denom,
                card.ability.extra.unlucky,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_unlucky", level = card.ability.extra.unlucky } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, "cavendish", 1, card.ability.extra.odds) then
                StatusEffects.change_effect_buffer("stateff_unlucky", card.ability.extra.unlucky)
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    timer = "REAL",
                    delay = 1,
                    func = function()
                        play_sound("stateff_eat", 1, 0.6)
                        card:juice_up()
                        StatusEffects.change_effect_level("stateff_unlucky", card.ability.extra.unlucky)
                        StatusEffects.clear_effect_buffer("stateff_unlucky")
                        return true
                    end
                }))
                SMODS.destroy_cards(card, nil, nil, true)
                return { message = localize("k_extinct_ex") }
            else
                return { message = localize("k_safe_ex") }
            end
        end

        if context.joker_main then return { xmult = card.ability.extra.Xmult } end
    end
}, true)

SMODS.Joker:take_ownership("madness", {
    config = { extra = { xmult_gain = 0.5, xmult = 1, mana = 1, sad_xmult_gain = 0.3 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult,
                card.ability.extra.mana,
                card.ability.extra.sad_xmult_gain,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and not context.blind.boss then
            if StatusEffects.get_effect("stateff_mana") < card.ability.extra.mana then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                local destructable_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                        destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
                    end
                end
                local joker_to_destroy = pseudorandom_element(destructable_jokers, "madness")

                if joker_to_destroy then
                    joker_to_destroy.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            (context.blueprint_card or card):juice_up(0.8, 0.8)
                            joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                            return true
                        end
                    }))
                end
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.sad_xmult_gain
            end
            return { message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } } }
        end

        if context.joker_main then return { xmult = card.ability.extra.xmult } end
    end
}, true)

SMODS.Joker:take_ownership("seance", {
    config = { extra = { poker_hand = "Straight Flush", mana = 3 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                localize(card.ability.extra.poker_hand, "poker_hands"),
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.poker_hand]) and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            StatusEffects.change_effect_buffer("stateff_mana", card.ability.extra.mana)
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_mana", card.ability.extra.mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    SMODS.add_card {
                        set = "Spectral",
                        key_append = "sea"
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return {
                message = localize("k_plus_spectral"),
                colour = G.C.SECONDARY_SET.Spectral
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("vampire", {
    config = { extra = { Xmult_gain = 0.1, Xmult = 1, mana = 2 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.Xmult_gain,
                card.ability.extra.Xmult,
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local enhanced = {}
            local has_subtracted_mana = false
            for _, scored_card in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff and not scored_card.vampired then
                    enhanced[#enhanced + 1] = scored_card
                    if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                        if not has_subtracted_mana then
                            has_subtracted_mana = true
                            StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                                    StatusEffects.clear_effect_buffer("stateff_mana")
                                    return true
                                end
                            }))
                        end
                    else
                        scored_card.vampired = true
                        scored_card:set_ability("c_base", nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                scored_card.vampired = nil
                                return true
                            end
                        }))
                    end
                end
            end

            if #enhanced > 0 then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain * #enhanced
                return {
                    message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } },
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then return { xmult = card.ability.extra.Xmult } end
    end
}, true)

SMODS.Joker:take_ownership("golden", {
    config = { extra = 4, stateff_mana = 2 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra,
                card.ability.stateff_mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.stateff_mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            StatusEffects.change_effect_buffer("stateff_mana", card.ability.stateff_mana)
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_mana", card.ability.stateff_mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    return true
                end
            }))
            return { message = localize { type = "variable", key = "a_mana", vars = { card.ability.stateff_mana } } }
        end
    end
}, true)

SMODS.Joker:take_ownership("diet_cola", {
    config = { extra = { mana = 4 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        info_queue[#info_queue + 1] = { key = "tag_double", set = "Tag" }
        return {
            key = key,
            vars = {
                localize { type = "name_text", set = "Tag", key = "tag_double" },
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            StatusEffects.change_effect_buffer("stateff_mana", card.ability.extra.mana)
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                timer = "REAL",
                delay = 0.5,
                func = function()
                    play_sound("stateff_drink_potion", 1, 0.8)
                    card:juice_up()
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                timer = "REAL",
                delay = 1,
                func = function()
                    card:juice_up()
                    StatusEffects.change_effect_level("stateff_mana", card.ability.extra.mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    add_tag({ key = "tag_double" })
                    play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
            return nil, true
        end
    end
}, true)

SMODS.Joker:take_ownership("popcorn", {
    config = { extra = { mult_loss = 4, mult = 20, mana = 1 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_loss,
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_loss
                G.E_MANAGER:add_event(Event({
                    func = function()
                        StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                        StatusEffects.clear_effect_buffer("stateff_mana")
                        return true
                    end
                }))
                return {
                    message = localize { type = "variable", key = "a_mult", vars = { card.ability.extra.mult_loss } },
                    colour = G.C.MULT
                }
            else
                if card.ability.extra.mult - card.ability.extra.mult_loss <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = localize("k_eaten_ex"),
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_loss
                    return {
                        message = localize { type = "variable", key = "a_mult_minus", vars = { card.ability.extra.mult_loss } },
                        colour = G.C.MULT
                    }
                end
            end
        end
        if context.joker_main then return { mult = card.ability.extra.mult } end
    end
}, true)

SMODS.Joker:take_ownership("ramen", {
    config = { extra = { Xmult_loss = 0.01, Xmult = 2, furious = 3 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local eff = StatusEffects.ALL_EFFECTS["stateff_furious"]
        local config = copy_table(StatusEffects.ALL_EFFECTS["stateff_furious"].config or {})
        config.level = card.ability.extra.furious
        info_queue[#info_queue + 1] = { set = "Other", key = "stateff_stateff_furious", specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, config) or {}) }
        return {
            key = key,
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_loss,
                card.ability.extra.furious,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_furious", level = card.ability.extra.furious } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            if card.ability.extra.Xmult - card.ability.extra.Xmult_loss <= 1 then
                StatusEffects.change_effect_buffer("stateff_furious", card.ability.extra.furious)
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    timer = "REAL",
                    delay = 1,
                    func = function()
                        play_sound("stateff_eat", 1, 0.6)
                        card:juice_up()
                        StatusEffects.change_effect_level("stateff_furious", card.ability.extra.furious)
                        StatusEffects.clear_effect_buffer("stateff_furious")
                        return true
                    end
                }))
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex"),
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_loss
                return {
                    message = localize { type = "variable", key = "a_xmult_minus", vars = { card.ability.extra.Xmult_loss } },
                    colour = G.C.RED,
                    delay = 0.2
                }
            end
        end
        if context.joker_main then return { xmult = card.ability.extra.Xmult } end
    end
}, true)

SMODS.Joker:take_ownership("selzer", {
    config = { extra = { hands_left = 10, confident = 2 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        local eff = StatusEffects.ALL_EFFECTS["stateff_confident"]
        local config = copy_table(StatusEffects.ALL_EFFECTS["stateff_confident"].config or {})
        config.level = card.ability.extra.confident
        info_queue[#info_queue + 1] = { set = "Other", key = "stateff_stateff_confident", specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, config) or {}) }
        return {
            key = key,
            vars = {
                card.ability.extra.hands_left,
                card.ability.extra.confident,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_confident", level = card.ability.extra.confident } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return { repetitions = 1 }
        end
        if context.after and not context.blueprint then
            if card.ability.extra.hands_left - 1 <= 0 then
                StatusEffects.change_effect_buffer("stateff_confident", card.ability.extra.confident)
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    timer = "REAL",
                    delay = 0.5,
                    func = function()
                        play_sound("stateff_drink_potion", 1, 0.8)
                        card:juice_up()
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    timer = "REAL",
                    delay = 1,
                    func = function()
                        card:juice_up()
                        StatusEffects.change_effect_level("stateff_confident", card.ability.extra.confident)
                        StatusEffects.clear_effect_buffer("stateff_confident")
                        return true
                    end
                }))
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_drank_ex"),
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.hands_left = card.ability.extra.hands_left - 1
                return {
                    message = card.ability.extra.hands_left .. "",
                    colour = G.C.FILTER
                }
            end
        end
    end
}, true)

SMODS.Joker:take_ownership("flower_pot", {
    config = { extra = { Xmult = 3, mana = 1 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = { card.ability.extra.Xmult, card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } } }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {
                ["Hearts"] = 0,
                ["Diamonds"] = 0,
                ["Spades"] = 0,
                ["Clubs"] = 0
            }
            for i = 1, #context.scoring_hand do
                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit("Hearts", true) and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit("Diamonds", true) and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit("Spades", true) and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit("Clubs", true) and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit("Hearts") and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit("Diamonds") and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit("Spades") and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit("Clubs") and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            if suits["Hearts"] > 0 and
                suits["Diamonds"] > 0 and
                suits["Spades"] > 0 and
                suits["Clubs"] > 0 then
                return { xmult = card.ability.extra.Xmult }
            else
                StatusEffects.change_effect_buffer("stateff_mana", card.ability.extra.mana)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        StatusEffects.change_effect_level("stateff_mana", card.ability.extra.mana)
                        StatusEffects.clear_effect_buffer("stateff_mana")
                        return true
                    end
                }))
                return { message = localize { type = "variable", key = "a_mana", vars = { card.ability.extra.mana } } }
            end
        end
    end
}, true)

SMODS.Joker:take_ownership("cartomancer", {
    config = { extra = { mana = 2 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
        return {
            key = key,
            vars = { card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } } }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local do_mana = StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana
            if do_mana or #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                if do_mana then
                    StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                            StatusEffects.clear_effect_buffer("stateff_mana")
                            return true
                        end
                    }))
                else
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card { set = "Tarot", key_append = "cartomancer", edition = do_mana and "e_negative" }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize("k_plus_tarot"), colour = G.C.PURPLE }, context.blueprint_card or card)
                        return true
                    end
                }))
                return nil, true -- This is for Joker retrigger purposes
            end
        end
    end
}, true)

SMODS.Joker:take_ownership("caino", {
    config = { extra = { xmult = 1, xmult_gain = 1, mana = 6 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult,
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana and context.other_card:is_face() and not context.blueprint then
            StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
            local _card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    return true
                end
            }))
            return { remove = true }
        end
        if context.remove_playing_cards and not context.blueprint then
            local face_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_face() then face_cards = face_cards + 1 end
            end
            if face_cards > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + face_cards * card.ability.extra.xmult_gain
                return { message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } } }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("triboulet", {
    config = { extra = { xmult = 2, xmult_gain = 0.1, mana = 6 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.mana,
                card.ability.extra.xmult_gain,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana and not context.blueprint then
            StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    return true
                end
            }))
            return { message = localize("k_upgrade_ex") }
        end
        if context.individual and context.cardarea == G.play and
            (context.other_card:get_id() == 12 or context.other_card:get_id() == 13) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("yorick", {
    config = { extra = { xmult = 1, xmult_gain = 1, discards = 23, discards_remaining = 23, mana = 2, discards_added = 1 } },
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.discards,
                card.ability.extra.discards_remaining,
                card.ability.extra.xmult,
                card.ability.extra.mana,
                card.ability.extra.discards_added,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
            StatusEffects.change_effect_buffer("stateff_mana", -card.ability.extra.mana)
            ease_discard(card.ability.extra.discards_added)
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_mana", -card.ability.extra.mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    return true
                end
            }))
            return { message = localize { type = "variable", key = "a_discard", vars = { card.ability.extra.discards_added } }, colour = G.C.RED }
        end
        if context.discard and not context.blueprint then
            if card.ability.extra.discards_remaining <= 1 then
                card.ability.extra.discards_remaining = card.ability.extra.discards
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } },
                    colour = G.C.RED,
                    delay = 0.2
                }
            else
                card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
                return nil, true
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("chicot", {
    config = { extra = { mana = 4 } },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            play_sound("timpani")
                            delay(0.4)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize("ph_boss_disabled") }, card)
                    return true
                end
            }))
            return nil, true
        end

        if context.end_of_round and context.game_over == false and context.main_eval then
            StatusEffects.change_effect_buffer("stateff_mana", card.ability.extra.mana)
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_mana", card.ability.extra.mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    return true
                end
            }))
            return { message = localize { type = "variable", key = "a_mana", vars = { card.ability.extra.mana } } }
        end
    end
}, true)

SMODS.Joker:take_ownership("perkeo", {
    config = { extra = { mana = 3 } },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
        local key = self.key .. "_mana"
        return {
            key = key,
            vars = {
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", level = card.ability.extra.mana, dark = true } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.ending_shop and G.consumeables.cards[1] then
            local manaing = false
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, "perkeo")
                    if StatusEffects.get_effect("stateff_mana") >= card.ability.extra.mana then
                        card_to_copy = G.consumeables.cards[1]
                    end
                    local copied_card = SMODS.copy_card(card_to_copy)
                    copied_card:set_edition("e_negative", true)
                    return true
                end
            }))
            return { message = localize("k_duplicated_ex") }
        end
    end
}, true)
