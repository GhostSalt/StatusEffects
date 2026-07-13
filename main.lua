--[[SMODS.Atlas {
  key = "modicon",
  path = "StatusEffectsLogo.png",
  px = 34,
  py = 34
}]]--

to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

if not StatusEffects then StatusEffects = {} end

local allFolders = { "none", "items" }
local allFiles = { ["none"] = {}, ["items"] = { "ObjectDefs", "StatusEffects" } }

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