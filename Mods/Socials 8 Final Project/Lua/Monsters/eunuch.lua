-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Can't be hit.\rTry lowering their defense.", "Bait them to exchange\rattack for defense."}
commands = {"Defend", "Taunt", "Answer"}
randomdialogue = {"Look at how\nfar you\nfallen.", "I'm done with you.", "Remember the\nAn Lushan\nrebellion?"}

sprite = "eunuch scaled" -- Always PNG. Extension is added automatically.
name = "Rogue Eunuch"
hp = 20000
atk = 1
def = 65
check = "A member of your council done\rwith the weak emperors."
dialogbubble = "rightlong" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
missDialogue = {"Incredible.\nYou missed.", "Pathetic."}

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
        end
    end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "DEFEND" then
        BattleDialog({"Your defense increased\n"})
        Player.def = Player.def + 3
    elseif command == "TAUNT" then
        if GetGlobal("canTaunt") == true then
            BattleDialogue("You tell the eunuch\rthat he's a stain\ron their family.")
            currentdialogue = {"What do you mean? I am\nnot!"}
            
        else
            BattleDialogue("You tell the eunuch\rthat they can't\rland a single hit.")
            currentdialogue = {"Nice try."}
        end
    elseif command == "ANSWER" then
        if GetGlobal("canAnswer") == true then
            currentdialogue = {"Do you really\nknow your people?"}
        else
            currentdialogue = {"What are you\nanswering to?"}
        end
    end
end
