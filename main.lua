--[[SMODS.Atlas {
  key = "modicon",
  path = "StatusEffectsLogo.png",
  px = 34,
  py = 34
}]]--

to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

if not StatusEffects then StatusEffects = {} end

G.C.STATUS_EFFECTS = {
  Potion = HEX("95a8ab"),
  PotionAlt = HEX("66777a")
}

local allFolders = { "none", "items" }
local allFiles = { ["none"] = {}, ["items"] = { "Sounds", "ObjectDefs", "StatusEffects", "Blinds", "Potions", "Boosters" } }

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