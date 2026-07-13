StatusEffects.ALL_EFFECTS = {}

StatusEffects.define_effect = function(o)
    assert(o.key, "Status effects require \"key\" to be defined.")

    o.mod_prefix = SMODS.current_mod.prefix
    o.no_prefix = o.no_prefix or false
    if not o.atlas then
        o.no_prefix = true
        o.atlas = "stateff_StatusEffects"
    end
    o.pos = o.pos or { x = 0, y = 0 }

    StatusEffects.ALL_EFFECTS[o.key] = o
    if o.attributes then
        for _, attribute in ipairs(o.attributes) do
            if SMODS.Attributes[attribute] then
                o.attributes[attribute] = true
                SMODS.Attributes[attribute].keys = SMODS.merge_lists({ SMODS.Attributes[attribute].keys or {}, { o.key } })
            end
        end
    end
end

--[[local calculate_card_areas_ref = SMODS.calculate_context
function SMODS.calculate_card_areas(_type, context, return_table, args)
    local ret = calculate_card_areas_ref(_type, context, return_table, args)
    if G.GAME and G.GAME.APPLIED_EFFECTS then
        local flags = {}
        if _type == "stateff_status_effects" then
            for _, area in ipairs(G.GAME.APPLIED_EFFECTS) do

            end
        end
    end
    return ret
end]]

StatusEffects.change_effect_level = function(key, level)
    if not G.GAME then return end
    if not G.GAME.APPLIED_EFFECTS then G.GAME.APPLIED_EFFECTS = {} end
    local effect = G.GAME.APPLIED_EFFECTS[key]
    if effect then
        if (effect.level or 0) <= -level then return StatusEffects.clear_effect(key) end
        effect.level = (effect.level or 0) + level
    else
        if level < 0 then return end
        G.GAME.APPLIED_EFFECTS[key] = copy_table(StatusEffects.ALL_EFFECTS[key].config)
        G.GAME.APPLIED_EFFECTS[key].level = level
    end
end

StatusEffects.clear_effect = function(key)
    if not G.GAME or not G.GAME.APPLIED_EFFECTS then return end
    if G.GAME.APPLIED_EFFECTS[key] then
        G.GAME.APPLIED_EFFECTS[key] = nil
    end
end

function SMODS.current_mod:calculate(context) --At the moment, you can't return the usual context calculate tables.
    --You should use events and such instead.
    if G.GAME and G.GAME.APPLIED_EFFECTS then
        for effect, v in pairs(G.GAME.APPLIED_EFFECTS) do
            if StatusEffects.ALL_EFFECTS[effect].calculate then StatusEffects.ALL_EFFECTS[effect]:calculate(v, context) end
        end
    end
end

StatusEffects.define_effect {
    key = "shocked",
    config = { money_per_level = 1 },
    calculate = function(self, config, context)
        if context.pre_discard then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_dollars(-config.level * config.money_per_level)
                    return true
                end
            }))
        end
    end
}
