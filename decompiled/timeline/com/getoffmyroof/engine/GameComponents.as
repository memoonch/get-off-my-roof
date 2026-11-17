package com.getoffmyroof.engine
{
   import com.getoffmyroof.collision.LocalCollisionResponse;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.inventory.Inventory;
   import com.getoffmyroof.levels.GameLevelManager;
   import com.getoffmyroof.popups.PopupManager;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.getoffmyroof.save.SaveLoadManager;
   import com.urbansquall.ginger.tools.AnimationPlayerFactory;
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.ai.steering.path.PathFactory;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.display.DisplayManager;
   import com.whatthefawk.entity.ICollisionResponse;
   import com.whatthefawk.entity.IMessageDispatcher;
   import com.whatthefawk.entity.MessageDispatcher;
   import com.whatthefawk.rewards.achievements.AchievementManager;
   import com.whatthefawk.screens.Root;
   import com.whatthefawk.screens.ScreenManager;
   import com.whatthefawk.weapons.explosion.ExplosionFactory;
   import com.whatthefawk.weapons.melee.MeleeWeaponFactory;
   import com.whatthefawk.weapons.projectile.ProjectileWeaponFactory;
   import flash.utils.Dictionary;
   
   public class GameComponents
   {
      
      private static var _instance:GameComponents;
      
      private var m_components:Dictionary = new Dictionary();
      
      public function GameComponents(param1:Root)
      {
         super();
         if(_instance !== null)
         {
            throw new Error("<GameComponents> Only initialize once.");
         }
         _instance = this;
         this.registerComponent("GameEngine",param1);
         this.registerComponent("GameFactory",new GameFactory());
         this.registerComponent("MessageDispatcher",new MessageDispatcher());
         this.registerComponent("CollisionResponse",new LocalCollisionResponse(this.getComponent("MessageDispatcher")));
         this.registerComponent("ScreenManager",new ScreenManager(param1));
         this.registerComponent("AudioManager",new AudioManager());
         this.registerComponent("DisplayManager",new DisplayManager());
         this.registerComponent("PathFactory",new PathFactory());
         this.registerComponent("AnimationPlayerFactory",new AnimationPlayerFactory());
         this.registerComponent("AchievementManager",new AchievementManager(param1));
         this.registerComponent("SaveLoadManager",new SaveLoadManager());
         this.registerComponent("GlobalInventory",new Inventory());
         this.registerComponent("RewardSystem",new RewardSystem());
         this.registerComponent("PopupManager",new PopupManager());
         this.registerComponent("GameLevelManager",new GameLevelManager(this.getComponent("GameFactory")));
         this.registerComponent("MeleeWeaponFactory",new MeleeWeaponFactory(this.getComponent("GameFactory")));
         this.registerComponent("ProjectileWeaponFactory",new ProjectileWeaponFactory(this.getComponent("GameFactory")));
         this.registerComponent("ExplosionFactory",new ExplosionFactory(this.getComponent("GameFactory")));
         this.registerComponent("PlayerController",new PlayerController(this.getComponent("GameFactory"),this.getComponent("MeleeWeaponFactory"),this.getComponent("ProjectileWeaponFactory")));
      }
      
      public static function get instance() : GameComponents
      {
         return _instance;
      }
      
      public function getDisplayManager() : *
      {
         return this.getComponent("DisplayManager");
      }
      
      public function getGameFactory() : *
      {
         return this.getComponent("GameFactory");
      }
      
      public function get componentsArray() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = [];
         for each(_loc2_ in this.m_components)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getComponent(param1:*) : *
      {
         if(this.m_components[param1] == null)
         {
            throw new Error("<GameComponents> Game Component " + param1 + " does not exist.");
         }
         return this.m_components[param1];
      }
      
      public function getGameEngine() : *
      {
         return this.getComponent("GameEngine");
      }
      
      public function getScreenManager() : ScreenManager
      {
         return this.getComponent("ScreenManager");
      }
      
      public function getAudioManager() : AudioManager
      {
         return this.getComponent("AudioManager");
      }
      
      public function hasComponent(param1:*) : Boolean
      {
         if(this.m_components[param1] != null)
         {
            return true;
         }
         return false;
      }
      
      public function get components() : Dictionary
      {
         return this.m_components;
      }
      
      public function getMessageDispatcher() : IMessageDispatcher
      {
         return this.getComponent("MessageDispatcher");
      }
      
      public function unregisterComponent(param1:String) : void
      {
         if(this.m_components[param1] == null)
         {
            throw new Error("<GameComponents> Game Component " + param1 + " does not exist.");
         }
         delete this.m_components[param1];
      }
      
      public function registerComponent(param1:String, param2:*) : void
      {
         if(this.m_components[param1] != null)
         {
            throw new Error("<GameComponents> Game Component " + param1 + " is already registered.");
         }
         this.m_components[param1] = param2;
      }
      
      public function traceComponents() : void
      {
         var _loc1_:String = null;
         var _loc2_:* = undefined;
         for(_loc1_ in this.m_components)
         {
            _loc2_ = this.m_components[_loc1_];
         }
      }
      
      public function getCollisionResponse() : ICollisionResponse
      {
         return this.getComponent("CollisionResponse");
      }
   }
}

