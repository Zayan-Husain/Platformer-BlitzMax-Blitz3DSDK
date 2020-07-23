


'////////////////game_over_world/////////////////////

Type game_over Extends yworld	

	Method init()
		
		Super.init()
	EndMethod
	
	Method twodupdate()
		
		bbText 20, 20, "game over"
		bbText 20, 40, "press space to continue"
		
	EndMethod
	
	Method update()
		
		Super.update()
		nextLevel()
	EndMethod
	
	Method nextLevel()
		
		If bbKeyDown( 57 ) Then
			
			ye.change_world( "game_world" )
		EndIf
	EndMethod
	
	Function Create:game_over()
		
		tst:game_over =  New game_over

		
		Return tst
	
	EndFunction

EndType


'////////////////end game_over_world/////////////////////