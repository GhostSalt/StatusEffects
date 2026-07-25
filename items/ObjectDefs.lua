StatusEffects.ALL_EFFECTS = {}

G.stateff_symbolW = 0.4
G.stateff_symboldescW = 0.3

StatusEffects.define_effect = function(o)
    assert(o.key, "Status effects require \"key\" to be defined.")

    o.mod_prefix = SMODS.current_mod.prefix
    o.key = o.mod_prefix .. "_" .. o.key
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
    if G.GAME and G.GAME.STATEFF_APPLIED_EFFECTS then
        local flags = {}
        if _type == "stateff_status_effects" then
            for _, area in ipairs(G.GAME.STATEFF_APPLIED_EFFECTS) do

            end
        end
    end
    return ret
end]]

StatusEffects.change_effect_level = function(key, level, args)
    if not G.GAME then return end
    if not G.GAME.STATEFF_APPLIED_EFFECTS then G.GAME.STATEFF_APPLIED_EFFECTS = {} end
    local effect = G.GAME.STATEFF_APPLIED_EFFECTS[key]
    if level > 0 then
        G.GAME.STATEFF_SEEN_EFFECTS = G.GAME.STATEFF_SEEN_EFFECTS or {}
        G.GAME.STATEFF_SEEN_EFFECTS[key] = true
    end
    if effect then
        if (effect.level or 0) <= -level then return StatusEffects.clear_effect(key) end
        effect.level = (effect.level or 0) + level
        if level > 0 and StatusEffects.ALL_EFFECTS[key].apply_effect then
            StatusEffects.ALL_EFFECTS[key]:apply_effect(effect, level, args)
        elseif level < 0 and StatusEffects.ALL_EFFECTS[key].remove_effect then
            StatusEffects.ALL_EFFECTS[key]:remove_effect(effect, -level, args)
        end
    else
        if level < 0 then return end
        G.GAME.STATEFF_APPLIED_EFFECTS[key] = copy_table(StatusEffects.ALL_EFFECTS[key].config or {})
        G.GAME.STATEFF_APPLIED_EFFECTS[key].level = level
        G.GAME.STATEFF_APPLIED_EFFECTS[key]._order = G.GAME.NEXT_EFFECT_ORDER or 1
        G.GAME.NEXT_EFFECT_ORDER = (G.GAME.NEXT_EFFECT_ORDER or 1) + 1
        if StatusEffects.ALL_EFFECTS[key].apply_effect then
            StatusEffects.ALL_EFFECTS[key]:apply_effect(
                G.GAME.STATEFF_APPLIED_EFFECTS[key], level, args)
        end
    end
    SMODS.calculate_context({ stateff_effect_changed = key, stateff_level_change = level })
    stateff_update_box()
end

StatusEffects.clear_effect = function(key, args)
        SMODS.calculate_context({ stateff_effect_changed = key, stateff_level_change = -level, stateff_effect_cleared = key })
    if not G.GAME or not G.GAME.STATEFF_APPLIED_EFFECTS then return end
    if G.GAME.STATEFF_APPLIED_EFFECTS[key] then
        local level = G.GAME.STATEFF_APPLIED_EFFECTS[key].level
        G.GAME.STATEFF_APPLIED_EFFECTS[key].level = 0
        if StatusEffects.ALL_EFFECTS[key].remove_effect then
            StatusEffects.ALL_EFFECTS[key]:remove_effect(
                G.GAME.STATEFF_APPLIED_EFFECTS[key], level, args)
        end
        G.GAME.STATEFF_APPLIED_EFFECTS[key] = nil
        stateff_update_box()
    end
end

StatusEffects.clear_all_effects = function(args)
    if not G.GAME or not G.GAME.STATEFF_APPLIED_EFFECTS then return end
    for k, v in pairs(G.GAME.STATEFF_APPLIED_EFFECTS) do
        StatusEffects.clear_effect(k, args)
    end
end

StatusEffects.change_effect_buffer = function(key, level)
    if not G.GAME then return end
    if not G.GAME.STATEFF_EFFECT_BUFFERS then G.GAME.STATEFF_EFFECT_BUFFERS = {} end
    G.GAME.STATEFF_EFFECT_BUFFERS[key] = (G.GAME.STATEFF_EFFECT_BUFFERS[key] or 0) + level
end

StatusEffects.clear_effect_buffer = function(key)
    if not G.GAME or not G.GAME.STATEFF_EFFECT_BUFFERS then return end
    G.GAME.STATEFF_EFFECT_BUFFERS[key] = nil
end

StatusEffects.get_effect = function(key)
    if not G.GAME or not G.GAME.STATEFF_APPLIED_EFFECTS then return 0 end
    if not G.GAME.STATEFF_APPLIED_EFFECTS[key] then return 0 end
    return (G.GAME.STATEFF_APPLIED_EFFECTS[key].level or 0) +
        (G.GAME.STATEFF_EFFECT_BUFFERS and G.GAME.STATEFF_EFFECT_BUFFERS[key] or 0)
end

StatusEffects.has_had_effect = function(key)
    if not G.GAME or not G.GAME.STATEFF_SEEN_EFFECTS then return 0 end
    return G.GAME.STATEFF_SEEN_EFFECTS[key]
end

function SMODS.current_mod:calculate(context)
    if #G.hand.cards < 1 and #G.deck.cards < 1 and #G.play.cards < 1 then
        if G.STATE == G.STATES.SELECTING_HAND and G.STATE_COMPLETE then
            stop_use()
            G.STATE = G.STATES.NEW_ROUND
            end_round()
        end
    end



    local ret = nil
    local flags = {}
    for _, v in pairs(StatusEffects.ALL_EFFECTS) do
        if v.calculate_always then flags[#flags + 1] = v:calculate_always(context) end
    end
    if G.GAME and G.GAME.STATEFF_APPLIED_EFFECTS then
        for effect, v in pairs(G.GAME.STATEFF_APPLIED_EFFECTS) do
            if StatusEffects.ALL_EFFECTS[effect].calculate then
                flags[#flags + 1] = StatusEffects.ALL_EFFECTS[effect]
                    :calculate(v, context)
            end
        end

        if #flags > 0 then
            ret = {}
            for i, f in ipairs(flags) do
                for k, v in pairs(f) do ret[k] = v end
            end
        end

        if context.end_of_round and not context.individual and not context.repetition then
            for effect, v in pairs(G.GAME.STATEFF_APPLIED_EFFECTS) do
                if StatusEffects.ALL_EFFECTS[effect].decrease_at_eor then
                    StatusEffects.change_effect_level(effect,
                        -StatusEffects.ALL_EFFECTS[effect].decrease_at_eor)
                end
                if StatusEffects.ALL_EFFECTS[effect].clear_at_eor then StatusEffects.clear_effect(effect) end
            end
        end
    end
    return ret
end

StatusEffects.create_hoverable_icon = function(args)
    if not args then return end
    local eff = StatusEffects.ALL_EFFECTS[args.key]
    local v = copy_table(StatusEffects.ALL_EFFECTS[args.key].config or {})
    v.level = args.level
    local loc_key = "stateff_" .. args.key
    local info_queue = {}
    local info = { set = "Other", key = loc_key, specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, v) or {}) }

    local atlas_key = eff.atlas .. (args.dark and "_dark" or "")
    if not eff.no_prefix then atlas_key = eff.mod_prefix .. atlas_key end

    local tile = SMODS.create_sprite(0, 0, G.stateff_symboldescW * (args.scalex or args.scale or 1),
        G.stateff_symboldescW * (args.scaley or args.scale or 1), atlas_key, eff.pos)
    tile.states.drag.can = false

    local n = {
        n = G.UIT.C,
        config = { detailed_tooltip = info, align = "cm" },
        nodes = { { n = G.UIT.O, config = { object = tile } } }
    }
    return n
end

local function stateff_create_uibox()
    if not G.GAME or not G.GAME.STATEFF_APPLIED_EFFECTS then return end
    local effect_nodes = {}

    local sorted_effects = {}
    for k, v in pairs(G.GAME.STATEFF_APPLIED_EFFECTS) do
        sorted_effects[#sorted_effects + 1] = { k = k, v = v }
    end
    table.sort(sorted_effects, function(a, b) return a.v._order > b.v._order end)

    for _, vv in pairs(sorted_effects) do
        local k = vv.k; local v = vv.v
        local eff = StatusEffects.ALL_EFFECTS[k]
        local key = "stateff_" .. eff.key
        local info_queue = {}
        local info = { set = "Other", key = key, specific_vars = (eff.loc_vars and eff:loc_vars(info_queue, v) or {}) }

        local atlas_key = eff.atlas
        if not eff.no_prefix then atlas_key = eff.mod_prefix .. atlas_key end

        local tile = SMODS.create_sprite(0, 0, G.stateff_symbolW, G.stateff_symbolW, atlas_key, eff.pos)
        tile.states.drag.can = false

        local inside_effect_nodes = {
            { n = G.UIT.O, config = { object = tile } }
        }
        if not eff.dont_show_level then
            inside_effect_nodes[#inside_effect_nodes + 1] =
            { n = G.UIT.T, config = { text = v.level, scale = 0.4, colour = eff.colour or G.C.WHITE } }
        end

        local n = {
            n = G.UIT.R,
            config = { detailed_tooltip = info, align = "cm" },
            nodes = inside_effect_nodes
        }

        effect_nodes[#effect_nodes + 1] = n
    end

    return UIBox { definition = { n = G.UIT.ROOT, config = { colour = G.C.UI.OUTLINE_LIGHT, padding = 0.05, r = .1, emboss = .05, hover = true, shadow = true }, nodes = {
        { n = G.UIT.C, config = { colour = G.C.L_BLACK, padding = .05, r = .1 }, nodes = {
            { n = G.UIT.R, config = { padding = 0.05, maxw = 1.8 }, nodes = effect_nodes }
        } }
    } }, config = { major = G.deck, align = "tm", offset = { x = 0.15, y = -.35 } } }
end

function stateff_update_box()
    if G.stateff_uibox then G.stateff_uibox:remove() end
    for _, v in pairs(G.GAME.STATEFF_APPLIED_EFFECTS or {}) do
        G.stateff_uibox = stateff_create_uibox()
        return
    end
end

local start_run_ref = Game.start_run
function Game.start_run(self, args)
    start_run_ref(self, args)
    stateff_update_box()
end
