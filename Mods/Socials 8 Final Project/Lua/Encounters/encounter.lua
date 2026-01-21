-- A basic encounter script skeleton you can copy and modify for your own creations.
music = "MEGALOVANIA" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "The rogue eunuch approaches..." -- Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"bullettest_chaserorb"}
wavetimer = 10.0
arenasize = {155, 130}
deathtexts = {"Why am I not suprised you're dead?", "Skill Issue", "lmao you're washed.", "We meet again."}
deathtext = deathtexts[math.random(#deathtexts)]
waves = 0

enemies = {"eunuch"}

enemypositions = {{0, 0}}

Player.lv = 20
Player.name = "XuanZong"
Player.hp = 99
item_effects = {
    ["INF. SESAME CAKE"] = {
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
        ["spd"] = 1
    },
    ["CHERRY"] = {
        ["hp"] = 15,
        ["spd"] = 0
    },
    ["RICE WINE"] = {
        ["hp"] = 45,
        ["spd"] = 2
    }
}

SetGlobal("questions", {
    ["q1"] = "L",
    ["q2"] = "R",
    ["q3"] = "L",
    ["q4"] = "L",
    ["q5"] = "L",
    ["q6"] = "L",
    ["q7"] = "L",
    ["q8"] = "R",
    ["q9"] = "L",
    ["q10"] = "R",
    ["q11"] = "R"
})

SetGlobal("currentQuestion", 1)

SetGlobal("speedIncrease", 0)
SetGlobal("taunted", false)
SetGlobal("canAttack", false)
SetGlobal("wronganswer", false)
SetGlobal("cutsceneover", false)

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"bullettest_bouncy", "bullettest_chaserorb", "bullettest_touhou", "3LargeChaserOrbs"}
-- possible_attacks = {"bullettest_touhou"}

function sleep (a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end

function EncounterStarting()
    -- If you want to change the game state immediately, this is the place.
    Audio.Pause()
    Inventory.AddCustomItems(
        {"Inf. Sesame Cake", "Steamed Bun", "Soup", "Roast Duck", "Tea", "Cherry", "Rice Wine"},
        {3, 0, 0, 0, 0, 0, 0})
    Inventory.SetInventory({"Inf. Sesame Cake", "Steamed Bun", "Soup", "Roast Duck", "Tea", "Tea", "Cherry",
                            "Rice Wine"})
    enemies[1].SetVar("currentdialogue", {"It's a beautiful day today.[w:5]\nThe birds are singing, [w:5]flowers are blooming.", "On days like these,\n[w:5]people like you,\n[w:15]should be burning [w:5]in [w:5]hell."})
    State("ENEMYDIALOGUE")
end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
    if not enemies[1]["currentdialogue"] then
        enemies[1].SetVar("currentdialogue", {enemies[1]["randomdialogues"][math.random(#enemies[1]["randomdialogues"])]})
    end
    if GetGlobal("wronganswer") then
        if GetGlobal("currentQuestion") == 6 then
            enemies[1].SetVar("currentdialogue", {"I wish."})
        else
            enemies[1].SetVar("currentdialogue", {"Wow.[w:2]\nYou don't even know\nyour own country!"})
        end
        SetGlobal("wronganswer", false)
    end
end

function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    nextwaves = {possible_attacks[math.random(#possible_attacks)]}
    Audio.Unpause()
    if GetGlobal("dead") == true then
        Player.ForceAttack(1, 99999999)
        SetGlobal("cutsceneover", true)
        State("ACTIONSELECT")
    end
end

function DefenseEnding() -- This built-in function fires after the defense round ends.
    if Player.hp > Player.maxhp / 4 then
        encountertext = "Lower his guard."
    else
        encountertext = "Consume an item."
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
        if Player.hp >= Player.maxhp then
            if item_effects[ItemID].spd > 0 then
                SetGlobal("speedIncrease", item_effects[ItemID].spd)
                BattleDialog({"You ate the " .. ItemID .. "!\rMax HP recovered.\rYour speed increased!"})
            end
            Player.hp = Player.maxhp
            BattleDialog({"You ate the " .. ItemID .. "!\rMax HP recovered."})
        else
            BattleDialog({"You ate the " .. ItemID .. "!\r" .. item_effects[ItemID].hp .. " HP recovered."})
        end
    end
end

function HandleSpare()
    BattleDialog({"No mercy now.[noskip][w:15][func:State,ACTIONSELECT]"})
end

function EnteringState(newstate, oldstate)
    if newstate == "ATTACKING" and GetGlobal("canAttack") == false then
        nextwaves = {"playerattack"}
        State("DEFENDING")
    elseif newstate == "ATTACKING" and GetGlobal("canAttack") == true then
        SetGlobal("canAttack", false)
    end
    if GetGlobal("dead") and (newstate ~= "ENEMYDIALOGUE" and newstate ~= "ACTIONSELECT") then
        State("DONE")
    end
end