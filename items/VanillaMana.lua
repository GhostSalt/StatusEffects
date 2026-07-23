SMODS.Joker:take_ownership("joker", {
    config = { extra = { mult = 4, mana = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } } } }
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

SMODS.Joker:take_ownership("banner", {
    config = { extra = { chips = 30, mana = 1, added_chips = 4 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mana,
                card.ability.extra.added_chips,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } }
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
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra, "8ball")
        return { vars = { num, denom, card.ability.stateff_mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } } } }
    end,
    calculate = function(self, card, context)

    end
}, true)

SMODS.Joker:take_ownership("loyalty_card", {
    config = { extra = { Xmult = 4, every = 5, loyalty_remaining = 5, mana = 4, extra_m = 1 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.every + 1,
                localize { type = 'variable', key = (card.ability.extra.loyalty_remaining == 0 and 'loyalty_active' or 'loyalty_inactive'), vars = { card.ability.extra.loyalty_remaining } },
                card.ability.extra.extra_m,
                card.ability.extra.mana,
                elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } }
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
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra, "space")
        return { vars = { num, denom, card.ability.stateff_mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } } } }
    end,
    calculate = function(self, card, context)
        if context.before and (SMODS.pseudorandom_probability(card, "space", 1, card.ability.extra)
                or StatusEffects.get_effect("stateff_mana") >= card.ability.stateff_mana) then
            StatusEffects.change_effect_buffer("stateff_mana", -card.ability.stateff_mana)
            G.E_MANAGER:add_event(Event({
                func = function()
                    StatusEffects.change_effect_level("stateff_mana", -card.ability.stateff_mana)
                    StatusEffects.clear_effect_buffer("stateff_mana")
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return {
                level_up = true,
                message = localize("k_level_up_ex")
            }
        end
    end
}, true)

SMODS.Joker:take_ownership("sixth_sense", {
    config = { extra = { mana = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } } } }
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


SMODS.Joker:take_ownership("madness", {
    config = { extra = { xmult_gain = 0.5, xmult = 1, mana = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } } } }
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
                return { message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } } }
            else
                return { message = "...", colour = G.C.BLUE }
            end
        end

        if context.joker_main then return { xmult = card.ability.extra.xmult } end
    end
}, true)

SMODS.Joker:take_ownership("seance", {
    config = { extra = { poker_hand = "Straight Flush", mana = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.poker_hand, "poker_hands"), card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } } } }
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

SMODS.Joker:take_ownership("diet_cola", {
    config = { extra = { mana = 4 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "tag_double", set = "Tag" }
        return { vars = { localize { type = "name_text", set = "Tag", key = "tag_double" }, card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } } } }
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

SMODS.Joker:take_ownership("flower_pot", {
    config = { extra = { Xmult = 3, mana = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.mana, elements = { StatusEffects.create_hoverable_icon { key = "stateff_mana", dark = true } } } }
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
