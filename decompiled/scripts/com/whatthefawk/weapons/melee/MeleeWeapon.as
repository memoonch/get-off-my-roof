package com.whatthefawk.weapons.melee
{
   import com.getoffmyroof.entity.Pigeon;
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffect;
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.whatthefawk.entity.Boid;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.life.stats.StatEffect;
   import com.whatthefawk.math.Geometry;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.IHittable;
   import com.whatthefawk.weapons.IWeaponAbility;
   
   public class MeleeWeapon extends MovingEntity implements IHittable
   {
      
      public static const SINGLE_ATTACK:String = "SingleFire";
      
      public static const AUTOMATIC_ATTACK:String = "AutomaticFire";
      
      public static const CHARGED_ATTACK:String = "ChargedFire";
      
      public static const HIT_BY_MELEE:String = "hit_by_melee";
      
      public static const STAB_ATTACK:String = "stabAttack";
      
      public static const SWING_ATTACK:String = "swingAttack";
      
      public static const COMBO_ATTACK:String = "comboAttack";
      
      public static const SWING_LEFT:String = "SwingLeft";
      
      public static const SWING_RIGHT:String = "SwingRight";
      
      public static const SWING_RANDOM:String = "SwingRandom";
      
      public static const SWING_BACK_AND_FORTH:String = "SwingBackAndForth";
      
      public static const ATTACK_UP:String = "AttackUp";
      
      public static const ATTACK_DOWN:String = "AttackDown";
      
      public static const ATTACK_LEFT:String = "AttackLeft";
      
      public static const ATTACK_RIGHT:String = "AttackRight";
      
      public static const ATTACK_TARGET:String = "AttackTarget";
      
      public static const ATTACK_AT_HEADING:String = "AttackAtHeading";
      
      public static const ATTACK_IN_DIRECTION:String = "AttackInDirection";
      
      private var m_swingDistPerTick:int;
      
      private var m_bulbRadius:int;
      
      private var m_swingTime:int;
      
      private var m_autoFinishAttack:Boolean;
      
      private var m_target:Vector2D;
      
      private var m_startAngle:int;
      
      private var m_weaponAbility:IWeaponAbility;
      
      private var m_swingRate:int;
      
      private var m_targets:Array;
      
      private var m_afterAttackDelay:int;
      
      private var m_agent:Boid;
      
      private var m_attackForce:int;
      
      private var m_isAttacking:Boolean;
      
      private var m_stabTime:int;
      
      private var m_attackDirection:Vector2D;
      
      private var m_attackTime:int;
      
      private var m_tip:Vector2D;
      
      private var m_type:String;
      
      private var m_endAngle:int;
      
      private var m_lengthMax:int;
      
      private var m_stabRate:int;
      
      private var m_canFire:Boolean;
      
      private var m_swingStyle:String;
      
      private var m_stabDistPerTick:int;
      
      private var m_originOffset:Vector2D;
      
      private var m_currentAngle:Vector2D;
      
      private var m_onHitStatEffectParams:OnHitStatEffectParams;
      
      private var m_isEnabled:Boolean;
      
      private var m_isStabComplete:Boolean;
      
      private var m_length:int;
      
      private var m_isSwingComplete:Boolean;
      
      private var m_attackStyle:String;
      
      public function MeleeWeapon(param1:MeleeWeaponParams = null)
      {
         super(param1);
         this.m_agent = param1.agent;
         this.m_target = param1.target;
         this.m_onHitStatEffectParams = param1.onHitStatEffectParams;
         this.m_type = param1.type;
         this.m_tip = new Vector2D();
         this.m_lengthMax = param1.lengthMax;
         this.m_startAngle = param1.startAngle;
         this.m_endAngle = param1.endAngle;
         this.m_originOffset = param1.originOffset;
         this.m_attackTime = 0;
         this.m_attackForce = param1.attackForce;
         this.m_attackStyle = param1.attackStyle;
         this.m_attackDirection = param1.attackDirection;
         this.m_afterAttackDelay = param1.afterAttackDelay;
         this.m_autoFinishAttack = param1.autoFinishAttack;
         this.m_stabTime = 0;
         this.m_stabRate = param1.stabRate;
         this.m_stabDistPerTick = param1.stabDistPerTick;
         this.m_isStabComplete = true;
         this.m_swingTime = 0;
         this.m_swingRate = param1.swingRate;
         this.m_swingStyle = param1.swingStyle;
         this.m_swingDistPerTick = param1.swingDistPerTick;
         this.m_isSwingComplete = true;
         this.m_bulbRadius = param1.bulbRadius;
         this.m_weaponAbility = param1.weaponAbility;
         this.m_canFire = true;
         this.m_isEnabled = true;
         this.m_isAttacking = false;
         this.reset();
      }
      
      public function deactivate() : void
      {
         if(!this.m_autoFinishAttack)
         {
            this.reset();
         }
      }
      
      private function swing() : void
      {
         this.m_currentAngle.rotate(this.m_swingDistPerTick);
         var _loc1_:Number = this.m_currentAngle.toDegrees();
         if(_loc1_ >= this.m_endAngle)
         {
            this.m_currentAngle = Vector2D.degreesToVector(this.m_endAngle);
            this.m_isSwingComplete = true;
         }
         if(this.m_swingRate == 0)
         {
            this.m_currentAngle = this.m_attackDirection;
            this.m_isSwingComplete = true;
         }
         this.m_tip = this.m_currentAngle.multipliedBy(this.m_length);
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         newPos.x = this.m_agent.currentPos.x + this.m_originOffset.x;
         newPos.y = this.m_agent.currentPos.y + this.m_originOffset.y;
         if(!this.m_isStabComplete)
         {
            this.m_stabTime += param1;
            if(this.m_stabTime >= this.m_stabRate)
            {
               this.m_stabTime -= this.m_stabRate;
               this.stab();
            }
         }
         if(!this.m_isSwingComplete)
         {
            this.m_swingTime += param1;
            if(this.m_swingTime >= this.m_swingRate)
            {
               this.m_swingTime -= this.m_swingRate;
               this.swing();
            }
         }
         if(this.m_isStabComplete && this.m_isSwingComplete)
         {
            this.m_isAttacking = false;
         }
         if(!this.m_isAttacking && !this.m_canFire)
         {
            this.m_attackTime += param1;
            if(this.m_attackTime >= this.m_afterAttackDelay)
            {
               this.m_attackTime -= this.m_afterAttackDelay;
               this.m_canFire = true;
               this.reset();
            }
         }
         if(!this.m_isStabComplete || !this.m_isSwingComplete)
         {
            this.checkForImpact();
         }
      }
      
      public function get length() : int
      {
         return this.m_length;
      }
      
      public function get isAttacking() : Boolean
      {
         return this.m_isAttacking;
      }
      
      public function get tip() : Vector2D
      {
         return this.m_tip;
      }
      
      public function get bulbRadius() : int
      {
         return this.m_bulbRadius;
      }
      
      public function get lengthMax() : int
      {
         return this.m_lengthMax;
      }
      
      public function get canFire() : Boolean
      {
         return this.m_canFire;
      }
      
      private function stab() : void
      {
         this.m_length += this.m_stabDistPerTick;
         if(this.m_length >= this.m_lengthMax || this.m_stabRate == 0)
         {
            this.m_length = this.m_lengthMax;
            this.m_isStabComplete = true;
         }
         this.m_tip = this.m_currentAngle.multipliedBy(this.m_length);
      }
      
      public function setAgent(param1:Boid) : void
      {
         this.m_agent = param1;
      }
      
      private function checkForImpact() : void
      {
         var _loc3_:MovingEntity = null;
         var _loc4_:Vector2D = null;
         var _loc5_:Vector2D = null;
         var _loc1_:Array = this.m_agent.parent.getChildren(Pigeon);
         var _loc2_:int = int(_loc1_.length);
         while(--_loc2_ > -1)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = this.m_tip.addedTo(this.m_agent.currentPos);
            _loc5_ = this.m_tip.normalized();
            if(Geometry.isCircleOverlappingSegment(this.m_agent.currentPos,_loc4_,_loc3_.currentPos,_loc3_.radius))
            {
               messageDispatcher.dispatchMessage(0,this.m_agent.id,_loc3_.id,MeleeWeapon.HIT_BY_MELEE,{
                  "weaponForce":_loc5_.times(this.m_attackForce),
                  "weaponHeading":_loc5_,
                  "onHitStatEffect":this.onHitStatEffect
               });
            }
            if(this.m_bulbRadius > 0)
            {
               if(Geometry.isCircleOverlapping(_loc4_,this.m_bulbRadius,_loc3_.currentPos,_loc3_.radius))
               {
                  messageDispatcher.dispatchMessage(0,this.m_agent.id,_loc3_.id,MeleeWeapon.HIT_BY_MELEE,{
                     "weaponForce":_loc5_.times(this.m_attackForce),
                     "weaponHeading":_loc5_,
                     "onHitStatEffect":this.onHitStatEffect
                  });
               }
            }
         }
      }
      
      public function getAgent() : *
      {
         return this.m_agent;
      }
      
      public function applyAbility() : void
      {
         if(this.m_weaponAbility)
         {
            this.m_weaponAbility.applyTo(this.m_agent);
         }
      }
      
      private function reset() : *
      {
         this.m_tip.zero();
         this.m_length = 0;
         this.m_currentAngle = this.m_attackDirection.copy();
         if(Boolean(this.m_swingRate) && Boolean(this.m_startAngle))
         {
            this.m_currentAngle = Vector2D.degreesToVector(this.m_startAngle);
         }
         this.m_stabTime = 0;
         this.m_swingTime = 0;
         this.m_isStabComplete = true;
         this.m_isSwingComplete = true;
         this.m_isAttacking = false;
      }
      
      public function get currentAngle() : Vector2D
      {
         return this.m_currentAngle;
      }
      
      public function get onHitStatEffect() : StatEffect
      {
         return new OnHitStatEffect(this.m_onHitStatEffectParams);
      }
      
      public function activate() : void
      {
         if(this.m_canFire)
         {
            this.reset();
            this.m_tip = this.m_currentAngle.normalize().multipliedBy(this.m_length);
            this.m_isStabComplete = false;
            this.m_isSwingComplete = false;
            this.m_canFire = false;
            this.m_isAttacking = true;
         }
      }
   }
}

