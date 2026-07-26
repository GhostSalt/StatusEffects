--[[SMODS.Atlas {
  key = "modicon",
  path = "StatusEffectsLogo.png",
  px = 34,
  py = 34
}]] --

to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

if not StatusEffects then StatusEffects = {} end

G.C.STATUS_EFFECTS = {
  Potion = HEX("95a8ab"),
  PotionAlt = HEX("66777a"),
  Red = HEX("fd5f55"),
  Blue = HEX("41b7ff"),
  Odds = HEX("d9dd61")
}

local loc_colour_ref = loc_colour

function loc_colour(_c, default)
  if not G.ARGS.LOC_COLOURS then
    loc_colour_ref(_c, default)
  elseif not G.ARGS.LOC_COLOURS.stateff_colours then
    G.ARGS.LOC_COLOURS.stateff_colours = true

    local new_colors = {
      stateff_red = G.C.STATUS_EFFECTS.Red,
      stateff_blue = G.C.STATUS_EFFECTS.Blue,
      stateff_odds = G.C.STATUS_EFFECTS.Odds
    }

    for k, v in pairs(new_colors) do
      G.ARGS.LOC_COLOURS[k] = v
    end
  end

  return loc_colour_ref(_c, default)
end

local allFolders = { "none", "items" }
local allFiles = { ["none"] = {}, ["items"] = { "Sounds", "ObjectDefs", "StatusEffects", "Blinds", "Potions", "Boosters", "VanillaMana" } }

for i = 1, #allFolders do
  if allFolders[i] == "none" then
    for j = 1, #allFiles[allFolders[i]] do
      assert(SMODS.load_file(allFiles[allFolders[i]][j] .. ".lua"))()
    end
  else
    for j = 1, #allFiles[allFolders[i]] do
      assert(SMODS.load_file(allFolders[i] .. "/" .. allFiles[allFolders[i]][j] .. ".lua"))()
    end
  end
end
