Arena.ResizeImmediate(565, 130)
question = CreateProjectile("q" .. GetGlobal("currentQuestion"), 0, 0)

function Update()
	if Player.x > Arena.width / 4 then
		if GetGlobal("questions")["q" .. GetGlobal("currentQuestion")] == "R" then
			SetGlobal("canAttack", true)
			SetGlobal("currentQuestion", GetGlobal("currentQuestion") + 1)
			if GetGlobal("currentQuestion") > 11 then
				SetGlobal("currentQuestion", 1)
			end
			State("ATTACKING")
		else
			SetGlobal("canAttack", false)
			SetGlobal("currentQuestion", GetGlobal("currentQuestion") + 1)
			if GetGlobal("currentQuestion") > 11 then
				SetGlobal("currentQuestion", 1)
			end
			SetGlobal("wronganswer", true)
			State("ENEMYDIALOGUE")
		end
	end
    if Player.x < -Arena.width / 4 then
		if GetGlobal("questions")["q" .. GetGlobal("currentQuestion")] == "L" then
			SetGlobal("canAttack", true)
			SetGlobal("currentQuestion", GetGlobal("currentQuestion") + 1)
			if GetGlobal("currentQuestion") > 11 then
				SetGlobal("currentQuestion", 1)
			end
			State("ATTACKING")
		else
			SetGlobal("canAttack", false)
			SetGlobal("currentQuestion", GetGlobal("currentQuestion") + 1)
			if GetGlobal("currentQuestion") > 11 then
				SetGlobal("currentQuestion", 1)
			end
			SetGlobal("wronganswer", true)
			State("ENEMYDIALOGUE")
		end
    end
end

function OnHit()
    Player.Hurt(0, 1)
end
