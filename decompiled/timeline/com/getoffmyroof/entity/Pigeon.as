package com.getoffmyroof.entity
{
   import com.getoffmyroof.ai.states.BasicPigeonGlobalState;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.particleEffects.FeatherBlastEffect;
   import com.getoffmyroof.particleEffects.FeatherBlastEffectParams;
   import com.getoffmyroof.points.Points;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.whatthefawk.ai.steering.path.Path;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.collision.bounds.BoundsBehaviorParams;
   import com.whatthefawk.collision.bounds.RemoveBoundsBehavior;
   import com.whatthefawk.display.DisplayManager;
   import com.whatthefawk.entity.Boid;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.entity.Wall;
   import com.whatthefawk.life.Life;
   import com.whatthefawk.life.LifeEvent;
   import com.whatthefawk.life.LifeParams;
   import com.whatthefawk.life.stats.Stat;
   import com.whatthefawk.life.stats.StatEffect;
   import com.whatthefawk.life.stats.StatEffectParams;
   import com.whatthefawk.life.stats.StatParams;
   import com.whatthefawk.life.stats.Stats;
   import com.whatthefawk.life.stats.StatsParams;
   import com.whatthefawk.life.stats.statEffects.InvincibilityStatEffect;
   import com.whatthefawk.math.Chance;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.particleEffects.ParticleEffectDisplay;
   import com.whatthefawk.utils.TickRegulator;
   import com.whatthefawk.weapons.WeaponSystem;
   import flash.events.Event;
   
   public class Pigeon extends Boid
   {
      
      public static const GOLD:uint = 16504401;
      
      public static const GREY:uint = 12303291;
      
      public static const BLACK:uint = 5592405;
      
      public static const BROWN:uint = 9792303;
      
      public static const HOP_LEFT:int = -1;
      
      public static const HOP_RIGHT:int = 1;
      
      public static const HOP_RANDOM:int = 0;
      
      private var m_numFeathers:int;
      
      private var m_roofEdgePanicDistance:int;
      
      public var roofGroup:RoofGroup;
      
      private var m_pointSystem:Points;
      
      private var m_evadeDistanceLossOnScare:int;
      
      private var m_hopForceMax:Vector2D;
      
      private var m_landGravity:int;
      
      private var m_evadeDistance:int;
      
      private var m_flyTime:int;
      
      private var m_landChance:Chance;
      
      private var m_featherColor:uint;
      
      private var m_dodgeChance:Chance;
      
      private var m_attackHeight:int;
      
      private var m_evadeDistanceRegenRate:int;
      
      private var m_attackChance:Chance;
      
      private var m_evadeDistanceTickRegulator:TickRegulator;
      
      private var m_flyChance:Chance;
      
      private var m_avoidChance:Chance;
      
      private var m_avoidDistance:int;
      
      private var m_isLanding:Boolean;
      
      private var m_evadeDistanceRegenAmount:int;
      
      private var m_defaultEvadeDistance:int;
      
      private var m_roofEdgePanicChance:Chance;
      
      private var m_panicDistance:int;
      
      private var m_isInAir:Boolean;
      
      private var m_pooChance:Chance;
      
      private var m_lifeSystem:Life;
      
      private var m_flyAttackDistance:int;
      
      private var m_flyTimeMin:int;
      
      private var m_attackDistance:int;
      
      private var m_scareChance:Chance;
      
      private var m_dryAmountPerTick:int;
      
      private var m_isWet:Boolean;
      
      private var m_dryTickRegulator:TickRegulator;
      
      private var m_audioManager:AudioManager;
      
      public var target:MovingEntity;
      
      private var m_hopChance:Chance;
      
      private var m_flyEvadeForce:Vector2D;
      
      private var m_displayManager:DisplayManager;
      
      private var m_evadeDistanceMin:int;
      
      private var m_avoidGroundDistance:int;
      
      private var m_isEvadeDistanceResetOnLand:Boolean;
      
      private var m_chaseDistance:int;
      
      private var m_hasLanded:Boolean;
      
      private var m_hopForce:Vector2D;
      
      private var m_statSystem:Stats;
      
      private var m_particleEffectDisplay:ParticleEffectDisplay;
      
      private var m_isAttacking:Boolean;
      
      private var m_isFlyTimeUp:Boolean;
      
      private var m_panicChance:Chance;
      
      private var m_scareDistance:int;
      
      private var m_onDeathSound:String;
      
      private var m_isDead:Boolean;
      
      private var m_rewardSystem:RewardSystem;
      
      private var m_defaultMaxSpeed:int;
      
      private var m_minFeathers:int;
      
      private var m_currentPerch:Wall;
      
      private var m_flyAttackChance:Chance;
      
      private var m_hopGravity:int;
      
      private var m_isFlying:Boolean;
      
      private var m_chaseChance:Chance;
      
      private var m_flyScareDistance:int;
      
      private var m_weaponSystem:WeaponSystem;
      
      public function Pigeon(param1:PigeonParams)
      {
         super(param1);
         this.m_audioManager = GameComponents.instance.getAudioManager();
         this.m_displayManager = GameComponents.instance.getDisplayManager();
         this.m_rewardSystem = GameComponents.instance.getComponent("RewardSystem");
         this.m_minFeathers = param1.minFeathers;
         this.m_numFeathers = param1.numFeathers;
         this.m_featherColor = param1.featherColor;
         this.m_pointSystem = new Points(param1.pointsParams);
         this.m_statSystem = new Stats(new StatsParams({"initialStats":[new StatParams({
            "id":"resist",
            "name":"Resist",
            "value":param1.resist,
            "maxValue":10
         }),new StatParams({
            "id":"flyResist",
            "name":"Fly Resist",
            "value":param1.flyResist,
            "maxValue":10
         }),new StatParams({
            "id":"wetness",
            "name":"Wetness",
            "value":0,
            "maxValue":10
         })]}));
         this.m_lifeSystem = new Life(new LifeParams({
            "stats":this.m_statSystem,
            "maxLife":param1.health
         }));
         this.m_lifeSystem.addEventListener(LifeEvent.DEAD,this.onLifeDead,false,0,true);
         this.m_weaponSystem = new WeaponSystem(this);
         this.m_flyEvadeForce = param1.flyEvadeForce;
         this.m_hopForce = param1.hopForce;
         this.m_hopForceMax = param1.hopForceMax;
         this.m_hopGravity = param1.hopGravity;
         this.m_landGravity = param1.landGravity;
         this.m_defaultMaxSpeed = param1.maxSpeed;
         this.m_dryAmountPerTick = 1;
         this.m_dryTickRegulator = new TickRegulator();
         this.m_dryTickRegulator.addEventListener(TickRegulator.TICK,this.onDryTick,false,0,true);
         this.m_pooChance = param1.pooChance;
         this.m_hopChance = param1.hopChance;
         this.m_flyChance = param1.flyChance;
         this.m_landChance = param1.landChance;
         this.m_dodgeChance = param1.dodgeChance;
         this.m_avoidChance = param1.avoidChance;
         this.m_chaseChance = param1.chaseChance;
         this.m_panicChance = param1.panicChance;
         this.m_scareChance = param1.scareChance;
         this.m_attackChance = param1.attackChance;
         this.m_flyAttackChance = param1.flyAttackChance;
         this.m_roofEdgePanicChance = param1.roofEdgePanicChance;
         this.m_scareDistance = param1.scareDistance;
         this.m_flyScareDistance = param1.flyScareDistance;
         this.m_chaseDistance = param1.chaseDistance;
         this.m_panicDistance = param1.panicDistance;
         this.m_evadeDistance = param1.evadeDistance;
         this.m_avoidDistance = param1.avoidDistance;
         this.m_attackDistance = param1.attackDistance;
         this.m_flyAttackDistance = param1.flyAttackDistance;
         this.m_avoidGroundDistance = param1.avoidGroundDistance;
         this.m_roofEdgePanicDistance = param1.roofEdgePanicDistance;
         this.m_attackHeight = param1.attackHeight;
         this.m_defaultEvadeDistance = this.m_evadeDistance;
         this.m_evadeDistanceMin = param1.evadeDistanceMin;
         this.m_evadeDistanceRegenRate = param1.evadeDistanceRegenRate;
         this.m_evadeDistanceRegenAmount = param1.evadeDistanceRegenAmount;
         this.m_evadeDistanceLossOnScare = param1.evadeDistanceLossOnScare;
         this.m_isEvadeDistanceResetOnLand = param1.isEvadeDistanceResetOnLand;
         this.m_evadeDistanceTickRegulator = new TickRegulator(this.m_evadeDistanceRegenRate);
         this.m_evadeDistanceTickRegulator.addEventListener(TickRegulator.TICK,this.onEvadeDistanceTimerTick,false,0,true);
         this.m_flyTime = 0;
         this.m_flyTimeMin = param1.flyTimeMin;
         this.m_onDeathSound = param1.onDeathSound;
         this.m_isWet = false;
         this.m_isDead = false;
         this.m_isInAir = true;
         this.m_isFlying = true;
         this.m_isLanding = true;
         this.m_isAttacking = false;
         this.m_isFlyTimeUp = false;
         this.m_hasLanded = false;
         state.changeGlobalState(new BasicPigeonGlobalState());
         this.initFlyPaths(param1.flyPaths);
      }
      
      public function get hasLanded() : Boolean
      {
         return this.m_hasLanded;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_audioManager = null;
         this.m_displayManager = null;
         this.m_particleEffectDisplay = null;
         this.m_statSystem = null;
         this.m_lifeSystem = null;
         this.m_pointSystem = null;
         this.m_rewardSystem = null;
         this.m_weaponSystem = null;
         this.target = null;
         this.roofGroup = null;
         this.m_currentPerch = null;
         this.m_flyEvadeForce = null;
         this.m_hopForce = null;
         this.m_hopForceMax = null;
         this.m_hopForce = null;
         this.m_hopForceMax = null;
         this.m_pooChance = null;
         this.m_hopChance = null;
         this.m_flyChance = null;
         this.m_landChance = null;
         this.m_dodgeChance = null;
         this.m_avoidChance = null;
         this.m_chaseChance = null;
         this.m_panicChance = null;
         this.m_scareChance = null;
         this.m_attackChance = null;
         this.m_flyAttackChance = null;
         this.m_roofEdgePanicChance = null;
         this.m_dryTickRegulator.removeEventListener(TickRegulator.TICK,this.onDryTick);
         this.m_evadeDistanceTickRegulator.removeEventListener(TickRegulator.TICK,this.onEvadeDistanceTimerTick);
         this.m_dryTickRegulator = null;
         this.m_evadeDistanceTickRegulator = null;
      }
      
      public function scare() : void
      {
         this.m_evadeDistance -= this.m_evadeDistanceLossOnScare;
         if(this.m_evadeDistance < this.m_evadeDistanceMin)
         {
            this.m_evadeDistance = this.m_evadeDistanceMin;
         }
      }
      
      public function jump(param1:*) : void
      {
         if(!this.m_isInAir)
         {
            applyForce(param1);
            this.m_isInAir = true;
            addConstantForce(new Vector2D(0,this.m_hopGravity),"gravity");
            dispatchEvent(new PigeonEvent(PigeonEvent.JUMP));
         }
      }
      
      public function get roofEdgePanicChance() : Chance
      {
         return this.m_roofEdgePanicChance;
      }
      
      public function get lifeSystem() : Life
      {
         return this.m_lifeSystem;
      }
      
      public function set isAttacking(param1:Boolean) : void
      {
         this.m_isAttacking = param1;
      }
      
      public function get currentPerch() : Wall
      {
         return this.m_currentPerch;
      }
      
      public function attack(param1:String = null) : void
      {
         if(this.m_weaponSystem.canFireCurrentWeapon())
         {
            this.m_isAttacking = true;
            this.m_weaponSystem.activateCurrentWeapon();
            dispatchEvent(new PigeonEvent(PigeonEvent.ATTACK,{"animationID":this.m_weaponSystem.currentWeaponID}));
         }
      }
      
      public function hop(param1:int = 0) : void
      {
         var _loc3_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc2_:int = param1 == 0 ? (Math.random() < 0.5 ? -1 : 1) : param1;
         var _loc4_:Number = this.m_hopForce.x;
         _loc4_ = _loc4_ + Math.random() * (this.m_hopForceMax.x - this.m_hopForce.x);
         _loc4_ = _loc4_ * _loc2_;
         var _loc5_:Number = this.m_hopForce.y;
         _loc5_ = _loc5_ + Math.random() * (this.m_hopForceMax.y - this.m_hopForce.y);
         if(this.currentPerch)
         {
            _loc6_ = 20;
            _loc7_ = this.currentPerch.length.x;
            _loc8_ = this.currentPerch.angle.toDegrees();
            _loc9_ = 2;
            _loc10_ = 3;
            _loc11_ = 0.1;
            _loc12_ = 1.3;
            if(_loc8_ < 0)
            {
               _loc13_ = currentPos.x - this.currentPerch.bounds.left;
               if(_loc13_ < _loc6_)
               {
                  _loc3_ = _loc4_ * _loc9_;
                  _loc4_ = _loc3_ < 0 ? -_loc3_ : _loc3_;
                  _loc5_ *= _loc9_;
               }
               if(_loc13_ < _loc7_ / 3)
               {
                  if(Math.random() < _loc11_)
                  {
                     _loc4_ = _loc4_ < 0 ? -_loc4_ : _loc4_;
                  }
               }
               if(_loc4_ > 0)
               {
                  _loc4_ *= _loc12_;
                  _loc5_ *= _loc12_;
               }
            }
            else
            {
               _loc14_ = currentPos.x - this.currentPerch.bounds.right;
               if(_loc14_ > -_loc6_)
               {
                  _loc3_ = _loc4_ * _loc9_;
                  _loc4_ = _loc3_ > 0 ? -_loc3_ : _loc3_;
                  _loc5_ *= _loc9_;
               }
               if(_loc14_ > -(_loc7_ / 3))
               {
                  if(Math.random() < _loc11_)
                  {
                     _loc4_ = _loc4_ > 0 ? -_loc4_ : _loc4_;
                  }
               }
               if(_loc4_ < 0)
               {
                  _loc4_ *= _loc12_;
                  _loc5_ *= _loc12_;
               }
            }
         }
         this.jump(new Vector2D(_loc4_,-_loc5_));
      }
      
      public function get isFlying() : Boolean
      {
         return this.m_isFlying;
      }
      
      public function get roofEdgePanicDistance() : int
      {
         return this.m_roofEdgePanicDistance;
      }
      
      public function get scareDistance() : int
      {
         return this.m_scareDistance;
      }
      
      public function get flyScareDistance() : int
      {
         return this.m_flyScareDistance;
      }
      
      public function get avoidChance() : Chance
      {
         return this.m_avoidChance;
      }
      
      public function get evadeDistance() : int
      {
         return this.m_evadeDistance;
      }
      
      public function fly() : void
      {
         this.m_isInAir = true;
         this.m_isFlying = true;
         this.m_isLanding = false;
         this.m_isFlyTimeUp = false;
         this.m_hasLanded = false;
         this.m_flyTime = 0;
         isCollidableWithWall = false;
         isCollidableWithBounds = true;
         removeConstantForce("gravity");
         dispatchEvent(new PigeonEvent(PigeonEvent.FLY));
      }
      
      public function panic() : void
      {
         this.fly();
         applyForce(Vector2D.getRandom(-250,250,-100,-300));
      }
      
      public function get avoidGroundDistance() : int
      {
         return this.m_avoidGroundDistance;
      }
      
      public function get weaponSystem() : WeaponSystem
      {
         return this.m_weaponSystem;
      }
      
      private function onEvadeDistanceTimerTick(param1:Event) : void
      {
         this.m_evadeDistance += this.m_evadeDistanceRegenAmount;
         if(this.m_evadeDistance > this.m_defaultEvadeDistance)
         {
            this.m_evadeDistance = this.m_defaultEvadeDistance;
         }
      }
      
      public function get attackDistance() : int
      {
         return this.m_attackDistance;
      }
      
      private function initFlyPaths(param1:Array) : *
      {
         var _loc2_:Path = null;
         for each(_loc2_ in param1)
         {
            _pathManager.addPath(_loc2_);
         }
      }
      
      public function remove() : void
      {
         _parent.removeChild(id);
      }
      
      public function get featherColor() : uint
      {
         return this.m_featherColor;
      }
      
      public function get panicDistance() : int
      {
         return this.m_panicDistance;
      }
      
      public function get isLanding() : Boolean
      {
         return this.m_isLanding;
      }
      
      public function get attackHeight() : int
      {
         return this.m_attackHeight;
      }
      
      public function hit(param1:StatEffect, param2:Vector2D = null) : void
      {
         if(this.statSystem.hasStatEffect("invincibility"))
         {
            return;
         }
         this.statSystem.addStatEffect(new InvincibilityStatEffect(new StatEffectParams({"lifeTime":100})));
         this.statSystem.addStatEffect(param1);
         if(this.isFlying)
         {
            applyForce(param2);
         }
         else
         {
            this.jump(param2);
         }
         this.m_audioManager.play("PigeonRustleFeathers");
         this.m_audioManager.playRandom("PigeonCaw");
         var _loc3_:FeatherBlastEffect = new FeatherBlastEffect(new FeatherBlastEffectParams({
            "color":this.featherColor,
            "numOfFeathers":Math.random() * (this.numFeathers - this.minFeathers) + this.minFeathers
         }));
         _loc3_.setPosition(currentPos.x,currentPos.y);
         this.m_displayManager.addParticleEffect("ParticleEffectDisplayTop",_loc3_);
         dispatchEvent(new PigeonEvent(PigeonEvent.HIT));
      }
      
      public function get avoidDistance() : int
      {
         return this.m_avoidDistance;
      }
      
      public function get panicChance() : Chance
      {
         return this.m_panicChance;
      }
      
      public function get attackChance() : Chance
      {
         return this.m_attackChance;
      }
      
      public function onLifeDead(param1:LifeEvent) : void
      {
      }
      
      public function get minFeathers() : int
      {
         return this.m_minFeathers;
      }
      
      public function get statSystem() : Stats
      {
         return this.m_statSystem;
      }
      
      public function get isAttacking() : Boolean
      {
         return this.m_isAttacking;
      }
      
      public function get isFlyTimeUp() : Boolean
      {
         return this.m_isFlyTimeUp;
      }
      
      public function die() : void
      {
         this.m_rewardSystem.pigeonKilled(this.m_pointSystem.points,type,currentPos);
         var _loc1_:Vector2D = velocity.normalized().times(1000);
         applyForce(_loc1_);
         friction.x = friction.y = 1;
         boundsBehavior = BOUNDS_REMOVE;
         boundsBehaviors = [new RemoveBoundsBehavior(new BoundsBehaviorParams())];
         isCollidable = false;
         isCollidableWithWall = false;
         isCollidableWithBounds = true;
         this.m_isDead = true;
         if(this.m_onDeathSound)
         {
            this.m_audioManager.play(this.m_onDeathSound);
         }
         dispatchEvent(new PigeonEvent(PigeonEvent.DIE));
      }
      
      public function onLand(param1:Wall = null) : void
      {
         removeConstantForce("gravity");
         velocity.zero();
         this.m_isInAir = false;
         this.m_isFlying = false;
         this.m_isLanding = false;
         this.m_isFlyTimeUp = true;
         this.m_hasLanded = true;
         this.m_flyTime = 0;
         this.m_currentPerch = param1;
         if(this.m_isEvadeDistanceResetOnLand)
         {
            this.m_evadeDistance = this.m_defaultEvadeDistance;
         }
         dispatchEvent(new PigeonEvent(PigeonEvent.LAND));
      }
      
      public function get pooChance() : Chance
      {
         return this.m_pooChance;
      }
      
      public function get isDead() : Boolean
      {
         return this.m_isDead;
      }
      
      public function get chaseChance() : Chance
      {
         return this.m_chaseChance;
      }
      
      public function onDryTick(param1:Event) : void
      {
         this.m_statSystem.modifyStat("wetness",-this.m_dryAmountPerTick,Stat.BOTH_VALUES);
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(this.m_isDead)
         {
            return;
         }
         this.m_statSystem.update(param1);
         this.m_lifeSystem.update(param1);
         this.m_weaponSystem.update(param1);
         this.m_evadeDistanceTickRegulator.update(param1);
         if(this.m_statSystem.getStat("wetness").value > 0)
         {
            if(!this.m_isWet)
            {
               this.m_isWet = true;
               dispatchEvent(new PigeonEvent(PigeonEvent.WET));
            }
            this.m_dryTickRegulator.update(param1);
            maxSpeed = this.m_defaultMaxSpeed / 3;
         }
         else
         {
            if(this.m_isWet)
            {
               this.m_isWet = false;
               dispatchEvent(new PigeonEvent(PigeonEvent.DRY));
            }
            this.updateFlyTime(param1);
            maxSpeed = this.m_defaultMaxSpeed;
         }
      }
      
      public function get flyAttackChance() : Chance
      {
         return this.m_flyAttackChance;
      }
      
      public function get pointSystem() : Points
      {
         return this.m_pointSystem;
      }
      
      public function get isInAir() : Boolean
      {
         return this.m_isInAir;
      }
      
      public function get landGravity() : int
      {
         return this.m_landGravity;
      }
      
      public function get hopChance() : Chance
      {
         return this.m_hopChance;
      }
      
      private function updateFlyTime(param1:int) : void
      {
         this.m_flyTime += param1;
         if(this.m_flyTime > this.m_flyTimeMin)
         {
            this.m_flyTime = 0;
            this.m_isFlyTimeUp = true;
         }
      }
      
      public function get flyTime() : int
      {
         return this.m_flyTime;
      }
      
      public function get flyEvadeForce() : Vector2D
      {
         return this.m_flyEvadeForce;
      }
      
      public function get numFeathers() : int
      {
         return this.m_numFeathers;
      }
      
      public function land() : void
      {
         isCollidableWithWall = true;
         addConstantForce(new Vector2D(0,this.m_landGravity),"gravity");
      }
      
      public function prepareToLand() : void
      {
         this.fly();
         this.m_isLanding = true;
         dispatchEvent(new PigeonEvent(PigeonEvent.LANDING));
      }
      
      public function get landChance() : Chance
      {
         return this.m_landChance;
      }
   }
}

