-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Can't be hit.\rTry lowering their defense.", "Bait them to exchange\rattack for defense."}
commands = {"Defend", "Taunt"}
randomdialogue = {"Look at how\nfar you\nfallen.", "I'm done with you.", "Remember the\nAn Lushan\nrebellion?"}

sprite = "eunuch scaled" -- Always PNG. Extension is added automatically.
name = "Rogue Eunuch"
hp = 19998
atk = 1
def = 65
check = "A member of your council done\rwith the weak emperors."
dialogbubble = "rightlong" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
missDialogue = {"Incredible.\nYou missed.", "Pathetic."}
taunts = {"You tell the eunuch\rthat he's a stain\ron their family.",
        "You tell the eunuch\rthat they can't\rland a single hit."}

-- Happens after the slash animation but before 
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        currentdialogue = {missDialogue[math.random(#missDialogue)]}
    else
        if def == 65 then
            currentdialogue = {"Don't bother trying."}
        else
            currentdialogue = {"What. How."}
            def = 65
            atk = 1
            SetGlobal("taunted", false)
        end
    end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "DEFEND" then
        BattleDialog({"Your defense increased\n"})
        Player.def = Player.def + 3
    elseif command == "TAUNT" then
        BattleDialogue({taunts[math.random(#taunts)], "The eunuch's attack increased.\rTheir defense dropped."})
        atk = 65
        def = 1
    end
end
