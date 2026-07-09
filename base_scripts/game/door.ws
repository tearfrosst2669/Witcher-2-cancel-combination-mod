/*************************************************************/
// Witcher Script file
/*******************************************************************/
// Object classes exports
// Copyright © 2009 CD Projekt RED
/***********************************************************************/
// Basic door class
// Whole door functionality is implemented in C++
// Use the door events to implement some custom behavior
import class CDoor extends CGameplayEntity
{
	// Are the door locked ?
	import final function AreLocked() : bool;

	// Are the door opened ?
	import final function AreOpened() : bool;

	// Open door
	import final function OpenDoor ( optional immediate : bool /*=true*/ ) : bool;

	// Close door
	import final function CloseDoor( optional immediate : bool /*=true*/ ) : bool;

	// Lock/Unlock the door
	import final function LockDoor ( optional locked : bool /*=true*/ );
	// Auto close ability
	import final function SetAutoClose( isAutoCloseEnabled : bool );

	// Is auto close enabled ?
	import final function IsAutoCloseEnabled() : bool;

	// ---------------------------------------------------------------------

	// Event called when doors were opened
	event OnDoorOpened( isPlayer, fromInside : bool )
	{
	}
	// Event called when doors are closed
	event OnDoorClosed()
	{
	}

	// Event called when we do not have a key
	// MODIFIED: force the door open instead of blocking the player
	event OnDoorNoKey()
	{
		LockDoor( false );
		OpenDoor();
		theHud.m_messages.ShowInformationText( GetLocStringByKeyExt( "Door forced open." ) );
	}

	// Event called when we do not have a valid DB fact to open this door
	// MODIFIED: force the door open instead of blocking the player
	event OnDoorNoFact()
	{
		LockDoor( false );
		OpenDoor();
		theHud.m_messages.ShowInformationText( GetLocStringByKeyExt( "Door forced open." ) );
	}

	// Event called when doors are locked and cannot be opened by fact or key
	// LEFT UNTOUCHED ON PURPOSE — these are doors with no key/fact ever assigned,
	// almost always out-of-bounds / level-boundary doors. Do not force these.
	event OnDoorNoWayToOpen()
	{
		theHud.m_messages.ShowInformationText( GetLocStringByKeyExt( "You cannot open this door right now!" ) );
	}
	// Event called when doors are unlocked
	event OnDoorUnlocked()
	{
		theHud.m_messages.ShowInformationText( GetLocStringByKeyExt( "Door unlocked using key." ) );
	}

	// ---------------------------------------------------------------------
}

/////////////////////////////////
// Old stuff
class CDoorSaveable extends CDoor
{
}
/////////////////////////////////
import class CBreakableDoor extends CDoor
{
	//Event called when doors have been broken
	event OnDoorBroken()
	{
	}
}
