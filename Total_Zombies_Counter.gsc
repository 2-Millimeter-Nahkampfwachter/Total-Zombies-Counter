#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm_utility;

init()
{
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for( ;; )
	{
		level waittill( "connecting", player );
		player thread onplayerspawned();
	}
}

onplayerspawned(){
	self endon("disconnect");
	self thread zombie_counter();
	for(;;){
		self waittill("spawned_player");
	}
}

zombie_counter(){
    level endon( "game_ended" );
    self endon("disconnect");
    flag_wait( "initial_blackscreen_passed" );
    self.zombiecounter = createfontstring( "Objective", 1.7 );
    self.zombiecounter setpoint( "CENTER", "CENTER", 0, 200 );
    self.zombiecounter.alpha = 1;
    self.zombiecounter.hidewheninmenu = 1;
    self.zombiecounter.hidewhendead = 1;
    self.zombiecounter.label = &"Zombies Left: ^1";
    for(;;){
        if(isdefined(self.afterlife) && self.afterlife){
            self.zombiecounter.alpha = 0.2;
        } else {
            self.zombiecounter.alpha = 1;
        }
        self.zombiecounter setvalue( level.zombie_total + get_current_zombie_count() );
        wait 0.05;
    }
}

