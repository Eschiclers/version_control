VC = {}
VC.TimeoutCount = 0
VC.CancelledTimeouts = {}

VC.SetTimeout = function(msec, cb)
	local id = VC.TimeoutCount + 1

	SetTimeout(msec, function()
		if VC.CancelledTimeouts[id] then
			VC.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	VC.TimeoutCount = id

	return id
end

VC.ClearTimeout = function(id)
	VC.CancelledTimeouts[id] = true
end