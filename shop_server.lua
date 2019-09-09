local storeX,storeY,storeZ = 218.2412109375,14.3720703125,1.578125 -- STORE LOCATION // [CHANGE IT IF YOU WANT]
local storemarker = createMarker(storeX,storeY,storeZ,"cylinder",3)
local storeicon = createBlip(storeX,storeY,storeZ,31)
local moneygained = 500 -- MONEY EARNED PER PLAYER KILL // [CHANGE IT IF YOU WANT]

function openShopWindow (hitElement,matchingDimension)
	if ( getElementType(hitElement) == "player" ) then
		theMoney = getPlayerMoney(hitElement)
		triggerClientEvent(hitElement,"openShopWindowClient",hitElement,theMoney)
	end
end
addEventHandler("onMarkerHit",storemarker,openShopWindow)

function tryingToBuyItem (itemname,itemprice)
	if ( getPlayerMoney(client) >= itemprice ) then
		setPlayerMoney(client,(getPlayerMoney(client)) -itemprice)
		setElementData(client,itemname,(getElementData(client,itemname) or 0) +1)
		outputChatBox("+1 "..itemname.." added to your inventory!", client, 0, 255, 0)
		local newmoney = getPlayerMoney(client)
		triggerClientEvent(client,"updateShopThingsTwo",client,newmoney)
	else
		outputChatBox("You don't have enough money to buy this!", client, 255, 0, 0)
	end
end
addEvent("tryingToBuyItem",true)
addEventHandler("tryingToBuyItem",getRootElement(),tryingToBuyItem)

function tryingToSellItem (itemname,itemprice)
	if ( getElementData(client,itemname) >= 1 ) then
		setPlayerMoney(client,(getPlayerMoney(client)) +itemprice)
		setElementData(client,itemname,(getElementData(client,itemname) or 0) -1)
		outputChatBox("-1 "..itemname.." removed from your inventory!", client, 0, 255, 0)
		local newmoney = getPlayerMoney(client)
		triggerClientEvent(client,"updateShopThingsTwo",client,newmoney)
	else
		outputChatBox("You don't have items to sell!", client, 255, 0, 0)
	end
end
addEvent("tryingToSellItem",true)
addEventHandler("tryingToSellItem",getRootElement(),tryingToSellItem)

function giveShopPlayerMoney (ammo,attacker,weapon,bodypart)
	setPlayerMoney(attacker,(getPlayerMoney(attacker)) +moneygained)
	outputChatBox("You have earned $"..moneygained.." for killing "..getPlayerName(source).."!", attacker, 0, 255, 0)
end
addEventHandler("onPlayerWasted",getRootElement(),giveShopPlayerMoney)