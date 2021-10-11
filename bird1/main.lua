push = require 'push'  -- Library to setup screen features

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- Loads the image files and stores them as objects to later draw onto the screen
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

-- Define the portion of the image that will loop, to create a movement effect
-- Why 413? If you open the image, which is 1157x288, you can see that the pattern
-- is 413 pixels long. After that it repeats itself.
local BACKGROUND_LOOPING_POINT = 413

function love.load()
    -- Initialize our nearest-neighbor filter. This filter avoids blurring images.
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- app window title
    love.window.setTitle('Fifty Bird')

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end  

function love.resize(w, h)
    push:resize(w, h)
end    

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    -- Parallax Scrolling Effect
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH
end    

function love.draw()
    push:start()

    -- draw the background starting at top left
    love.graphics.draw(background, -backgroundScroll, 0)

    -- draw the ground on top of the background, toward the button of the screen
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT-16)

    push:finish()
end
