local relative_tilt = {}

function relative_tilt.target(current_percent, step)
  return math.max(0, math.min(100, current_percent + step))
end

function relative_tilt.to_matter_percent100ths(tilt_percent)
  return (100 - tilt_percent) * 100
end

function relative_tilt.from_matter_percent100ths(tilt_percent100ths)
  return 100 - math.floor(tilt_percent100ths / 100)
end

return relative_tilt