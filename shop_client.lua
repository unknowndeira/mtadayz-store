local storeitems = {
-- ITEM / PRICE	 // [YOU MUST EDIT IT]
{"M4",1000},
}

local screenW, screenH = guiGetScreenSize()
shopWindow = guiCreateWindow((screenW - 545) / 2, (screenH - 455) / 2, 545, 455, "Shop", false)
guiWindowSetSizable(shopWindow, false)
guiWindowSetMovable(shopWindow, false)
guiSetVisible(shopWindow, false)
shopList = guiCreateGridList(10, 24, 195, 421, false, shopWindow)
shopListColumn = guiGridListAddColumn(shopList, "Items", 0.9)
shopBuy = guiCreateButton(215, 293, 320, 44, "Buy", false, shopWindow)
shopSell = guiCreateButton(215, 347, 320, 44, "Sell", false, shopWindow)
shopClose = guiCreateButton(215, 401, 320, 44, "Close", false, shopWindow)
shopMoney = guiCreateLabel(215, 34, 320, 15, "Your money : None", false, shopWindow)
shopName = guiCreateLabel(215, 79, 320, 15, "Item name : None", false, shopWindow)
shopValue = guiCreateLabel(215, 98, 320, 15, "Item value : None", false, shopWindow)
shopAmount = guiCreateLabel(215, 117, 320, 15, "Your amount : None", false, shopWindow)

local rowShop = 0
local nameShop = ""
for i, item in ipairs(storeitems) do
	nameShop = item[1]
	rowShop = guiGridListAddRow(shopList)
	guiGridListSetItemText(shopList, rowShop, shopListColumn, nameShop, false, false)
end

function getShopItemPrice (request)
	for i,item in ipairs(storeitems) do
		if ( request == item[1] ) then
			return item[2]
		end
	end
	return false
end

function openShopWindowClient (money)
	guiSetText(shopMoney,"Your money : $"..money)
	guiSetVisible(shopWindow,true)
	showCursor(true)
end
addEvent("openShopWindowClient",true)
addEventHandler("openShopWindowClient",getRootElement(),openShopWindowClient)

function closeShopWindowClient ()
	showCursor(false)
	guiSetVisible(shopWindow,false)
end

function updateShopThings ()
	local theName = guiGridListGetItemText(shopList,guiGridListGetSelectedItem(shopList), 1)
	if ( theName ~= false ) or ( theName ~= nil ) then 
		if ( theName ~= "" ) then 
			local value = getShopItemPrice(theName)
			local amount = getElementData(getLocalPlayer(),theName) or 0
			guiSetText(shopName,"Item name : "..theName)
			guiSetText(shopValue,"Item value : $"..value)
			guiSetText(shopAmount,"Your amount : "..amount)
		else
			guiSetText(shopName,"Item name : None")
			guiSetText(shopValue,"Item value : None")
			guiSetText(shopAmount,"Your amount : None")
		end
	else
		guiSetText(shopName,"Item name : None")
		guiSetText(shopValue,"Item value : None")
		guiSetText(shopAmount,"Your amount : None")
	end
end

function updateShopThingsTwo (money)
	local theName = guiGridListGetItemText(shopList,guiGridListGetSelectedItem(shopList), 1)
	if ( theName ~= false ) or ( theName ~= nil ) then 
		if ( theName ~= "" ) then 
			local value = getShopItemPrice(theName)
			local amount = getElementData(getLocalPlayer(),theName) or 0
			guiSetText(shopMoney,"Your money : $"..money)
			guiSetText(shopName,"Item name : "..theName)
			guiSetText(shopValue,"Item value : $"..value)
			guiSetText(shopAmount,"Your amount : "..amount)
		else
			guiSetText(shopMoney,"Your money : $"..money)
			guiSetText(shopName,"Item name : None")
			guiSetText(shopValue,"Item value : None")
			guiSetText(shopAmount,"Your amount : None")
		end
	else
		guiSetText(shopMoney,"Your money : $"..money)
		guiSetText(shopName,"Item name : None")
		guiSetText(shopValue,"Item value : None")
		guiSetText(shopAmount,"Your amount : None")
	end
end
addEvent("updateShopThingsTwo",true)
addEventHandler("updateShopThingsTwo",getRootElement(),updateShopThingsTwo)

function buyShopThing ()
	local theName = guiGridListGetItemText(shopList,guiGridListGetSelectedItem(shopList), 1)
	if ( theName ~= false ) or ( theName ~= nil ) then 
		if ( theName ~= "" ) then 
			local itemprice = getShopItemPrice(theName)
			triggerServerEvent("tryingToBuyItem",getLocalPlayer(),theName,itemprice)
		end
	end
end

function sellShopThing ()
	local theName = guiGridListGetItemText(shopList,guiGridListGetSelectedItem(shopList), 1)
	if ( theName ~= false ) or ( theName ~= nil ) then 
		if ( theName ~= "" ) then 
			local itemprice = getShopItemPrice(theName)
			triggerServerEvent("tryingToSellItem",getLocalPlayer(),theName,itemprice)
		end
	end
end

addEventHandler("onClientGUIClick",shopList,updateShopThings,false)
addEventHandler("onClientGUIClick",shopBuy,buyShopThing,false)
addEventHandler("onClientGUIClick",shopSell,sellShopThing,false)
addEventHandler("onClientGUIClick",shopClose,closeShopWindowClient,false)