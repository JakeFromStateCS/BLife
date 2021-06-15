/*
	Unnamed Project
    --By Blasphemy
*/

GM.StartTime = SysTime();

Base = Base or {};

GM.Name = "Beigelands Roleplay";
GM.Author = "Matt.";

Base.Name = "Beigelands Roleplay";
Base.Author = "Matt.";
Base.FolderName = "BLife";--( GAMEMODE and GAMEMODE.FolderName ) or GM.FolderName;

include( "main/sh_config.lua" );
include( "main/cl_main.lua" );


DeriveGamemode( "base" );