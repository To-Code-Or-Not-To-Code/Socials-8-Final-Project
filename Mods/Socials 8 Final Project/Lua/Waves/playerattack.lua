Arena.ResizeImmediate(565,130)
question = CreateProjectile("q" .. GetGlobal("currentQuestion"), 0, 0)

function Update()
	if (player.x < -(Arena.width/2 + Arena.width/4) and GetGlobal("questions")["q" .. GetGlobal("currentQuestion")] == "L") or (player.x > Arena.width/2 + Arena.width/4 and GetGlobal("questions")["q" .. GetGlobal("currentQuestion")] == "R") then
		SetGlobal("canAttack", true)
		State("ATTACKING")
	end
end