ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end  
end)

--------------

local open = false 
local MainMenu = RageUI.CreateMenu("Location", "INTERACTION")
MainMenu.Display.Header = true 
MainMenu.Closed = function()
  open = true
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

function magasin()
    if open then 
        open = false 
        RageUI.Visible(MainMenu, false)
        return
    else
        open = true 
        RageUI.Visible(MainMenu, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MainMenu,  function()
                    for k, v in pairs(Config.Item) do 

                        RageUI.Button(v.item, nil, {RightLabel = "~g~"..v.prix.."$"}, true , {
                            onSelected = function()
                                TriggerServerEvent('azkloc:achat', v)
                            end
                            })
                    end
                end)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do 

        local wait = 1000

            for k, v in pairs(Config.Blips) do 

                local plyCoords = GetEntityCoords(PlayerPedId())
                local dist = GetDistanceBetweenCoords(plyCoords, v.x, v.y, v.z, true)

                if dist <= 10.0 then 
                    wait = 0
                    DrawMarker(22, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 0 , 255, true, true, p19, true) 

                if dist <= 1.5 then 
                    wait = 0 
                    Visual.Subtitle('Appuyez sur [E] pour acceder au menu', 1)
                    if IsControlJustPressed(1,51) then
                        magasin() 

                     end
                end
                end
            end
    end
end)
