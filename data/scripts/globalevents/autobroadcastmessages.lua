<<<<<<< HEAD
local autoBroadcast = GlobalEvent("AutoBroadcast")
function autoBroadcast.onThink(interval, lastExecution)
       local messages = {
    "Submit your personald feedback on Discord to assist us in our daily tweaking and updating of Evotronus!",
	"Indulge in the benefits of style and strength! Adorn yourself with a full addon or exclusive outfit to gain 1,000 health and mana, along with a 0.5% bonus to healing and 0.1% protection against all harm. Every piece counts on the path to greatness!",
	"Enhance your character with a single full addon or exclusive outfit! Enjoy a boost of 1,000 health and mana, along with a 0.5% bonus to healing and 0.1% protection against all damage. Elevate your stats and conquer challenges!",
	"Unlock the power within! Equip a full addon or exclusive outfit for an instant upgrade: +1,000 health and mana, a 0.5% bonus to healing, and 0.1% protection against all damage. A small change for a mighty impact on your adventures!",
	"Witness the transformation! Each full addon or exclusive outfit you wear grants you 1,000 extra health and mana, a 0.5% healing boost, and a 0.1% increase in protection against all threats. One step closer to becoming an unstoppable force!",
	"Power up your character with exclusive outfits and addons! Each full addon or exclusive outfit grants unique worthy bonuses. Stack up your collection for substantial boosts in health, mana, protection all, and healing bonus. The more, the mightier!",
	"Donate to fuel the flames of progress. Your support lays the foundation for a dynamic, ever-evolving gaming realm. Contribute and be a part of the journey!",
	"Your journey is our legacy. Support the server, and together, we'll create an environment where every adventurer finds a home.",
	"Your support fuels our journey. Consider donating and join us in building a vibrant, ever-evolving gaming environment. Every contribution matters!",
	"Guilds forge bonds that withstand the test of time. Create yours, lead warriors, and embark on a journey of triumph. Unity prevails!",
	"Events bring the community alive. Dive into the excitement, showcase your skills, and let the spirit of competition ignite your passion.",
	"Event participation is the key to a vibrant community. Engage, compete, and let the thrill of victory echo across the realms. Your presence matters!",
	"Fuel the flames of victory! Your support powers the server's growth. Donate today and be a part of the force driving continuous improvement.",
	"Guilds are the backbone of the server. Create yours, recruit warriors, and embark on a journey of conquest. Guilds, where legends are born!",
	"Participate in events, compete, and let the thrill of victory be your reward. Your presence makes every event unforgettable!",
	"Discover the power of friendship. Teamwork transcends challenges. Invite your friends to the adventure, create memories, and conquer together!",
	"Elevate your gameplay, support the server! Your donations fuel constant improvements. Visit our website to contribute and enhance your gaming experience.",
    "To report bugs, please use our Discord, Website or ingame reporting tool! Rewards may await you.",
    "Quick tip: Use the '/bosses' command to check our unique bosses system, remember every first kill of boss from this list gives Stat Points!",
    "Quick tip: Promotion npc located at First Desert in explore aible area, you need 120 level to buy promotion!",
	"Crafting tip: Gather resources as you explore. Crafting powerful gear and items requires materials, and a prepared adventurer is a successful one!",
	"Quick tip: Use the 'help' channel for instant help for essential information, or try use Discord!.",
	"Navigation tip: Set marks on your minimap to streamline your journey across the expansive game world.",
    "Quick tip: Do tasks, they are realy worthy to do!"
}

    Game.broadcastMessage(messages[math.random(#messages)], MESSAGE_EVENT_ADVANCE)
    return true
end

autoBroadcast:interval(1560000) -- 26 minutes, 1000x60 - 60sec
=======
local autoBroadcast = GlobalEvent("AutoBroadcast")
function autoBroadcast.onThink(interval, lastExecution)
       local messages = {
    "Submit your personald feedback on Discord to assist us in our daily tweaking and updating of Evotronus!",
	"Indulge in the benefits of style and strength! Adorn yourself with a full addon or exclusive outfit to gain 1,000 health and mana, along with a 0.5% bonus to healing and 0.1% protection against all harm. Every piece counts on the path to greatness!",
	"Enhance your character with a single full addon or exclusive outfit! Enjoy a boost of 1,000 health and mana, along with a 0.5% bonus to healing and 0.1% protection against all damage. Elevate your stats and conquer challenges!",
	"Unlock the power within! Equip a full addon or exclusive outfit for an instant upgrade: +1,000 health and mana, a 0.5% bonus to healing, and 0.1% protection against all damage. A small change for a mighty impact on your adventures!",
	"Witness the transformation! Each full addon or exclusive outfit you wear grants you 1,000 extra health and mana, a 0.5% healing boost, and a 0.1% increase in protection against all threats. One step closer to becoming an unstoppable force!",
	"Power up your character with exclusive outfits and addons! Each full addon or exclusive outfit grants unique worthy bonuses. Stack up your collection for substantial boosts in health, mana, protection all, and healing bonus. The more, the mightier!",
	"Donate to fuel the flames of progress. Your support lays the foundation for a dynamic, ever-evolving gaming realm. Contribute and be a part of the journey!",
	"Your journey is our legacy. Support the server, and together, we'll create an environment where every adventurer finds a home.",
	"Your support fuels our journey. Consider donating and join us in building a vibrant, ever-evolving gaming environment. Every contribution matters!",
	"Guilds forge bonds that withstand the test of time. Create yours, lead warriors, and embark on a journey of triumph. Unity prevails!",
	"Events bring the community alive. Dive into the excitement, showcase your skills, and let the spirit of competition ignite your passion.",
	"Event participation is the key to a vibrant community. Engage, compete, and let the thrill of victory echo across the realms. Your presence matters!",
	"Fuel the flames of victory! Your support powers the server's growth. Donate today and be a part of the force driving continuous improvement.",
	"Guilds are the backbone of the server. Create yours, recruit warriors, and embark on a journey of conquest. Guilds, where legends are born!",
	"Participate in events, compete, and let the thrill of victory be your reward. Your presence makes every event unforgettable!",
	"Discover the power of friendship. Teamwork transcends challenges. Invite your friends to the adventure, create memories, and conquer together!",
	"Elevate your gameplay, support the server! Your donations fuel constant improvements. Visit our website to contribute and enhance your gaming experience.",
    "To report bugs, please use our Discord, Website or ingame reporting tool! Rewards may await you.",
    "Quick tip: Use the '/bosses' command to check our unique bosses system, remember every first kill of boss from this list gives Stat Points!",
    "Quick tip: Promotion npc located at First Desert in explore aible area, you need 120 level to buy promotion!",
	"Crafting tip: Gather resources as you explore. Crafting powerful gear and items requires materials, and a prepared adventurer is a successful one!",
	"Quick tip: Use the 'help' channel for instant help for essential information, or try use Discord!.",
	"Navigation tip: Set marks on your minimap to streamline your journey across the expansive game world.",
    "Quick tip: Do tasks, they are realy worthy to do!"
}

    Game.broadcastMessage(messages[math.random(#messages)], MESSAGE_EVENT_ADVANCE)
    return true
end

autoBroadcast:interval(1560000) -- 26 minutes, 1000x60 - 60sec
>>>>>>> 8900eb460efeecbd5e68adf2d4e6fc52d6346528
autoBroadcast:register()