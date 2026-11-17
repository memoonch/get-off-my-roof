package com.whatthefawk.weapons.melee
{
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.whatthefawk.entity.Boid;
   import com.whatthefawk.entity.MovingEntityParams;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.IWeaponAbility;
   
   public class MeleeWeaponParams extends MovingEntityParams
   {
      
      public var stabRate:int = 0;
      
      public var attackForce:int = 500;
      
      public var agent:Boid;
      
      public var canAttack:Boolean;
      
      public var attackStyle:String = MeleeWeapon.COMBO_ATTACK;
      
      public var isEnabled:Boolean;
      
      public var startAngle:int = -90;
      
      public var swingStyle:String;
      
      public var swingRate:int = 5;
      
      public var attackDirection:Vector2D = new Vector2D(0,-1);
      
      public var target:Vector2D;
      
      public var originOffset:Vector2D = new Vector2D();
      
      public var lengthMax:int = 100;
      
      public var afterAttackDelay:int = 200;
      
      public var isAttacking:Boolean;
      
      public var autoFinishAttack:Boolean = true;
      
      public var weaponAbility:IWeaponAbility;
      
      public var swingDistPerTick:int = 20;
      
      public var endAngle:int = 90;
      
      public var stabDistPerTick:int = 0;
      
      public var bulbRadius:int = 0;
      
      public var onHitStatEffectParams:OnHitStatEffectParams;
      
      public function MeleeWeaponParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

