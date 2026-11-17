package com.getoffmyroof.weapons
{
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.getoffmyroof.rendering.MeleeWeaponRenderer;
   import com.getoffmyroof.settings.Layers;
   import com.getoffmyroof.weapons.abilities.NumchuckAbility;
   import com.getoffmyroof.weapons.abilities.ShovelAbility;
   import com.urbansquall.ginger.tools.AnimationPlayerFactory;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.melee.MeleeWeapon;
   import com.whatthefawk.weapons.melee.MeleeWeaponFactory;
   import com.whatthefawk.weapons.melee.MeleeWeaponParams;
   
   public class MeleeWeaponTypes
   {
      
      public function MeleeWeaponTypes()
      {
         super();
      }
      
      public static function register(param1:MeleeWeaponFactory, param2:AnimationPlayerFactory = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:MeleeWeaponParams = null;
         _loc3_ = 1000;
         _loc4_ = 30;
         _loc5_ = 13;
         _loc6_ = 10;
         _loc7_ = 7;
         _loc8_ = new MeleeWeaponParams();
         _loc8_.type = "Newspaper";
         _loc8_.layer = Layers.WEAPON;
         _loc8_.radius = 60;
         _loc8_.lengthMax = 60;
         _loc8_.startAngle = -180;
         _loc8_.endAngle = 0;
         _loc8_.originOffset = new Vector2D(0,-28);
         _loc8_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc8_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc8_.attackForce = _loc3_;
         _loc8_.swingRate = _loc4_;
         _loc8_.swingDistPerTick = _loc6_;
         _loc8_.customClass = MeleeWeapon;
         _loc8_.rendererClass = MeleeWeaponRenderer;
         _loc8_.rendererData = {
            "animationPlayer":param2.instantiate("NewspaperAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc8_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         param1.registerWeapon(_loc8_);
         var _loc9_:MeleeWeaponParams = new MeleeWeaponParams();
         _loc9_.type = "Broom";
         _loc9_.layer = Layers.WEAPON;
         _loc9_.radius = 120;
         _loc9_.lengthMax = 120;
         _loc9_.startAngle = -180;
         _loc9_.endAngle = 0;
         _loc9_.originOffset = new Vector2D(0,-5);
         _loc9_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc9_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc9_.attackForce = _loc3_;
         _loc9_.swingRate = _loc4_;
         _loc9_.swingDistPerTick = _loc6_;
         _loc9_.customClass = MeleeWeapon;
         _loc9_.rendererClass = MeleeWeaponRenderer;
         _loc9_.rendererData = {
            "animationPlayer":param2.instantiate("BroomAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc9_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         param1.registerWeapon(_loc9_);
         var _loc10_:MeleeWeaponParams = new MeleeWeaponParams();
         _loc10_.type = "GolfClub";
         _loc10_.layer = Layers.WEAPON;
         _loc10_.radius = 110;
         _loc10_.lengthMax = 110;
         _loc10_.startAngle = -180;
         _loc10_.endAngle = 0;
         _loc10_.originOffset = new Vector2D(0,-5);
         _loc10_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc10_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc10_.attackForce = _loc3_;
         _loc10_.swingRate = _loc4_;
         _loc10_.swingDistPerTick = _loc6_;
         _loc10_.customClass = MeleeWeapon;
         _loc10_.rendererClass = MeleeWeaponRenderer;
         _loc10_.rendererData = {
            "animationPlayer":param2.instantiate("GolfClubAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc10_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":2,
            "scare":1
         });
         param1.registerWeapon(_loc10_);
         var _loc11_:MeleeWeaponParams = new MeleeWeaponParams();
         _loc11_.type = "BaseballBat";
         _loc11_.layer = Layers.WEAPON;
         _loc11_.radius = 90;
         _loc11_.lengthMax = 90;
         _loc11_.startAngle = -180;
         _loc11_.endAngle = 0;
         _loc11_.originOffset = new Vector2D(0,-5);
         _loc11_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc11_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc11_.attackForce = _loc3_;
         _loc11_.swingRate = _loc4_;
         _loc11_.swingDistPerTick = _loc6_;
         _loc11_.customClass = MeleeWeapon;
         _loc11_.rendererClass = MeleeWeaponRenderer;
         _loc11_.rendererData = {
            "animationPlayer":param2.instantiate("BaseballBatAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc11_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":3,
            "scare":1
         });
         param1.registerWeapon(_loc11_);
         var _loc12_:MeleeWeaponParams = new MeleeWeaponParams();
         _loc12_.type = "PoolStick";
         _loc12_.layer = Layers.WEAPON;
         _loc12_.radius = 160;
         _loc12_.lengthMax = 160;
         _loc12_.startAngle = -180;
         _loc12_.endAngle = 0;
         _loc12_.originOffset = new Vector2D(0,-5);
         _loc12_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc12_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc12_.attackForce = _loc3_;
         _loc12_.swingRate = _loc4_;
         _loc12_.swingDistPerTick = _loc7_;
         _loc12_.customClass = MeleeWeapon;
         _loc12_.rendererClass = MeleeWeaponRenderer;
         _loc12_.rendererData = {
            "animationPlayer":param2.instantiate("PoolStickAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc12_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         param1.registerWeapon(_loc12_);
         var _loc13_:MeleeWeaponParams = new MeleeWeaponParams();
         _loc13_.type = "Rake";
         _loc13_.layer = Layers.WEAPON;
         _loc13_.radius = 100;
         _loc13_.lengthMax = 100;
         _loc13_.startAngle = -180;
         _loc13_.endAngle = 0;
         _loc13_.originOffset = new Vector2D(0,-5);
         _loc13_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc13_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc13_.attackForce = _loc3_;
         _loc13_.swingRate = _loc4_;
         _loc13_.swingDistPerTick = _loc7_;
         _loc13_.bulbRadius = 20;
         _loc13_.customClass = MeleeWeapon;
         _loc13_.rendererClass = MeleeWeaponRenderer;
         _loc13_.rendererData = {
            "animationPlayer":param2.instantiate("RakeAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc13_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         param1.registerWeapon(_loc13_);
         var _loc14_:MeleeWeaponParams = new MeleeWeaponParams();
         _loc14_.type = "Mop";
         _loc14_.layer = Layers.WEAPON;
         _loc14_.radius = 120;
         _loc14_.lengthMax = 120;
         _loc14_.startAngle = -180;
         _loc14_.endAngle = 0;
         _loc14_.originOffset = new Vector2D(0,-5);
         _loc14_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc14_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc14_.attackForce = _loc3_;
         _loc14_.swingRate = _loc4_;
         _loc14_.swingDistPerTick = _loc7_;
         _loc14_.customClass = MeleeWeapon;
         _loc14_.rendererClass = MeleeWeaponRenderer;
         _loc14_.rendererData = {
            "animationPlayer":param2.instantiate("MopAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc14_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1,
            "wetness":4
         });
         param1.registerWeapon(_loc14_);
         var _loc15_:MeleeWeaponParams = new MeleeWeaponParams();
         _loc15_.type = "Shovel";
         _loc15_.layer = Layers.WEAPON;
         _loc15_.radius = 120;
         _loc15_.lengthMax = 120;
         _loc15_.startAngle = -180;
         _loc15_.endAngle = 0;
         _loc15_.originOffset = new Vector2D(0,-5);
         _loc15_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc15_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc15_.attackForce = _loc3_;
         _loc15_.swingRate = _loc4_;
         _loc15_.swingDistPerTick = _loc7_;
         _loc13_.bulbRadius = 10;
         _loc15_.weaponAbility = new ShovelAbility();
         _loc15_.customClass = MeleeWeapon;
         _loc15_.rendererClass = MeleeWeaponRenderer;
         _loc15_.rendererData = {
            "animationPlayer":param2.instantiate("ShovelAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc15_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":4,
            "scare":1
         });
         param1.registerWeapon(_loc15_);
         var _loc16_:MeleeWeaponParams = new MeleeWeaponParams();
         _loc16_.type = "Numchucks";
         _loc16_.layer = Layers.WEAPON;
         _loc16_.radius = 90;
         _loc16_.lengthMax = 90;
         _loc16_.startAngle = -180;
         _loc16_.endAngle = 0;
         _loc16_.originOffset = new Vector2D(0,-5);
         _loc16_.swingStyle = MeleeWeapon.SWING_RIGHT;
         _loc16_.attackStyle = MeleeWeapon.SINGLE_ATTACK;
         _loc16_.attackForce = _loc3_;
         _loc16_.swingRate = _loc4_;
         _loc16_.swingDistPerTick = _loc5_;
         _loc16_.weaponAbility = new NumchuckAbility();
         _loc16_.customClass = MeleeWeapon;
         _loc16_.rendererClass = MeleeWeaponRenderer;
         _loc16_.rendererData = {
            "animationPlayer":param2.instantiate("NumchuckAnimations"),
            "isRadiusVisible":false,
            "isBoundsVisuble":false
         };
         _loc16_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":4,
            "scare":1
         });
         param1.registerWeapon(_loc16_);
      }
   }
}

