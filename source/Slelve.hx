package;

import flixel.FlxSprite;
import flixel.system.FlxSound;

class Slelve extends FlxSprite{

	private var stamina:Int;
	private var deadSound:FlxSound;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X,Y);
		loadGraphic(AssetPaths.esclavo__png,true,72,72);
		animation.add("work",[0,1,2,3],Random.int(3,6));
		animation.add("hide",[4,5,6,7],15,false);
		animation.add("dead",[8,9,8,10],4);
		animation.play("work");
		width = 36;
		height = 40;
		offset.x = 19;
		offset.y = 20;

		animation.finishCallback = function(name)
		{
			if(name == "hide")
			{		    	
		    	if(stamina <= 0)
				{			
					animation.play("dead");		
					deadSound.play();
				}
				else
					animation.play("work");
			}
		}

		stamina = Random.int(2,4);

		deadSound = new FlxSound();
		deadSound.loadEmbedded(AssetPaths.anotherDead__ogg);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

	}

	public function whipped()
	{
		stamina--;
		animation.play("hide");
	}	
}