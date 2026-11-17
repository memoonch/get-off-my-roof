package com.getoffmyroof.assets
{
   import com.getoffmyroof.entity.PigeonColor;
   import com.quasimondo.geom.ColorMatrix;
   import com.urbansquall.ginger.Animation;
   import com.urbansquall.ginger.AnimationPlayer;
   import com.urbansquall.ginger.tools.AnimationBuilder;
   import com.urbansquall.ginger.tools.AnimationPlayerFactory;
   import flash.display.MovieClip;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   
   public class Animations
   {
      
      public function Animations()
      {
         super();
      }
      
      private static function createPigeonAnimations(param1:AnimationPlayerFactory, param2:MovieClip, param3:Array, param4:String = "", param5:int = 0, param6:int = 0) : *
      {
         var _loc7_:PigeonColor = null;
         var _loc8_:AnimationPlayer = null;
         var _loc9_:MovieClip = null;
         var _loc10_:ColorMatrix = null;
         var _loc11_:ColorMatrixFilter = null;
         var _loc12_:Array = null;
         var _loc13_:Animation = null;
         var _loc14_:Animation = null;
         var _loc15_:Animation = null;
         var _loc16_:Animation = null;
         var _loc17_:Animation = null;
         var _loc18_:Animation = null;
         var _loc19_:Animation = null;
         var _loc20_:Animation = null;
         for each(_loc7_ in param3)
         {
            _loc8_ = new AnimationPlayer();
            _loc9_ = param2;
            if(_loc7_.colorTransform)
            {
               _loc9_.transform.colorTransform = _loc7_.colorTransform;
            }
            _loc10_ = new ColorMatrix();
            _loc10_.adjustContrast(_loc7_.contrast / 100);
            _loc10_.adjustBrightness(255 * _loc7_.brightness / 100);
            _loc11_ = new ColorMatrixFilter(_loc10_.matrix);
            _loc12_ = _loc9_.filters;
            _loc12_.push(_loc11_);
            _loc9_.filters = _loc12_;
            _loc13_ = AnimationBuilder.importMovieClip(30,_loc9_,param5,param6,1,"HopAnimationStart","HopAnimationEnd");
            _loc8_.addAnimation("PigeonHop",_loc13_);
            _loc14_ = AnimationBuilder.importMovieClip(30,_loc9_,param5,param6,1,"FlyAnimationStart","FlyAnimationEnd");
            _loc14_.isLooping = true;
            _loc8_.addAnimation("PigeonFly",_loc14_);
            _loc15_ = AnimationBuilder.importMovieClip(30,_loc9_,param5,param6,1,"LandingAnimationStart","LandingAnimationEnd");
            _loc15_.isLooping = true;
            _loc8_.addAnimation("PigeonLanding",_loc15_);
            _loc16_ = AnimationBuilder.importMovieClip(30,_loc9_,param5,param6,1,"IdleAnimationStart","IdleAnimationEnd");
            _loc16_.isLooping = true;
            _loc8_.addAnimation("PigeonIdle",_loc16_);
            _loc17_ = AnimationBuilder.importMovieClip(30,_loc9_,param5,param6,1,"PooAnimationStart","PooAnimationEnd");
            _loc8_.addAnimation("PigeonPoo",_loc17_);
            _loc18_ = AnimationBuilder.importMovieClip(30,_loc9_,param5,param6,1,"HitAnimationStart","HitAnimationEnd");
            _loc8_.addAnimation("PigeonHit",_loc18_);
            _loc19_ = AnimationBuilder.importMovieClip(30,_loc9_,param5,param6,1,"DeathAnimationStart","DeathAnimationEnd",0,6);
            _loc19_.isLooping = true;
            _loc8_.addAnimation("PigeonDeath",_loc19_);
            if(param4 == "BossRocky")
            {
               _loc20_ = AnimationBuilder.importMovieClip(30,_loc9_,param5,param6,1,"ThrowRockAnimationStart","ThrowRockAnimationEnd",0,6);
               _loc8_.addAnimation("PigeonThrowRock",_loc20_);
            }
            _loc8_.defaultAnimationID = "PigeonIdle";
            param1.register(_loc7_.id + param4 + "PigeonAnimations",_loc8_);
         }
      }
      
      public static function register(param1:AnimationPlayerFactory) : void
      {
         var _loc2_:Array = [];
         _loc2_.push(new PigeonColor());
         _loc2_.push(new PigeonColor("Brown",new ColorTransform(1,1,1,1,-3,-19,-39)));
         _loc2_.push(new PigeonColor("Black",new ColorTransform(1,1,1,1,-50,-50,-50)));
         var _loc3_:Array = [];
         _loc3_.push(new PigeonColor());
         var _loc4_:MovieClip = new Assets.PIGEON_ANIMATIONS();
         var _loc5_:MovieClip = new Assets.FAT_PIGEON_ANIMATIONS();
         var _loc6_:MovieClip = new Assets.SOLDIER_PIGEON_ANIMATIONS();
         var _loc7_:MovieClip = new Assets.CRAZY_PIGEON_ANIMATIONS();
         var _loc8_:MovieClip = new Assets.BOMBER_PIGEON_ANIMATIONS();
         var _loc9_:MovieClip = new Assets.BOSS_ROCKY_PIGEON_ANIMATIONS();
         var _loc10_:MovieClip = new Assets.BOSS_FAT_PIGEON_ANIMATIONS();
         var _loc11_:MovieClip = new Assets.BOSS_SOLDIER_PIGEON_ANIMATIONS();
         var _loc12_:MovieClip = new Assets.BOSS_CRAZY_PIGEON_ANIMATIONS();
         var _loc13_:MovieClip = new Assets.BOSS_BOMBER_PIGEON_ANIMATIONS();
         createPigeonAnimations(param1,_loc4_,_loc2_,"",70,58);
         createPigeonAnimations(param1,_loc5_,_loc2_,"Fat",90,80);
         createPigeonAnimations(param1,_loc6_,_loc2_,"Soldier",70,70);
         createPigeonAnimations(param1,_loc7_,_loc2_,"Crazy",70,65);
         createPigeonAnimations(param1,_loc8_,_loc2_,"Bomber",65,60);
         createPigeonAnimations(param1,_loc9_,_loc3_,"BossRocky",90,90);
         createPigeonAnimations(param1,_loc10_,_loc3_,"BossFat",90,90);
         createPigeonAnimations(param1,_loc11_,_loc3_,"BossSoldier",90,90);
         createPigeonAnimations(param1,_loc12_,_loc3_,"BossCrazy",110,100);
         createPigeonAnimations(param1,_loc13_,_loc3_,"BossBomber",90,90);
         var _loc14_:AnimationPlayer = new AnimationPlayer();
         var _loc15_:MovieClip = new Assets.POO_EXPLOSION_ANIMATIONS();
         var _loc16_:Animation = AnimationBuilder.importMovieClip(30,_loc15_,120,120,1,"GroundExplosionStart","GroundExplosionEnd",1,-50);
         _loc14_.addAnimation("GroundExplosion",_loc16_);
         var _loc17_:Animation = AnimationBuilder.importMovieClip(30,_loc15_,120,120,1,"AirExplosionStart","AirExplosionEnd",1,1);
         _loc14_.addAnimation("AirExplosion",_loc17_);
         _loc14_.defaultAnimationID = "GroundExplosion";
         param1.register("PooExplosionAnimations",_loc14_);
         var _loc18_:AnimationPlayer = new AnimationPlayer();
         var _loc19_:MovieClip = new Assets.PLAYER_ANIMATIONS();
         var _loc20_:Animation = AnimationBuilder.importMovieClip(30,_loc19_,90,100,1,"IdleAnimationStart","IdleAnimationEnd",1,-20);
         _loc20_.isLooping = true;
         _loc18_.addAnimation("PlayerIdle",_loc20_);
         var _loc21_:Animation = AnimationBuilder.importMovieClip(30,_loc19_,90,100,1,"WalkAnimationStart","WalkAnimationEnd",1,-20);
         _loc21_.isLooping = true;
         _loc18_.addAnimation("PlayerWalk",_loc21_);
         var _loc22_:Animation = AnimationBuilder.importMovieClip(30,_loc19_,90,100,1,"JumpAnimationStart","JumpAnimationEnd",1,-20);
         _loc18_.addAnimation("PlayerJump",_loc22_);
         var _loc23_:Animation = AnimationBuilder.importMovieClip(30,_loc19_,90,100,1,"HitAnimationStart","HitAnimationEnd",1,-20);
         _loc18_.addAnimation("PlayerHit",_loc23_);
         var _loc24_:Animation = AnimationBuilder.importMovieClip(30,_loc19_,90,100,1,"ThrowAnimationStart","ThrowAnimationEnd",1,-20);
         _loc18_.addAnimation("PlayerThrow",_loc24_);
         var _loc25_:Animation = AnimationBuilder.importMovieClip(30,_loc19_,90,100,1,"SwingAnimationStart","SwingAnimationEnd",1,-20);
         _loc18_.addAnimation("PlayerSwing",_loc25_);
         var _loc26_:Animation = AnimationBuilder.importMovieClip(30,_loc19_,90,100,1,"DeathAnimationStart","DeathAnimationEnd",1,-20);
         _loc26_.isPausedOnLastFrame = true;
         _loc18_.addAnimation("PlayerDeath",_loc26_);
         var _loc27_:Animation = AnimationBuilder.importMovieClip(30,_loc19_,90,100,1,"WipeFaceAnimationStart","WipeFaceAnimationEnd",1,-20);
         _loc18_.addAnimation("PlayerWipeFace",_loc27_);
         _loc18_.defaultAnimationID = "PlayerIdle";
         param1.register("PlayerAnimations",_loc18_);
         var _loc28_:AnimationPlayer = new AnimationPlayer();
         var _loc29_:MovieClip = new Assets.BROOM_ANIMATIONS();
         var _loc30_:Number = _loc29_.width * 2;
         var _loc31_:Animation = AnimationBuilder.importMovieClip(1,_loc29_,_loc30_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc28_.addAnimation("BroomIdle",_loc31_);
         _loc28_.defaultAnimationID = "BroomIdle";
         param1.register("BroomAnimations",_loc28_);
         var _loc32_:AnimationPlayer = new AnimationPlayer();
         var _loc33_:MovieClip = new Assets.NEWSPAPER_ANIMATIONS();
         var _loc34_:Number = _loc33_.width * 2;
         var _loc35_:Animation = AnimationBuilder.importMovieClip(1,_loc33_,_loc34_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc32_.addAnimation("NewspaperIdle",_loc35_);
         _loc32_.defaultAnimationID = "NewspaperIdle";
         param1.register("NewspaperAnimations",_loc32_);
         var _loc36_:AnimationPlayer = new AnimationPlayer();
         var _loc37_:MovieClip = new Assets.POOL_STICK_ANIMATIONS();
         var _loc38_:Number = _loc37_.width * 2;
         var _loc39_:Animation = AnimationBuilder.importMovieClip(1,_loc37_,_loc38_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc36_.addAnimation("PoolStickIdle",_loc39_);
         _loc36_.defaultAnimationID = "PoolStickIdle";
         param1.register("PoolStickAnimations",_loc36_);
         var _loc40_:AnimationPlayer = new AnimationPlayer();
         var _loc41_:MovieClip = new Assets.BASEBALL_BAT_ANIMATIONS();
         var _loc42_:Number = _loc41_.width * 2;
         var _loc43_:Animation = AnimationBuilder.importMovieClip(1,_loc41_,_loc42_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc40_.addAnimation("BaseballBatIdle",_loc43_);
         _loc40_.defaultAnimationID = "BaseballBatIdle";
         param1.register("BaseballBatAnimations",_loc40_);
         var _loc44_:AnimationPlayer = new AnimationPlayer();
         var _loc45_:MovieClip = new Assets.GOLF_CLUB_ANIMATIONS();
         var _loc46_:Number = _loc45_.width * 2;
         var _loc47_:Animation = AnimationBuilder.importMovieClip(1,_loc45_,_loc46_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc44_.addAnimation("GolfClubIdle",_loc47_);
         _loc44_.defaultAnimationID = "GolfClubIdle";
         param1.register("GolfClubAnimations",_loc44_);
         var _loc48_:AnimationPlayer = new AnimationPlayer();
         var _loc49_:MovieClip = new Assets.RAKE_ANIMATIONS();
         var _loc50_:Number = _loc49_.width * 2;
         var _loc51_:Animation = AnimationBuilder.importMovieClip(1,_loc49_,_loc50_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc48_.addAnimation("RakeIdle",_loc51_);
         _loc48_.defaultAnimationID = "RakeIdle";
         param1.register("RakeAnimations",_loc48_);
         var _loc52_:AnimationPlayer = new AnimationPlayer();
         var _loc53_:MovieClip = new Assets.MOP_ANIMATIONS();
         var _loc54_:Number = _loc53_.width * 2;
         var _loc55_:Animation = AnimationBuilder.importMovieClip(1,_loc53_,_loc54_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc52_.addAnimation("MopIdle",_loc55_);
         _loc52_.defaultAnimationID = "MopIdle";
         param1.register("MopAnimations",_loc52_);
         var _loc56_:AnimationPlayer = new AnimationPlayer();
         var _loc57_:MovieClip = new Assets.SHOVEL_ANIMATIONS();
         var _loc58_:Number = _loc57_.width * 2;
         var _loc59_:Animation = AnimationBuilder.importMovieClip(1,_loc57_,_loc58_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc56_.addAnimation("ShovelIdle",_loc59_);
         _loc56_.defaultAnimationID = "ShovelIdle";
         param1.register("ShovelAnimations",_loc56_);
         var _loc60_:AnimationPlayer = new AnimationPlayer();
         var _loc61_:MovieClip = new Assets.NUMCHUCK_ANIMATIONS();
         var _loc62_:Number = _loc61_.width * 2;
         var _loc63_:Animation = AnimationBuilder.importMovieClip(1,_loc61_,_loc62_,0,1,"IdleAnimationStart","IdleAnimationEnd",0,2);
         _loc60_.addAnimation("NumchuckIdle",_loc63_);
         _loc60_.defaultAnimationID = "NumchuckIdle";
         param1.register("NumchuckAnimations",_loc60_);
      }
   }
}

