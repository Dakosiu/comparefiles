local talk = TalkAction("/text", "!text")

function talk.onSay(player, words, param)
	if player:getGroup():getAccess() and param ~= "" then
		local split = param:split(",")
		player:getPosition():sendAnimatedText(split[1], split[2])
	end
	return false
end

talk:separator(" ")
talk:register()

local talk = TalkAction("/text2", "!text2")

function talk.onSay(player, words, param)
	if player:getGroup():getAccess() and param ~= "" then
		local split = param:split(",")
		player:getPosition():sendAnimatedText2(split[1])
	end
	return false
end

talk:separator(" ")
talk:register()
