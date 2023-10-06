package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

class MenuState extends FlxState
{
	var titleTxt:FlxText;
	var howToTxt:FlxText;

	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;

		var flags:FlxSprite = new FlxSprite(0,0,"assets/images/MenuState.png");
		add(flags);

		var telon:FlxSprite = new FlxSprite(0,0);
		telon.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(telon);
		FlxTween.tween(telon, {y:FlxG.height}, 3, {onComplete: function(_)
																{
																	titleTxt.visible = howToTxt.visible = true;																	
																}
		}).start;

		titleTxt = new FlxText(95,140,FlxG.width-190,"Santa's\nsuper-candy-happy\ntoy factory\n#237",28);
		titleTxt.alignment = FlxTextAlign.CENTER;
		titleTxt.color = 0xffe60016;
		titleTxt.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff23c700, 2);
		titleTxt.visible = false;
		add(titleTxt);

		howToTxt = new FlxText(10,FlxG.height-30,500,"Arrow keys + Spacebar",14);
		howToTxt.color = 0xff3cafab;
		howToTxt.visible = false;
		add(howToTxt);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if(FlxG.keys.justPressed.ANY && titleTxt.visible)
			FlxG.switchState(new PlayState());
	}	
}
