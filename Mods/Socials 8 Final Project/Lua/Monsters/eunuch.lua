-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Can't be hit.\rTry lowering their defense.", "Bait them to exchange\rattack for defense."}
commands = {"Defend", "Taunt"}
randomdialogues = {"Look at how\nfar you\nfallen.", "I'm done with you.", "Remember the\nAn Lushan\nrebellion?"}
currentdialogue = {randomdialogues[math.random(#randomdialogues)]}

sprite = "eunuch scaled" -- Always PNG. Extension is added automatically.
name = "Rogue Eunuch"
hp = 1155
atk = 1
def = 65
check = "A member of your council done\rwith the weak emperors."
dialogbubble = "rightwide" -- See documentation for what bubbles you have available.
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
            def = 65
            atk = 1
            currentdialogue = {"What. How."}
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
        atk = 65
        def = 1
        BattleDialogue({taunts[math.random(#taunts)], "The eunuch dropped his guard.\rGet him now."})
        currentdialogue = {"What do you mean?"}
    end
end

function OnDeath()
    SetGlobal("dead", true)
    Audio.Stop()
    currentdialogue = {"Maybe [w:2] I was wrong\nabout you. Strike me\ndown.",
                       "Credits:\nPathways: Civilizations through Time by Michael Cranny",
                       "https://www.berkshirepublishing.com/ecph-china/2018/01/13/four-books-and-the-five-classics-the/",
                       "https://courses.lumenlearning.com/suny-fmcc-boundless-worldhistory/chapter/the-tang-dynasty/",
                       "https://totallyhistory.com/tang-dynasty-social-structure/",
                       "https://www.asianstudies.org/publications/eaa/archives/wu-zhao-ruler-of-tang-dynasty-china/",
                       "Music:\nMEGALOVANIA by Toby Fox.\nDetermination by Toby Fox.",
                       "Inspiration:\nUndertale by Toby Fox",
                       "Special thanks:\nRhenaoTheLukark's Create Your Frisk for making this possible",
                       "Notes:\nI ran out of time for my original plan of a metroidvania so I spedran this in one day.",
                       "Hopefully it's fine.", "Thanks for playing!"}
    State("ENEMYDIALOGUE")
end
