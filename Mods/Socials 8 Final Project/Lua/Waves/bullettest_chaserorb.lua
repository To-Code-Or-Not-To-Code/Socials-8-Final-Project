-- The chasing attack from the documentation example.
ticks = 0
chasingbullets = {}
for i = 1, 10 do
    chasingbullet = CreateProjectile('bullet', Arena.width / 2, Arena.height / 2)
    chasingbullet.SetVar('xspeed', 0)
    chasingbullet.SetVar('yspeed', 0)
    chasingbullet.SetVar('speedmult', i-i*0.9)
    chasingbullet.SetVar('speedoffset', math.random())
    chasingbullet.SetVar('canmove', true)
    chasingbullet.Move(math.random(30), math.random(30))
    table.insert(chasingbullets, chasingbullet)
end

function Update()
    for i = 1, #chasingbullets do
        local chasingbullet = chasingbullets[i]
        local xdifference = Player.x - chasingbullet.x
        local ydifference = Player.y - chasingbullet.y
        local xspeed = (chasingbullet.GetVar('xspeed') / 2 + xdifference / 50) * chasingbullet.GetVar('speedmult') +
                           chasingbullet.GetVar('speedoffset') * ((math.random(0, 1) * 2) - 1)
        local yspeed = chasingbullet.GetVar('yspeed') / 2 + ydifference / 50 * chasingbullet.GetVar('speedmult') +
                           chasingbullet.GetVar('speedoffset') * ((math.random(0, 1) * 2) - 1)
        local canmove = chasingbullet.GetVar('canmove')
        if canmove then
            chasingbullet.Move(xspeed, yspeed)
            chasingbullet.SetVar('xspeed', xspeed)
            chasingbullet.SetVar('yspeed', yspeed)
        end
        if math.random() > 0.75 and ticks % 30 == 0 then
            chasingbullet.SetVar('canmove', not canmove)
        end
        if math.random() > 0.95 and ticks % 180 == 0 then
            newchasingbullet = CreateProjectile('bullet', Arena.width / 2, Arena.height / 2)
            newchasingbullet.SetVar('xspeed', 0)
            newchasingbullet.SetVar('yspeed', 0)
            newchasingbullet.SetVar('speedmult', i-i*0.9)
            newchasingbullet.SetVar('speedoffset', math.random())
            newchasingbullet.SetVar('canmove', true)
            newchasingbullet.Move(math.random(30), math.random(30))
            table.insert(chasingbullets, newchasingbullet)
        end
    end
    ticks = ticks + 1
end

function OnHit()
    Player.Hurt(1,0.5)
end