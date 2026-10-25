package.path = package.path .. ";matter-window-covering/src/?.lua"

local relative_tilt = require "relative_tilt"

assert(relative_tilt.target(50, 25) == 75)
assert(relative_tilt.target(90, 25) == 100)
assert(relative_tilt.target(10, -25) == 0)
assert(relative_tilt.target(50, -10) == 40)

assert(relative_tilt.to_matter_percent100ths(0) == 10000)
assert(relative_tilt.to_matter_percent100ths(100) == 0)
assert(relative_tilt.from_matter_percent100ths(8500) == 15)
assert(relative_tilt.from_matter_percent100ths(0) == 100)

print("relative tilt math tests passed")