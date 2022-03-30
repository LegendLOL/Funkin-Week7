package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import Paths;
import Song;
import Conductor;
import Math;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import lime.utils.Assets;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;

import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;

#if cpp
import Sys;
import sys.FileSystem;
#end


using StringTools;

class BackgroundTankmen extends FlxSprite
{
  
  public var tankSpeed:Float = 0.7 * 1000;
  public var goingRight:Bool = false;
  var runAnimPlayedTimes:Int = 0;
  var runAnimPlayedTimesMax:Int = 1;

  override public function new()
  {
      super();
      frames = Paths.getSparrowAtlas("tank/tankmanKilled1");
      antialiasing = true;
      animation.addByPrefix("run", "tankman running ", 24, false);
      animation.addByPrefix("shot", "John Shot " + FlxG.random.int(1,2), 24, false);
      animation.play("run");
      
      updateHitbox();
      setGraphicSize(Std.int(width * 0.8));
      updateHitbox();
  }

  public function resetShit (xPos:Float, yPos:Float, right:Bool, ?stepsMax:Int, ?speedModifier:Float = 1)
  {
      x = xPos;
      y = yPos;

      goingRight = right;

      if(stepsMax == null)
        {
            stepsMax = 1;
        }

      if(speedModifier == null)
        {
            speedModifier = 1;
        } 
        
        runAnimPlayedTimesMax = stepsMax;

        var newSpeedModifier:Float = speedModifier * 2;

        tankSpeed = FlxG.random.float(0.5, 1) * 165;
  } 
  override public function update(elapsed:Float)
    {
        super.update(elapsed);
        
        if(animation.curAnim.name == "run" && animation.curAnim.finished == true && runAnimPlayedTimes >= runAnimPlayedTimesMax)
        {   
            animation.play("shot", true);
            runAnimPlayedTimes = 0;                     
        }

        if(animation.curAnim.name == "shot" && animation.curAnim.curFrame >= animation.curAnim.frames.length - 1)
        {
            destroy();
        }
    }

}