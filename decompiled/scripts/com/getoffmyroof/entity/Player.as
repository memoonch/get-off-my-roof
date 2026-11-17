package com.getoffmyroof.entity
{
   import com.getoffmyroof.ai.states.PlayerGlobalState;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.particleEffects.WipeFaceEffect;
   import com.getoffmyroof.particleEffects.WipeFaceEffectParams;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.display.DisplayManager;
   import com.whatthefawk.entity.Boid;
   import com.whatthefawk.life.Life;
   import com.whatthefawk.life.LifeEvent;
   import com.whatthefawk.life.LifeParams;
   import com.whatthefawk.life.stats.Stat;
   import com.whatthefawk.life.stats.StatEffectParams;
   import com.whatthefawk.life.stats.Stats;
   import com.whatthefawk.life.stats.StatsParams;
   import com.whatthefawk.life.stats.statEffects.InvincibilityStatEffect;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.screens.Root;
   import com.whatthefawk.weapons.WeaponSystem;
   import com.whatthefawk.weapons.projectile.ProjectileWeapon;
   
   public class Player extends Boid
   {
      
      private var m_jumpMax:int;
      
      private var m_audioManager:AudioManager;
      
      private var m_wetnaps:int;
      
      private var m_jumpForce:Vector2D;
      
      private var m_isInAir:Boolean;
      
      private var m_isJumping:Boolean;
      
      private var m_displayManager:DisplayManager;
      
      private var m_multiJumpModifier:Number;
      
      private var m_secondaryWeaponSystem:WeaponSystem;
      
      private var m_jumpCount:Number;
      
      private var m_statSystem:Stats;
      
      private var m_primaryWeaponSystem:WeaponSystem;
      
      private var m_isDead:Boolean;
      
      private var m_lifeSystem:Life;
      
      private var m_jumpGravity:Vector2D;
      
      public var isWalking:Boolean;
      
      private var m_maxWetnaps:int;
      
      public function Player(param1:*)
      {
         super(param1);
         this.m_audioManager = GameComponents.instance.getAudioManager();
         this.m_displayManager = GameComponents.instance.getDisplayManager();
         this.m_statSystem = new Stats(new StatsParams());
         this.m_lifeSystem = new Life(new LifeParams({
            "stats":this.m_statSystem,
            "maxLife":5
         }));
         this.m_lifeSystem.addEventListener(LifeEvent.DEAD,this.onLifeDead,false,0,true);
         this.m_primaryWeaponSystem = new WeaponSystem(this);
         this.m_secondaryWeaponSystem = new WeaponSystem(this);
         this.m_wetnaps = this.m_maxWetnaps = 3;
         this.m_jumpMax = 1;
         this.m_jumpCount = 0;
         this.m_multiJumpModifier = 1;
         this.m_jumpForce = new Vector2D(0,-800);
         this.m_jumpGravity = new Vector2D(0,35);
         this.m_isDead = false;
         this.m_isInAir = true;
         this.isWalking = false;
         addConstantForce(new Vector2D(0,35),"gravity");
         state.changeGlobalState(new PlayerGlobalState());
      }
      
      override public function stop(param1:Number = 0.5) : void
      {
         super.stop(param1);
         this.isWalking = false;
         dispatchEvent(new PlayerEvent(PlayerEvent.IDLE));
      }
      
      public function get secondaryWeaponSystem() : WeaponSystem
      {
         return this.m_secondaryWeaponSystem;
      }
      
      public function die() : void
      {
         this.m_isDead = true;
         this.deactivatePrimaryWeapon();
         this.deactivateSecondaryWeapon();
         dispatchEvent(new PlayerEvent(PlayerEvent.DIE));
      }
      
      public function get primaryWeaponSystem() : WeaponSystem
      {
         return this.m_primaryWeaponSystem;
      }
      
      public function modifyJump(param1:int, param2:Vector2D = null, param3:Vector2D = null) : void
      {
         this.m_jumpMax = param1;
         if(param2)
         {
            this.m_jumpForce = param2;
         }
         if(param3)
         {
            this.m_jumpGravity = param3;
         }
      }
      
      public function activatePrimaryWeapon() : void
      {
         if(this.m_primaryWeaponSystem.canFireCurrentWeapon())
         {
            this.m_audioManager.playRandom("PlayerSwing");
            this.m_primaryWeaponSystem.activateCurrentWeapon();
            dispatchEvent(new PlayerEvent(PlayerEvent.ATTACK,{"animationID":"PlayerSwing"}));
         }
      }
      
      public function deactivateSecondaryWeapon() : void
      {
         this.m_secondaryWeaponSystem.deactivateCurrentWeapon();
      }
      
      public function get statSystem() : Stats
      {
         return this.m_statSystem;
      }
      
      public function deactivatePrimaryWeapon() : void
      {
         this.m_primaryWeaponSystem.deactivateCurrentWeapon();
      }
      
      public function get isDead() : Boolean
      {
         return this.m_isDead;
      }
      
      private function updateHitArea() : void
      {
         useHitAreaForCollisions = !this.m_isDead;
      }
      
      public function activateSecondaryWeapon() : void
      {
         if(this.m_secondaryWeaponSystem.canFireCurrentWeapon())
         {
            this.m_audioManager.playRandom("PlayerThrow");
            this.m_secondaryWeaponSystem.activateCurrentWeapon();
            dispatchEvent(new PlayerEvent(PlayerEvent.ATTACK,{"animationID":"PlayerThrow"}));
         }
      }
      
      public function jump() : void
      {
         var _loc1_:Vector2D = null;
         if(!this.m_isInAir && !this.m_isJumping || this.m_jumpCount < this.m_jumpMax)
         {
            _loc1_ = this.m_jumpForce;
            ++this.m_jumpCount;
            this.m_isInAir = true;
            this.m_isJumping = true;
            if(this.m_jumpCount == 1)
            {
               addConstantForce(this.m_jumpGravity,"gravity");
            }
            else
            {
               _loc1_.multipliedBy(this.m_multiJumpModifier);
            }
            applyForce(_loc1_);
            this.m_audioManager.play("PlayerJump");
            dispatchEvent(new PlayerEvent(PlayerEvent.JUMP));
         }
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         this.statSystem.update(param1);
         this.lifeSystem.update(param1);
         this.primaryWeaponSystem.update(param1);
         this.secondaryWeaponSystem.update(param1);
         this.updateHitArea();
         this.checkJumpLanding();
         var _loc2_:ProjectileWeapon = this.secondaryWeaponSystem.getCurrentWeapon();
         if(_loc2_)
         {
            _loc2_.target.x = Root.stage.mouseX;
            _loc2_.target.y = Root.stage.mouseY;
         }
      }
      
      public function get lifeSystem() : Life
      {
         return this.m_lifeSystem;
      }
      
      public function reset() : void
      {
         this.m_wetnaps = this.m_maxWetnaps;
         this.statSystem.getStat("life").setValue(this.lifeSystem.maxLife,Stat.BOTH_VALUES);
      }
      
      public function walk(param1:Vector2D) : void
      {
         this.isWalking = true;
         applyForce(param1);
         dispatchEvent(new PlayerEvent(PlayerEvent.WALK));
      }
      
      public function get isInAir() : Boolean
      {
         return this.m_isInAir;
      }
      
      public function get maxWetnaps() : int
      {
         return this.m_maxWetnaps;
      }
      
      private function checkJumpLanding() : void
      {
         if(!this.m_isInAir)
         {
            return;
         }
         if(currentPos.y == _parent.bounds.bottom - radius)
         {
            this.land();
         }
      }
      
      private function land() : void
      {
         this.m_jumpCount = 0;
         this.m_isInAir = false;
         this.m_isJumping = false;
         removeConstantForce("gravity");
         dispatchEvent(new PlayerEvent(PlayerEvent.LAND));
      }
      
      public function useWetnap() : void
      {
         if(this.m_wetnaps == 0)
         {
            return;
         }
         if(this.m_lifeSystem.life == this.m_lifeSystem.maxLife)
         {
            return;
         }
         --this.m_wetnaps;
         this.m_statSystem.getStat("life").modifyValue(1,Stat.BOTH_VALUES);
         var _loc1_:WipeFaceEffect = new WipeFaceEffect(new WipeFaceEffectParams({"target":newPos}));
         _loc1_.setPosition(currentPos.x,currentPos.y);
         this.m_displayManager.addParticleEffect("ParticleEffectDisplayTop",_loc1_);
         this.m_audioManager.play("PlayerUseWetnap");
         dispatchEvent(new PlayerEvent(PlayerEvent.USE_WETNAP));
      }
      
      public function get isJumping() : Boolean
      {
         return this.m_isJumping;
      }
      
      public function get numWetnaps() : int
      {
         return this.m_wetnaps;
      }
      
      public function damage(param1:int) : void
      {
         if(this.m_lifeSystem.isGod || this.m_lifeSystem.isDead)
         {
            return;
         }
         if(this.m_statSystem.hasStatEffect("invincibility"))
         {
            return;
         }
         this.m_audioManager.playRandom("PlayerHit");
         this.m_statSystem.getStat("life").modifyValue(-param1,Stat.BOTH_VALUES);
         this.m_statSystem.addStatEffect(new InvincibilityStatEffect(new StatEffectParams({"lifeTime":1000})));
         applyForce(Vector2D.getRandom(-200,200,-400,-500));
         this.m_isInAir = true;
         addConstantForce(this.m_jumpGravity,"gravity");
         dispatchEvent(new PlayerEvent(PlayerEvent.HIT));
      }
      
      private function onLifeDead(param1:LifeEvent) : void
      {
         this.die();
      }
   }
}

