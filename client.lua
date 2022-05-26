ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Superette.Marker) do 

    local blips = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blips, 59)
        SetBlipColour(blips, 2)
        SetBlipScale(blips, 0.65)
        SetBlipAsShortRange(blips, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Superette')
        EndTextCommandSetBlipName(blips)
    end
end)

function MenuSuperette()
    local MainMenu = RageUI.CreateMenu("Supérette", " ")
    local NouritureMenu = RageUI.CreateSubMenu(MainMenu, "Nouritures", " ")
    local BoissonsMenu = RageUI.CreateSubMenu(MainMenu, "Boissons", " ")
    local LocauxProduits = RageUI.CreateSubMenu(MainMenu, "~u~Entreprise", " ")
    MainMenu:SetRectangleBanner(0, 0, 0)
    NouritureMenu:SetRectangleBanner(0, 0, 0)
    BoissonsMenu:SetRectangleBanner(0, 0, 0)
    LocauxProduits:SetRectangleBanner(255, 255, 255)

        RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
            while MainMenu do
            Wait(0)
            RageUI.IsVisible(MainMenu, true, true, true, function()

                  RageUI.Separator("Bienvenue Mr. ~y~"..GetPlayerName(PlayerId()))

                  RageUI.ButtonWithStyle("→ Nouritures", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                  end, NouritureMenu)
                  RageUI.ButtonWithStyle("→ Boissons", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                  end, BoissonsMenu)
                  RageUI.ButtonWithStyle("→ Produits Locaux", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                  end, LocauxProduits)
                end, function()
                end)
                RageUI.IsVisible(NouritureMenu, true, true, true, function()
                 RageUI.Separator(' ↓  Voici la liste de nos produits  ↓ ')
                  for k,v in pairs(Superette.Nouritures) do
                  RageUI.ButtonWithStyle("→ "..v.name, nil, {RightLabel = " "..v.price.."$"}, true, function(Hovered, Active, Selected)
                         if Selected then
                            TriggerServerEvent("Azk:ShopAdvance", v.item, v.price)
                         end
                     end)
                  end
           end, function()
           end)
           RageUI.IsVisible(BoissonsMenu, true, true, true, function()
             RageUI.Separator(' ↓  Voici la liste de nos produits  ↓ ')
                  for k,v in pairs(Superette.Boissons) do
                         RageUI.ButtonWithStyle("→ "..v.name, nil, {RightLabel = " "..v.price.."$"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    TriggerServerEvent("Azk:ShopAdvance", v.item, v.price)
                                end
                            end)
                         end
                  end, function()
                  end)

            RageUI.IsVisible(LocauxProduits, true, true, true, function()
                RageUI.Separator("~p~ ↓ Vigneron ↓")
                    for k,v in pairs(Superette.Vigneron) do
                    RageUI.ButtonWithStyle("→ "..v.name, nil,  {RightLabel = " "..v.price.."$"}, true, function(Hovered, Active, Selected)
                    end) end 
                RageUI.Separator("~y~↓ Brasseur ↓")    
                    for k,v in pairs(Superette.Brasseur) do
                    RageUI.ButtonWithStyle("→ "..v.name, nil,  {RightLabel = " "..v.price.."$"}, true, function(Hovered, Active, Selected)
                    end) end 
                RageUI.Separator("~o~↓ Tabac ↓")
                    for k,v in pairs(Superette.Tabac) do
                    RageUI.ButtonWithStyle("→ "..v.name, nil,  {RightLabel = " "..v.price.."$"}, true, function(Hovered, Active, Selected)
                    end) end 
                RageUI.Separator("↓ Chocolatier ↓")
                    for k,v in pairs(Superette.Chocolatier) do
                    RageUI.ButtonWithStyle("→ "..v.name, nil,  {RightLabel = " "..v.price.."$"}, true, function(Hovered, Active, Selected)
                    end) end 
                end, function()
            end)

            RageUI.IsVisible(VigneronMenu, true, true, true, function()
  
                RageUI.ButtonWithStyle("→ Vigneron", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end)
                RageUI.ButtonWithStyle("→ Brasseur", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end)
                RageUI.ButtonWithStyle("→ Tabac", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end)
                RageUI.ButtonWithStyle("→ Chocolatier", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end)
            end, function()
        end)


            if not RageUI.Visible(MainMenu) and not RageUI.Visible(NouritureMenu) and not RageUI.Visible(BoissonsMenu) and not RageUI.Visible(LocauxProduits) then
                MainMenu = RMenu:DeleteType("Pôle emploi", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
      local wait = 500
      local playerCoords = GetEntityCoords(PlayerPedId())

      for k, v in pairs(Superette.Marker) do

        local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)

        if distance <= 5.0 then
          wait = 7
		  DrawMarker(23, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.4, 0.4, 0.4, 0, 0, 0, 255, false, true, p19, true) 

        if distance <= 1.5 then
         wait = 7
        AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ pour accéder à la ~y~Superette")
        DisplayHelpTextThisFrame("HELP", false)

           if IsControlJustPressed(1, 51) then
            MenuSuperette()
                  end
              end
          end
        end
          Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Superette.PedsPosition) do 
		function LoadModel(model)
			while not HasModelLoaded(model) do
				RequestModel(model)
				Wait(1)
			end
		end
		LoadModel("mp_m_shopkeep_01")
		Ped = CreatePed(2, GetHashKey("mp_m_shopkeep_01"), v.x, v.y, v.z, 197.81, 0, 0)
		FreezeEntityPosition(Ped, 1)
		SetEntityInvincible(Ped, true)
		SetBlockingOfNonTemporaryEvents(Ped, 1)
    TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_AA_COFFEE", 0, false)
	end
end)