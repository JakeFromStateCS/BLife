
MINIGAME = MINIGAME or {};
MINIGAME.Hooks = {};
MINIGAME.Nets = {};

MINIGAME.Name = "Citizen";
MINIGAME.Description = "Do what you do, it's free run.";
MINIGAME.Color = Color(155, 89, 182, 255);
MINIGAME.Default = true;
MINIGAME.AllowedGroups = {"*"};
MINIGAME.Teams = {
	["Runner"] = {
		default = true,
		color = Color(200, 200, 200, 255),
		weapons = {
		"weapon_crowbar",
		}
	};
};
