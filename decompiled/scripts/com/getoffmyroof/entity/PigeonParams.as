package com.getoffmyroof.entity
{
   import com.getoffmyroof.ai.states.BasicPigeonDieState;
   import com.getoffmyroof.ai.states.BasicPigeonFlyState;
   import com.getoffmyroof.ai.states.BasicPigeonGlobalState;
   import com.getoffmyroof.ai.states.BasicPigeonLandState;
   import com.getoffmyroof.ai.states.BasicPigeonWanderState;
   import com.getoffmyroof.ai.states.actions.BasicPigeonAvoidGroundAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonAvoidPlayerAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonAvoidProjectilesAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonChasePlayerAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonCooSoundsAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonDieEnterAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonFlyAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonFlyEnterAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonFlyExitAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonLandAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonLandEnterAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonLandExitAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonPanicAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonPooAttackAction;
   import com.getoffmyroof.ai.states.actions.BasicPigeonWanderAction;
   import com.getoffmyroof.ai.states.actions.PigeonFlyAttackAction;
   import com.getoffmyroof.ai.states.actions.PigeonFlyAvoidPlayerAction;
   import com.getoffmyroof.ai.states.conditions.FlyTimeUpCondition;
   import com.getoffmyroof.points.PointsParams;
   import com.getoffmyroof.rendering.PigeonRenderer;
   import com.getoffmyroof.settings.Layers;
   import com.whatthefawk.collision.bounds.BounceBoundsBehavior;
   import com.whatthefawk.collision.bounds.BoundsBehaviorParams;
   import com.whatthefawk.entity.BoidParams;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Chance;
   import com.whatthefawk.math.Vector2D;
   
   public class PigeonParams extends BoidParams
   {
      
      public var featherColor:uint;
      
      public var chaseDistance:int;
      
      public var avoidChance:Chance;
      
      public var panicChance:Chance;
      
      public var panicDistance:int;
      
      public var flyChance:Chance;
      
      public var attackHeight:int;
      
      public var avoidDistance:int;
      
      public var evadeDistanceMin:int;
      
      public var roofEdgePanicChance:Chance;
      
      public var attackChance:Chance;
      
      public var isEvadeDistanceResetOnLand:Boolean;
      
      public var scareDistance:int;
      
      public var minFeathers:int;
      
      public var pooChance:Chance;
      
      public var hopForce:Vector2D;
      
      public var onDeathSound:String;
      
      public var flyAttackChance:Chance;
      
      public var flyAttackDistance:int;
      
      public var flyPaths:Array;
      
      public var walkTimeMin:int;
      
      public var flyResist:int;
      
      public var evadeDistanceRegenAmount:int;
      
      public var chaseChance:Chance;
      
      public var hopGravity:int;
      
      public var pointsParams:PointsParams;
      
      public var numFeathers:int;
      
      public var scareChance:Chance;
      
      public var flyTimeMin:int;
      
      public var retreatChance:Chance;
      
      public var health:int;
      
      public var hopChance:Chance;
      
      public var hopForceMax:Vector2D;
      
      public var landGravity:int;
      
      public var walkChance:Chance;
      
      public var stopChance:Chance;
      
      public var flyScareDistance:int;
      
      public var resist:int;
      
      public var dodgeChance:Chance;
      
      public var attackDistance:int;
      
      public var flyEvadeForce:Vector2D;
      
      public var avoidGroundDistance:int;
      
      public var roofEdgePanicDistance:int;
      
      public var evadeDistance:int;
      
      public var evadeDistanceRegenRate:int;
      
      public var evadeDistanceLossOnScare:int;
      
      public var landChance:Chance;
      
      public function PigeonParams(param1:Object = null)
      {
         super(param1);
         this.minFeathers = 4;
         this.numFeathers = 8;
         this.featherColor = Pigeon.GREY;
         this.pointsParams = new PointsParams({"points":10});
         this.health = 1;
         this.resist = 1;
         this.flyResist = 1;
         this.flyEvadeForce = new Vector2D(0,-20);
         this.hopForce = new Vector2D(30,50);
         this.hopForceMax = new Vector2D(60,80);
         this.hopGravity = 25;
         this.landGravity = 10;
         this.pooChance = new Chance(1,10);
         this.hopChance = new Chance(1,2);
         this.flyChance = null;
         this.landChance = new Chance(1,100);
         this.walkChance = null;
         this.stopChance = null;
         this.dodgeChance = null;
         this.avoidChance = new Chance(1,100);
         this.chaseChance = new Chance(1,100);
         this.panicChance = new Chance(1,100);
         this.scareChance = new Chance(1,10);
         this.attackChance = new Chance(1,5);
         this.retreatChance = null;
         this.flyAttackChance = new Chance(1,5);
         this.roofEdgePanicChance = new Chance(1,1);
         this.scareDistance = 20;
         this.flyScareDistance = 20;
         this.chaseDistance = 0;
         this.avoidDistance = 80;
         this.evadeDistance = 0;
         this.panicDistance = 50;
         this.attackDistance = 60;
         this.flyAttackDistance = 0;
         this.avoidGroundDistance = 380;
         this.roofEdgePanicDistance = 30;
         this.attackHeight = 220;
         this.evadeDistanceMin = 1;
         this.evadeDistanceRegenRate = 1000;
         this.evadeDistanceRegenAmount = 0;
         this.evadeDistanceLossOnScare = 20;
         this.isEvadeDistanceResetOnLand = false;
         this.flyTimeMin = 3000;
         this.walkTimeMin = 1000;
         this.flyPaths = [];
         tags = ["enemy"];
         type = "Pigeon";
         layer = Layers.NPC;
         radius = 22;
         isCollidable = true;
         customClass = Pigeon;
         rendererClass = PigeonRenderer;
         rendererData = {
            "isRadiusVisible":false,
            "isBoundsVisible":false,
            "isAnimationPlayerVisible":true
         };
         bounce = new Vector2D(0.6,0.6);
         friction = new Vector2D(0.98,0.98);
         maxForce = 20;
         maxSpeed = 420;
         boundsBehavior = MovingEntity.BOUNDS_BOUNCE;
         boundsBehaviors = [new BounceBoundsBehavior(new BoundsBehaviorParams({"checkTop":false}))];
         stateMachineParams.states["PigeonFly"] = BasicPigeonFlyState;
         stateMachineParams.states["PigeonDie"] = BasicPigeonDieState;
         stateMachineParams.states["PigeonLand"] = BasicPigeonLandState;
         stateMachineParams.states["PigeonWander"] = BasicPigeonWanderState;
         stateMachineParams.states["PigeonGlobal"] = BasicPigeonGlobalState;
         stateMachineParams.actions["PigeonFly"] = BasicPigeonFlyAction;
         stateMachineParams.actions["PigeonLand"] = BasicPigeonLandAction;
         stateMachineParams.actions["PigeonPanic"] = BasicPigeonPanicAction;
         stateMachineParams.actions["PigeonWander"] = BasicPigeonWanderAction;
         stateMachineParams.actions["PigeonAvoidGround"] = BasicPigeonAvoidGroundAction;
         stateMachineParams.actions["PigeonAvoidTarget"] = BasicPigeonAvoidPlayerAction;
         stateMachineParams.actions["PigeonFlyAvoidTarget"] = PigeonFlyAvoidPlayerAction;
         stateMachineParams.actions["PigeonAvoidProjectiles"] = BasicPigeonAvoidProjectilesAction;
         stateMachineParams.actions["PigeonChaseTarget"] = BasicPigeonChasePlayerAction;
         stateMachineParams.actions["PigeonAttackTarget"] = BasicPigeonPooAttackAction;
         stateMachineParams.actions["PigeonFlyAttack"] = PigeonFlyAttackAction;
         stateMachineParams.actions["PigeonDieEnter"] = BasicPigeonDieEnterAction;
         stateMachineParams.actions["PigeonFlyEnter"] = BasicPigeonFlyEnterAction;
         stateMachineParams.actions["PigeonFlyExit"] = BasicPigeonFlyExitAction;
         stateMachineParams.actions["PigeonLandEnter"] = BasicPigeonLandEnterAction;
         stateMachineParams.actions["PigeonLandExit"] = BasicPigeonLandExitAction;
         stateMachineParams.actions["PigeonCooSounds"] = BasicPigeonCooSoundsAction;
         stateMachineParams.conditions["PigeonFlyTimeUp"] = FlyTimeUpCondition;
         stateMachineParams.initialState = BasicPigeonLandState;
         stateMachineParams.initialGlobalState = BasicPigeonGlobalState;
      }
   }
}

