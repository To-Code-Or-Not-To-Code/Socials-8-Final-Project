-- A basic encounter script skeleton you can copy and modify for your own creations.

-- music = "shine_on_you_crazy_diamond" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "The rogue eunuch approaches..." --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"bullettest_chaserorb"}
wavetimer = 10.0
arenasize = {155, 130}

waves = 0

enemies = {
"eunuch"
}

enemypositions = {
{0, 0}
}

Player.lv = 20
Player.name = "XuanZong"
Player.hp = 99

SetGlobal("canTaunt", false)
SetGlobal("canAnswer", false)

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"bullettest_bouncy", "bullettest_chaserorb", "bullettest_touhou"}
-- possible_attacks = {"bullettest_chaserorb"}

function EncounterStarting()
    -- If you want to change the game state immediately, this is the place.
end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
end

function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    nextwaves = { possible_attacks[math.random(#possible_attacks)] }
end

function DefenseEnding() --This built-in function fires after the defense round ends.
    if waves % 3 == 0 and waves > 0 then
        encountertext = "Prove him wrong."
    else
        if answered == true then
            encountertext = "Lower his guard."
        else
            encountertext = "Wait." --This built-in function gets a random encounter text from a random enemy.
        end
    end
    waves = waves + 1
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID, ItemIndex, IsSilent)
    if not IsSilent then
        BattleDialog({"You ate the " .. ItemID .. "."})
    end
end