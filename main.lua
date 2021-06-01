function love.load()
    world = love.physics.newWorld()

    player = {
        speed = 2,
        --trans = love.math.newTransform(0, 0),
        image = love.graphics.newImage("tmpluz.png"),
		x = 0,
		y = 0
        -- do images in sprite (batch thing)
        --ph = {}
    }
    --player.ph.body = love.physics.newBody(world, 0, 0, "dynamic")
    --player.ph.shape = love.physics.newRectangleShape(player.image:getWidth(), player.image:getHeight())
    --player.ph.fixture = love.physics.newFixture(player.ph.body, player.ph.shape)
    -- do we need physics?
end

function love.draw()
    -- make a table of all objects that should be rendered and go through it, drawing them
    love.graphics.draw(player.image, player.x, player.y, 0, 0.25, 0.25)
end

mx, my = 0, 0
function love.update(dt)
    if love.mouse.isDown(1) then
        mx, my = love.mouse.getPosition()
    end
    move(player, mx, my)
    -- calculate route (use love.physics for obstacles?) between player starting point and ending point
    world:update(dt)
end

function move(obj, x, y)
    if not (compare(x, obj.x, obj.speed) and compare(y, obj.y, obj.speed)) then
        run = x - obj.x
        rise = y - obj.y
        mag = math.sqrt((rise ^ 2) + (run ^ 2))
        vx = run / mag
        vy = rise / mag

        obj.x = obj.x + vx * obj.speed
        obj.y = obj.y + vy * obj.speed
    end
end

--[[function move(obj, x, y)
    if not (compare(x, obj.ph.body:getX(), obj.speed) and compare(y, obj.ph.body:getY(), obj.speed)) then
        run = x - obj.ph.body:getX()
        rise = y - obj.ph.body:getY()
        mag = math.sqrt((rise ^ 2) + (run ^ 2))
        vx = run / mag
        vy = rise / mag

        obj.ph.body:setX(obj.ph.body:getX() + vx * obj.speed)
        obj.ph.body:setY(obj.ph.body:getY() + vy * obj.speed)

        obj.trans = love.math.newTransform(obj.ph.body:getX() - obj.image:getWidth() / 2, obj.ph.body:getY() - obj.image:getHeight() / 2)
    end
end]]

function compare(n1, n2, margin)
    return (n1 < n2 + 0.5 * margin) and (n1 > n2 - 0.5 * margin)
end
