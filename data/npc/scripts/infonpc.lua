local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

npcHandler:addModule(FocusModule:new())

-- Función para iniciar la conversación
function onCreatureSay(cid, type, msg)
    if npcHandler:isFocused(cid) then
        npcHandler:processMessages(cid, msg)
    end
end

-- Respuestas del NPC
local function onHello(cid)
    npcHandler:say("¡Hola! ¿Te gustaría saber más sobre el juego?", cid)
end

local function onGameModes(cid)
    npcHandler:say("Existen tres modos de juego: \n1. **Supervivencia**: Un modo donde debes sobrevivir en un mundo peligroso lleno de desafíos. \n2. **Rivales**: Compite contra otros jugadores para dominar el mundo. \n3. **Mata a todos**: El objetivo es eliminar a todos los enemigos que encuentres. El último en pie gana.", cid)
end

local function onForgeNFTs(cid)
    npcHandler:say("La forja de NFTs permite a los jugadores crear, intercambiar y coleccionar objetos únicos dentro del juego. Estos objetos pueden ser usados, vendidos o exhibidos en el mercado de NFTs.", cid)
end

local function onNobleman(cid)
    npcHandler:say("El Trader Nobleman es un personaje especial que ofrece beneficios exclusivos a los jugadores que se suscriben al premium 'Magesty' a través del Alpha Pack. Esto incluye acceso a áreas exclusivas, objetos especiales y mejoras en la experiencia de juego.", cid)
end

local function onBye(cid)
    npcHandler:say("Adiós, ¡nos vemos pronto!", cid)
end

-- Manejador de las palabras clave
keywordHandler:addKeyword({"hola"}, onHello)
keywordHandler:addKeyword({"modos de juego"}, onGameModes)
keywordHandler:addKeyword({"forja de nfts"}, onForgeNFTs)
keywordHandler:addKeyword({"nobleman"}, onNobleman)
keywordHandler:addKeyword({"adiós"}, onBye)

-- Activar el NPC para que responda a los mensajes
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, onCreatureSay)
npcHandler:addModule(FocusModule:new())

