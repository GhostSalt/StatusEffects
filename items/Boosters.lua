SMODS.Atlas {
  key = "StatusEffectsPacks",
  path = "StatusEffectsPacks.png",
  px = 71,
  py = 95
}

SMODS.Booster {
  key = "potion_normal1",
  kind = "stateff_Potion",
  atlas = "StatusEffectsPacks",
  pos = { x = 0, y = 0 },
  config = { extra = 3, choose = 1 },
  cost = 4,
  weight = 0.8,
  create_card = function(self, card, i)
    return stateff_create_for_potion_pack("stateff_potion_normal1", i, card.ability.extra)
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.STATUS_EFFECTS.Potion)
    ease_background_colour({ new_colour = G.C.STATUS_EFFECTS.Potion, special_colour = G.C.STATUS_EFFECTS.PotionAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_stateff_plainmilk
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_stateff_potion_pack"
}

SMODS.Booster {
  key = "potion_normal2",
  kind = "stateff_Potion",
  atlas = "StatusEffectsPacks",
  pos = { x = 1, y = 0 },
  config = { extra = 3, choose = 1 },
  cost = 4,
  weight = 0.8,
  create_card = function(self, card, i)
    return stateff_create_for_potion_pack("stateff_potion_normal2", i, card.ability.extra)
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.STATUS_EFFECTS.Potion)
    ease_background_colour({ new_colour = G.C.STATUS_EFFECTS.Potion, special_colour = G.C.STATUS_EFFECTS.PotionAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_stateff_plainmilk
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_stateff_potion_pack"
}

SMODS.Booster {
  key = "potion_jumbo1",
  kind = "stateff_Potion",
  atlas = "StatusEffectsPacks",
  pos = { x = 2, y = 0 },
  config = { extra = 5, choose = 1 },
  cost = 6,
  weight = 0.4,
  create_card = function(self, card, i)
    return stateff_create_for_potion_pack("stateff_potion_jumbo1", i, card.ability.extra)
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.STATUS_EFFECTS.Potion)
    ease_background_colour({ new_colour = G.C.STATUS_EFFECTS.Potion, special_colour = G.C.STATUS_EFFECTS.PotionAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_stateff_plainmilk
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_stateff_potion_pack"
}

SMODS.Booster {
  key = "potion_mega1",
  kind = "stateff_Potion",
  atlas = "StatusEffectsPacks",
  pos = { x = 3, y = 0 },
  config = { extra = 5, choose = 2 },
  cost = 8,
  weight = 0.2,
  create_card = function(self, card, i)
    return stateff_create_for_potion_pack("stateff_potion_mega1", i, card.ability.extra)
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.STATUS_EFFECTS.Potion)
    ease_background_colour({ new_colour = G.C.STATUS_EFFECTS.Potion, special_colour = G.C.STATUS_EFFECTS.PotionAlt, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_stateff_plainmilk
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_stateff_potion_pack"
}



function stateff_create_for_potion_pack(key, i, size)
  if i == size then
    return SMODS.create_card({ key = "c_stateff_plainmilk", skip_materialize = true })
  else
    return SMODS.create_card({ set = "stateff_Potion", key_append = key, skip_materialize = true, soulable = true })
  end
end
