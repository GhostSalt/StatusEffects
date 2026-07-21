SMODS.Atlas {
    key = "Potions",
    path = "StatusEffectsPotions.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "PotionUndiscovered",
    path = "StatusEffectsPotionUndiscovered.png",
    px = 71,
    py = 95
}

SMODS.ConsumableType {
    key = "stateff_Potion",
    primary_colour = HEX("95a8ab"),
    secondary_colour = HEX("66777a"),
    collection_rows = { 3, 3 },
    shop_rate = 0,
    default = "stateff_plainmilk",
    can_stack = true,
    can_divide = true
}

SMODS.UndiscoveredSprite({
    key = "stateff_Potion",
    atlas = "PotionUndiscovered",
    pos = { x = 0, y = 0 },
    no_overlay = true
}):register()






local sell_use_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    if not (card and card.ability and card.ability.set == "stateff_Potion" and card.area == G.pack_cards and G.pack_cards) then
        return sell_use_ref(card)
    end

    return {
      n = G.UIT.ROOT,
      config = { padding = 0, colour = G.C.CLEAR },
      nodes = {
        {
          n = G.UIT.R,
          config = { ref_table = card, r = 0.08, padding = 0.1, align = "bm", w = 0.8 * card.T.w - 0.15, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = "use_card", func = "can_use_consumeable" },
          nodes = {
            { n = G.UIT.T, config = { text = localize("b_stateff_drink"), colour = G.C.UI.TEXT_LIGHT, scale = 0.5, shadow = true } }
          }
        }
      }
    }
end

stateff_create_generic_potion = function(args)
    if not args then return end

    SMODS.Consumable {
        set = "stateff_Potion",
        key = args.key,
        pos = args.pos or { x = 0, y = 0 },
        atlas = args.atlas or "Potions",
        hidden = args.hidden,
        config = { extra = { effects = args.effects, clear_all_effects = args.clear_all_effects } },
        loc_vars = function(self, info_queue, card)
            local vars = {}
            if card.ability.extra.effects then
                for _, v in ipairs(card.ability.extra.effects) do
                    local eff = StatusEffects.ALL_EFFECTS[v.key]
                    local config = copy_table(StatusEffects.ALL_EFFECTS[v.key].config or {})
                    config.level = v.level
                    info_queue[#info_queue + 1] = { set = "Other", key = "stateff_" .. v.key, specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, config) or {}) }
                    vars[#vars + 1] = v.level
                end
            end

            return { vars = vars }
        end,
        can_use = function(self, card)
            return true
        end,
        use = function(self, card, area, copier)
            delay(0.2)
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
                    card.children.center:set_sprite_pos({ x = self.pos.x + 1, y = self.pos.y })
                    card:juice_up()

                    if card.ability.extra.clear_all_effects then
                        StatusEffects.clear_all_effects()
                    end

                    if card.ability.extra.effects then
                        for i = #card.ability.extra.effects, 1, -1 do
                            local v = card.ability.extra.effects[i]
                            StatusEffects.change_effect_level(v.key, v.level)
                        end
                    end
                    return true
                end
            }))
        end,
        in_pool = args.in_pool
    }
end

stateff_create_generic_potion {
    key = "unicorntears",
    pos = { x = 0, y = 0 },
    effects = {
        {
            key = "stateff_lucky",
            level = 4
        },
        {
            key = "stateff_shocked",
            level = 3
        }
    }
}

stateff_create_generic_potion {
    key = "dubiousvino",
    pos = { x = 2, y = 0 },
    effects = {
        {
            key = "stateff_focused",
            level = 4
        },
        {
            key = "stateff_poisoned",
            level = 4
        }
    }
}

stateff_create_generic_potion {
    key = "lattemaltocaldo",
    pos = { x = 0, y = 1 },
    effects = {
        {
            key = "stateff_swift",
            level = 4
        },
        {
            key = "stateff_burnt",
            level = 3
        }
    }
}

stateff_create_generic_potion {
    key = "homeopathiclemonade",
    pos = { x = 2, y = 1 },
    effects = {
        {
            key = "stateff_clairvoyant",
            level = 2
        },
        {
            key = "stateff_weakened",
            level = 4
        }
    }
}

stateff_create_generic_potion {
    key = "orcbrew",
    pos = { x = 0, y = 2 },
    effects = {
        {
            key = "stateff_furious",
            level = 3
        },
        {
            key = "stateff_blinded",
            level = 3
        }
    }
}

stateff_create_generic_potion {
    key = "saltyspirit",
    pos = { x = 4, y = 2 },
    effects = {
        {
            key = "stateff_invisible",
            level = 3
        },
        {
            key = "stateff_cursed",
            level = 3
        }
    }
}

stateff_create_generic_potion {
    key = "radioactivesludge",
    pos = { x = 0, y = 3 },
    effects = {
        {
            key = "stateff_glowing",
            level = 4
        },
        {
            key = "stateff_unlucky",
            level = 4
        }
    }
}

stateff_create_generic_potion {
    key = "schradersmedicine",
    pos = { x = 2, y = 3 },
    effects = {
        {
            key = "stateff_guarded",
            level = 3
        },
        {
            key = "stateff_frozen",
            level = 2
        }
    }
}

stateff_create_generic_potion {
    key = "bafflingcocktail",
    pos = { x = 4, y = 3 },
    effects = {
        {
            key = "stateff_arcane",
            level = 5
        },
        {
            key = "stateff_lunatic",
            level = 3
        }
    }
}

stateff_create_generic_potion {
    key = "witchscanteen",
    pos = { x = 4, y = 0 },
    effects = {
        {
            key = "stateff_mana",
            level = 6
        }
    }
}

stateff_create_generic_potion {
    key = "plainmilk",
    pos = { x = 2, y = 2 },
    clear_all_effects = true,
    in_pool = function() return false end
}

stateff_create_generic_potion {
    key = "miraclenectar",
    pos = { x = 4, y = 1 },
    effects = {
        {
            key = "stateff_divine",
            level = 5
        }
    },
    hidden = true
}
