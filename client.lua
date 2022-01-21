ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(5000)
    end  
end)

--------------

local open = false 
local MainMenu = RageUI.CreateMenu("Superette", "nos produits")
local SubMenu = RageUI.CreateSubMenu(MainMenu, "Nouritures", "Nouritures")
local SubMenu1 = RageUI.CreateSubMenu(MainMenu, "Boissons", "Boisson")
MainMenu.Display.Header = true 
MainMenu.Closed = function()
  open = false
end

--------------------

Citizen.CreateThread(function()
    if VisuBlips then 
        for k, v in pairs(Config.Blips) do 
            local blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(blip, 59)
                SetBlipScale(blip, 0.80)
                SetBlipColour(blip, 2)
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString('Superette')
                EndTextCommandSetBlipName(blip)
        end
    end
end)

------------------------

function RageUI.PoolMenus:Shop()
    MainMenu:IsVisible(function(button1)

		button1:AddButton("Nouritures", nil, {RightLabel = "→→", IsDisabled = false }, function(onSelected)
			if onSelected then
			end
		end, SubMenu)

        button1:AddButton("Boissons", nil, {RightLabel = "→→", IsDisabled = false }, function(onSelected)
			if onSelected then
			end
		end, SubMenu1)

        end, function()
        end)

        SubMenu:IsVisible(function(wesh)
            for k, v in pairs(Config.Nouritures) do 
            wesh:AddButton(v.Nom, nil, {RightLabel = "~g~"..v.prix.."$", IsDisabled = false }, function(onSelected)
                if onSelected then
                    TriggerServerEvent('azk:super',v)
                end
            end)
    
            end
        end, function()
        end)
        
        SubMenu1:IsVisible(function(Kingder)
            for k, v in pairs(Config.Boisson) do
            Kingder:AddButton(v.Nom, nil, {RightLabel = "~g~"..v.prix.."$", IsDisabled = false }, function(onSelected)
                if onSelected then
                    TriggerServerEvent('azk:super',v)
                end
            end)
        end
        end, function()
    end)
end


Citizen.CreateThread(function()
    while true do
      local wait = 750
      local playerCoords = GetEntityCoords(PlayerPedId(), false)
  
      for k, v in pairs(Config.Marker) do

        local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)
  
        if distance <= 5.0 then
          wait = 0
          DrawMarker(22, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.4, 0.4, 0.4, 255, 255, 0, 255, false, true, p19, false)  
              
        if distance <= 1.5 then
          wait = 0
         Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour accéder au ~b~Menu", 1) 
  
        if IsControlJustPressed(1, 51) then
            RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
                  end
              end
          end
        end
          Citizen.Wait(wait)
    end
  end)
