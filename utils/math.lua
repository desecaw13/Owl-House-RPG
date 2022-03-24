local t = {}

-- Compares two floats and sees if they are close enough.
function t.compare(n1, n2, margin)
	return (n1 < n2 + 0.5 * margin) and (n1 > n2 - 0.5 * margin)
end

return t
