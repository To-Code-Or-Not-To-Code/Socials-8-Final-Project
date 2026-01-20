-- A basic encounter script skeleton you can copy and modify for your own creations.
-- music = "shine_on_you_crazy_diamond" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "The rogue eunuch approaches..." -- Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"bullettest_chaserorb"}
wavetimer = 10.0
arenasize = {155, 130}

waves = 0

enemies = {"eunuch"}

enemypositions = {{0, 0}}

Player.lv = 20
Player.name = "XuanZong"
Player.hp = 99

item_effects = {
    ["INFINITE SESAME CAKE"] = {
        ["hp"] = 30,
        ["spd"] = 0
    },
    ["STEAMED BUN"] = {
        ["hp"] = 45,
        ["spd"] = 0
    },
    ["SOUP"] = {
        ["hp"] = 60,
        ["spd"] = 0
    },
    ["ROAST DUCK"] = {
        ["hp"] = 100,
        ["spd"] = 0
    },
    ["TEA"] = {
        ["hp"] = 15,
        ["spd"] = 3
    },
    ["CHERRY"] = {
        ["hp"] = 15,
        ["spd"] = 0
    },
    ["RICE WINE"] = {
        ["hp"] = 45,
        ["spd"] = 3
    }
}

SetGlobal("speedIncrease", 0)
SetGlobal("canTaunt", false)

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"bullettest_bouncy", "bullettest_chaserorb", "bullettest_touhou", "3LargeChaserOrbs"}
-- possible_attacks = {"bullettest_chaserorb"}

function EncounterStarting()
    -- If you want to change the game state immediately, this is the place.
    Inventory.AddCustomItems({"Infinite Sesame Cake", "Steamed Bun", "Soup", "Roast Duck", "Tea", "Cherry",
                              "Rice Wine"}, {3, 0, 0, 0, 0, 0, 0})
    Inventory.SetInventory({"Infinite Sesame Cake", "Steamed Bun", "Soup", "Roast Duck", "Tea", "Tea", "Cherry",
                              "Rice Wine"})
end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
end

function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    nextwaves = {possible_attacks[math.random(#possible_attacks)]}
end

function DefenseEnding() -- This built-in function fires after the defense round ends.
    if waves % 3 == 0 and waves > 0 then
        encountertext = "Prove him wrong."
    else
        if answered == true then
            encountertext = "Lower his guard."
        else
            encountertext = "Wait." -- This built-in function gets a random encounter text from a random enemy.
        end
    end
    SetGlobal("speedIncrease", 0)
    waves = waves + 1
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID, ItemIndex, IsSilent)
    if not IsSilent then
        Player.hp = Player.hp + item_effects[ItemID].hp
        if item_effects[ItemID].spd > 0 then
            SetGlobal("speedIncrease", item_effects[ItemID].spd)
        end
        BattleDialog({"You ate the " .. ItemID .. "."})
    end
end
