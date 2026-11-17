package com.getoffmyroof.levels.spawners
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.entity.Pigeon;
   import com.getoffmyroof.entity.RoofGroup;
   import com.getoffmyroof.levels.GameLevelManager;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.projectile.ProjectileWeaponFactory;
   
   public class PigeonSpawner extends ASpawner
   {
      
      private var m_gameLevelManager:GameLevelManager;
      
      private var m_playerController:PlayerController;
      
      private var m_projectileWeaponFactory:ProjectileWeaponFactory;
      
      public function PigeonSpawner(param1:SpawnerParams)
      {
         super(param1);
         this.m_playerController = GameComponents.instance.getComponent("PlayerController");
         this.m_gameLevelManager = GameComponents.instance.getComponent("GameLevelManager");
         this.m_projectileWeaponFactory = GameComponents.instance.getComponent("ProjectileWeaponFactory");
         addEventListener(SpawnerEvent.SPAWN,this.onSpawnerSpawn,false,0,true);
      }
      
      private function initTarget(param1:Pigeon) : void
      {
         param1.target = this.m_playerController.player;
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
      }
      
      private function initStates(param1:Pigeon) : void
      {
         var _loc2_:Vector2D = Vector2D.getRandom(param1.newPos.x,param1.newPos.x,40,0);
         param1.state.changeState(param1.state.getState("PigeonLand",{"landingPosition":_loc2_}));
      }
      
      private function initWeapon(param1:Pigeon) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Array = [];
         switch(param1.type)
         {
            case "Pigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyPigeonWeapon",param1));
               break;
            case "BlackPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackPigeonWeapon",param1));
               break;
            case "BrownPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownPigeonWeapon",param1));
               break;
            case "FatPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyFatPigeonWeapon",param1));
               break;
            case "BlackFatPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackFatPigeonWeapon",param1));
               break;
            case "BrownFatPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownFatPigeonWeapon",param1));
               break;
            case "SoldierPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreySoldierPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreySoldierPigeonFlyingWeapon",param1));
               break;
            case "BlackSoldierPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackSoldierPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackSoldierPigeonFlyingWeapon",param1));
               break;
            case "BrownSoldierPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownSoldierPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownSoldierPigeonFlyingWeapon",param1));
               break;
            case "CrazyPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyCrazyPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyCrazyPigeonFlyingWeapon",param1));
               break;
            case "BlackCrazyPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackCrazyPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackCrazyPigeonFlyingWeapon",param1));
               break;
            case "BrownCrazyPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownCrazyPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownCrazyPigeonFlyingWeapon",param1));
               break;
            case "BomberPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyBomberPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyBomberPigeonFlyingWeapon",param1));
               break;
            case "BlackBomberPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackBomberPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackBomberPigeonFlyingWeapon",param1));
               break;
            case "BrownBomberPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownBomberPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownBomberPigeonFlyingWeapon",param1));
               break;
            case "BossRockyPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("PigeonThrowRockWeapon",param1));
               break;
            case "BossFatPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyFatPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackFatPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownFatPigeonWeapon",param1));
               break;
            case "BossSoldierPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreySoldierPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackSoldierPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownSoldierPigeonWeapon",param1));
               break;
            case "BossCrazyPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyCrazyPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackCrazyPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownCrazyPigeonWeapon",param1));
               break;
            case "BossBomberPigeon":
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyBomberPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BlackBomberPigeonWeapon",param1));
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("BrownBomberPigeonWeapon",param1));
               break;
            default:
               _loc2_.push(this.m_projectileWeaponFactory.getWeapon("GreyPigeonWeapon",param1));
         }
         var _loc3_:int = 1;
         for each(_loc4_ in _loc2_)
         {
            _loc4_.target = param1.target.newPos;
            param1.weaponSystem.addWeapon(_loc4_,_loc3_);
            _loc3_++;
         }
      }
      
      private function onSpawnerSpawn(param1:SpawnerEvent) : void
      {
         var _loc2_:Pigeon = param1.data.spawnedEntity as Pigeon;
         var _loc3_:RoofGroup = this.m_gameLevelManager.currentLevel.getLevelObject("RoofGroup");
         _loc2_.roofGroup = _loc3_;
         _loc2_.target = this.m_playerController.player;
         this.initWeapon(_loc2_);
         _loc2_.newPos.randomize(50,470,-40,-60);
         this.initStates(_loc2_);
         _loc2_.addConstantForce(new Vector2D(0,_loc2_.landGravity),"gravity");
      }
      
      private function initPosition(param1:Pigeon) : void
      {
         param1.newPos.randomize(50,470,-40,-60);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_gameLevelManager = null;
         this.m_projectileWeaponFactory = null;
      }
   }
}

