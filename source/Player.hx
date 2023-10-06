package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

class Player extends FlxGroup
{
	public var playerSprite:FlxSprite;
	public var whipSprite:FlxSprite;
	public var playerDesksCollider:FlxSprite;
	private var playerSpeed:Float = 280;
	private var attacking:Bool = false;	
	private var whipSound:FlxSound;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super();

		playerSprite = new FlxSprite(X,Y);
		playerSprite.loadGraphic(AssetPaths.player__png,true,48,48);
		playerSprite.setFacingFlip(FlxObject.LEFT, true, false);
 		playerSprite.setFacingFlip(FlxObject.RIGHT, false, false);
 		playerSprite.animation.add("idle",[0,1,2,3],7);
		playerSprite.animation.add("run",[4,5,6,7],15);
		playerSprite.animation.add("attack",[8,9],7,false);
		//playerSprite.animation.finishCallback("attack") = function(){attacking = false;};
		playerSprite.animation.play("idle");		
		//playerSprite.drag.x = playerSprite.drag.y = 5000;
		playerSprite.height = 44;
		playerSprite.width = 32;
		playerSprite.offset.set(8, 4);
		//add(playerSprite); //Se añade al grupo de sprites

		playerDesksCollider = new FlxSprite(playerSprite.x,playerSprite.y+30);
		playerDesksCollider.drag.x = playerDesksCollider.drag.y = 5000;
		playerDesksCollider.makeGraphic(32,14,FlxColor.LIME);
		playerDesksCollider.visible = false;
		add(playerDesksCollider);

		whipSprite = new FlxSprite(X+44,Y);
		whipSprite.loadGraphic(AssetPaths.whip__png, true, 48, 48);
		whipSprite.height = 15;
		whipSprite.offset.y = 33;
		whipSprite.animation.add("chask",[0,1],10);
		whipSprite.visible = false;
 		whipSprite.setFacingFlip(FlxObject.LEFT, true, false);
 		whipSprite.setFacingFlip(FlxObject.RIGHT, false, false);
		//add(whipSprite); //Se añade al grupo de sprites	
		
		whipSound = new FlxSound();
		whipSound.loadEmbedded("assets/sounds/whip.ogg");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
//FlxG.log.add(this.y);
		
		move();	
		attack();	
	}

	private function attack()
	{
		if(attacking)
		{
			if(playerSprite.animation.frameIndex == 9 && !whipSprite.visible)
			{
				whipSprite.visible = true;
				whipSprite.animation.play("chask");
			}
			if(playerSprite.animation.finished)
			{
				attacking = false;
				whipSprite.visible = false;
			}			
		}

		if(FlxG.keys.justPressed.SPACE)
		{
			attacking = true;
			playerSprite.animation.play("attack");
			whipSound.play();
		}		
	}

	private function move()
	{
		if (!attacking)
		{
			var _up:Bool = false;
			var _down:Bool = false;
			var _left:Bool = false;
			var _right:Bool = false;

			_up = FlxG.keys.pressed.UP;
			_down = FlxG.keys.pressed.DOWN;
			_left = FlxG.keys.pressed.LEFT;
			_right = FlxG.keys.pressed.RIGHT;

			if (_up && _down)
			    _up = _down = false;
			if (_left && _right)
			    _left = _right = false;
		
			if (_up || _down || _left || _right)
			{
				playerSprite.animation.play("run");
				var mA:Float = 0;
				if (_up)
				{
				    mA = -90;
				    if (_left)
				    {
				        mA -= 45;
				        whipSprite.facing = playerSprite.facing = FlxObject.LEFT;
				    }
				    else if (_right)
				    {
				        mA += 45;
				        whipSprite.facing = playerSprite.facing = FlxObject.RIGHT;
				    }
				}
				else if (_down)
				{
				    mA = 90;
				    if (_left)
				    {
				        mA += 45;
				        whipSprite.facing = playerSprite.facing = FlxObject.LEFT;
				    }
				    else if (_right)
				    {
				        mA -= 45;
				        whipSprite.facing = playerSprite.facing = FlxObject.RIGHT;
				    }
				}
				else if (_left)
				{
				    mA = 180;
					whipSprite.facing = playerSprite.facing = FlxObject.LEFT;
				}
				else if (_right)
				{
				    mA = 0;
					whipSprite.facing = playerSprite.facing = FlxObject.RIGHT;
				}

				playerDesksCollider.velocity.set(playerSpeed, 0);
		 		playerDesksCollider.velocity.rotate(FlxPoint.weak(0, 0), mA);			

		 	}
		 	else
		 	{
		 		playerSprite.animation.play("idle");
		 	}
		}

	 	if (playerDesksCollider.y < 235+34) playerDesksCollider.y = 235+34;
	 	if (playerDesksCollider.y > 432+34) playerDesksCollider.y = 432+34;
	 	if (playerDesksCollider.x < 0) playerDesksCollider.x = 0;
	 	if (playerDesksCollider.x > 610) playerDesksCollider.x = 610;

	 	(playerSprite.facing == FlxObject.RIGHT)? whipSprite.x = playerSprite.x + 40 : whipSprite.x = playerSprite.x - 56;
		whipSprite.y = playerSprite.y +29;	

	}
}