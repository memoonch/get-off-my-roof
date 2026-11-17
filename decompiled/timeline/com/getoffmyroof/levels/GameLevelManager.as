package com.getoffmyroof.levels
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.entity.Roof;
   import com.getoffmyroof.entity.RoofGroup;
   import com.getoffmyroof.levels.actions.*;
   import com.getoffmyroof.levels.droppers.*;
   import com.getoffmyroof.levels.spawners.*;
   import com.getoffmyroof.levels.triggers.*;
   import com.getoffmyroof.popups.*;
   import com.getoffmyroof.timers.GameTimer;
   import com.getoffmyroof.timers.GameTimerEvent;
   import com.getoffmyroof.timers.GameTimerParams;
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.EntityParams;
   import com.whatthefawk.entity.GameWorld;
   import com.whatthefawk.entity.Wall;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.projectile.Projectile;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class GameLevelManager extends EventDispatcher
   {
      
      public static const PATH_TO_ACTIONS:String = "com.getoffmyroof.levels.actions.";
      
      public static const PATH_TO_TRIGGERS:String = "com.getoffmyroof.levels.triggers.";
      
      public static const PATH_TO_SPAWNERS:String = "com.getoffmyroof.levels.spawners.";
      
      private var m_gameLevelsXML:Dictionary;
      
      private var m_selectedGameLevel:String;
      
      private var m_skiesXML:Dictionary;
      
      private var m_levelTimer:GameTimer;
      
      private var m_currentGameLevel:GameLevel;
      
      private var m_isLevelActive:Boolean;
      
      private var m_levelCountdownTimer:GameTimer;
      
      private var m_gameFactory:GameFactory;
      
      private var m_gameWorld:GameWorld;
      
      private var m_housesXML:Dictionary;
      
      private var m_popupManager:PopupManager;
      
      public function GameLevelManager(param1:GameFactory)
      {
         super();
         this.m_gameFactory = param1;
         this.m_popupManager = GameComponents.instance.getComponent("PopupManager");
         this.m_skiesXML = new Dictionary();
         this.m_housesXML = new Dictionary();
         this.m_gameLevelsXML = new Dictionary();
         this.m_levelTimer = new GameTimer(new GameTimerParams());
         this.m_levelCountdownTimer = new GameTimer(new GameTimerParams({
            "timeEndsAt":0,
            "timeStartsAt":3,
            "timeIncrement":GameTimer.INCREMENT_DOWN
         }));
         this.m_levelCountdownTimer.addEventListener(GameTimerEvent.COMPLETE,this.onCountdownTimerComplete,false,0,true);
         this.m_isLevelActive = false;
         this.registerClasses();
      }
      
      private function registerClasses() : void
      {
         var _loc1_:PigeonSpawner = null;
         var _loc2_:GroupDeadTrigger = null;
         var _loc3_:EndLevelAction = null;
         var _loc4_:SelectLevelAction = null;
         var _loc5_:SpawnGroupAction = null;
         var _loc6_:StopDroppersAction = null;
         var _loc7_:StartDroppersAction = null;
         var _loc8_:RestartDroppersAction = null;
         var _loc9_:StopAllDroppersAction = null;
      }
      
      public function get currentLevel() : GameLevel
      {
         return this.m_currentGameLevel;
      }
      
      public function setGameWorld(param1:GameWorld) : void
      {
         this.m_gameWorld = param1;
      }
      
      public function startLevelCountdown() : void
      {
         this.m_levelCountdownTimer.reset();
         dispatchEvent(new GameLevelEvent(GameLevelEvent.LEVEL_COUNTDOWN_START));
      }
      
      public function loadSelectedGameLevel() : void
      {
         if(!this.m_selectedGameLevel)
         {
            throw new Error("<GameLevelManager::loadSelectedGameLevel> You must select a game level first.");
         }
         if(!this.m_gameWorld)
         {
            throw new Error("<GameLevelManager::loadNextLevel> m_gameWorld has not been set.");
         }
         this.loadGameLevel(this.m_selectedGameLevel,this.m_gameWorld);
      }
      
      public function addHouseXML(param1:String, param2:XML) : void
      {
         this.m_housesXML[param1] = param2;
      }
      
      public function buildSpawners(param1:SpawnGroup, param2:XMLList) : void
      {
         var _loc3_:XML = null;
         var _loc4_:SpawnerParams = null;
         var _loc5_:String = null;
         var _loc6_:Class = null;
         var _loc7_:ASpawner = null;
         for each(_loc3_ in param2)
         {
            _loc4_ = new SpawnerParams();
            if(Boolean(_loc3_.@num.length()) && _loc3_.@num != "")
            {
               _loc4_.numToSpawn = _loc3_.@num;
            }
            if(Boolean(_loc3_.@limit.length()) && _loc3_.@limit != "")
            {
               _loc4_.spawnLimit = _loc3_.@limit;
            }
            if(Boolean(_loc3_.@entity.length()) && _loc3_.@entity != "")
            {
               _loc4_.entityType = _loc3_.@entity;
            }
            _loc5_ = PATH_TO_SPAWNERS + _loc3_.@type;
            _loc6_ = getDefinitionByName(_loc5_) as Class;
            _loc7_ = new _loc6_(_loc4_);
            param1.addSpawner(_loc7_);
         }
      }
      
      public function selectGameLevel(param1:String) : void
      {
         if(this.m_gameLevelsXML[param1] == null)
         {
            throw new Error("<GameLevelManager::selectGameLevel> Game Level " + param1 + " does not exist.");
         }
         this.m_selectedGameLevel = param1;
      }
      
      public function get isLevelActive() : Boolean
      {
         return this.m_isLevelActive;
      }
      
      public function get levelTimer() : GameTimer
      {
         return this.m_levelTimer;
      }
      
      public function get selectedLevel() : String
      {
         return this.m_selectedGameLevel;
      }
      
      public function getSkyXML(param1:String) : XML
      {
         return this.m_skiesXML[param1];
      }
      
      public function addSkyXML(param1:String, param2:XML) : void
      {
         this.m_skiesXML[param1] = param2;
      }
      
      private function onLevelTimerComplete(param1:GameTimerEvent) : void
      {
         dispatchEvent(new GameLevelEvent(GameLevelEvent.LEVEL_TIME_UP));
      }
      
      private function onCountdownTimerComplete(param1:GameTimerEvent) : void
      {
         dispatchEvent(new GameLevelEvent(GameLevelEvent.LEVEL_COUNTDOWN_END));
         this.startLevel();
      }
      
      public function onLevelComplete(param1:GameLevelEvent) : void
      {
         this.endLevel();
      }
      
      public function set isLevelActive(param1:Boolean) : void
      {
         this.m_isLevelActive = param1;
      }
      
      public function startLevel() : void
      {
         this.m_isLevelActive = true;
         this.m_levelTimer.reset();
         this.m_currentGameLevel.startGameLevel();
         dispatchEvent(new GameLevelEvent(GameLevelEvent.LEVEL_START));
      }
      
      public function addGameLevelXML(param1:String, param2:XML) : void
      {
         if(this.m_gameLevelsXML[param1] != null)
         {
            throw new Error("<GameLevelManager::addGameLevelXML> Game Level " + param1 + " has already been added.");
         }
         if(!param2.toXMLString())
         {
            throw new Error("<GameLevelManager::addGameLevelXML> Warning, game level " + param1 + " is blank or a duplicate of another game level and will not be loaded.");
         }
         this.m_gameLevelsXML[param1] = param2;
      }
      
      public function update(param1:int) : void
      {
         if(!this.m_currentGameLevel)
         {
            return;
         }
         if(!this.m_levelCountdownTimer.isComplete)
         {
            this.m_levelCountdownTimer.update(param1);
         }
         if(this.m_isLevelActive)
         {
            this.m_currentGameLevel.update(param1);
            this.m_levelTimer.update(param1);
         }
      }
      
      public function getHouseXML(param1:String) : XML
      {
         return this.m_housesXML[param1];
      }
      
      public function reset() : void
      {
         this.m_isLevelActive = false;
         this.m_currentGameLevel = null;
      }
      
      private function buildHouse(param1:GameLevel, param2:XML) : void
      {
         var _loc5_:XML = null;
         var _loc6_:Roof = null;
         var _loc7_:XML = null;
         var _loc8_:Wall = null;
         var _loc3_:Entity = this.m_gameFactory.getEntity(param2.@entityID);
         _loc3_.newPos.x = param2.@x;
         _loc3_.newPos.y = param2.@y;
         var _loc4_:RoofGroup = new RoofGroup();
         for each(_loc5_ in param2.roofs.roof)
         {
            _loc6_ = new Roof(new EntityParams());
            for each(_loc7_ in _loc5_.wall)
            {
               _loc8_ = this.m_gameFactory.getEntity("Wall");
               _loc8_.setCorners(new Vector2D(_loc7_.from.@x,_loc7_.from.@y),new Vector2D(_loc7_.to.@x,_loc7_.to.@y));
               _loc6_.addWall(_loc8_);
            }
            _loc4_.addRoof(_loc6_);
         }
         _loc4_.generateLandingPositions(100);
         param1.addLevelObject("RoofGroup",_loc4_);
      }
      
      private function buildSky(param1:GameWorld, param2:XML) : void
      {
         var _loc3_:Entity = null;
         _loc3_ = this.m_gameFactory.getEntity(param2.@entityID);
         _loc3_.newPos.x = param2.@x;
         _loc3_.newPos.y = param2.@y;
      }
      
      private function buildSpawnGroups(param1:GameLevel, param2:XMLList) : void
      {
         var _loc3_:XML = null;
         var _loc4_:SpawnGroup = null;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc7_:Class = null;
         var _loc8_:AGroupTrigger = null;
         var _loc9_:XML = null;
         var _loc10_:String = null;
         var _loc11_:Class = null;
         var _loc12_:AAction = null;
         for each(_loc3_ in param2.group)
         {
            _loc4_ = new SpawnGroup(_loc3_.@id);
            this.buildSpawners(_loc4_,_loc3_.spawner);
            for each(_loc5_ in _loc3_.trigger)
            {
               _loc6_ = PATH_TO_TRIGGERS + _loc5_.@type;
               _loc7_ = getDefinitionByName(_loc6_) as Class;
               _loc8_ = new _loc7_(_loc4_);
               for each(_loc9_ in _loc5_.action)
               {
                  _loc10_ = PATH_TO_ACTIONS + _loc9_.@type;
                  _loc11_ = getDefinitionByName(_loc10_) as Class;
                  _loc12_ = new _loc11_(this);
                  _loc12_.initActionXML(_loc9_);
                  _loc8_.addAction(_loc12_);
               }
               _loc4_.addTrigger(_loc8_);
            }
            param1.addSpawnGroup(_loc4_.id,_loc4_);
         }
      }
      
      public function endLevel() : void
      {
         this.m_isLevelActive = false;
         dispatchEvent(new GameLevelEvent(GameLevelEvent.LEVEL_COMPLETE));
      }
      
      private function buildGameLevel(param1:String, param2:GameWorld) : GameLevel
      {
         var _loc3_:XML = this.getGameLevelXML(param1);
         var _loc4_:GameLevel = new GameLevel(new GameLevelParams({
            "gameWorld":param2,
            "id":param1,
            "name":_loc3_.name,
            "description":_loc3_.description,
            "music":_loc3_.music
         }));
         _loc4_.addEventListener(GameLevelEvent.LEVEL_COMPLETE,this.onLevelComplete,false,0,true);
         this.buildSky(param2,this.getSkyXML(_loc3_.sky));
         this.buildHouse(_loc4_,this.getHouseXML(_loc3_.house));
         this.buildSpawnGroups(_loc4_,_loc3_.groups);
         this.buildDroppers(_loc4_,_loc3_.droppers);
         return _loc4_;
      }
      
      public function loadGameLevel(param1:String, param2:GameWorld = null) : void
      {
         if(param2)
         {
            this.m_gameWorld = param2;
         }
         if(!this.m_gameWorld)
         {
            throw new Error("<GameLevelManager::loadNextLevel> m_gameWorld has not been set.");
         }
         this.m_gameWorld.removeChildren(Projectile);
         this.selectGameLevel(param1);
         if(this.m_currentGameLevel)
         {
            this.m_currentGameLevel.dispose();
         }
         this.m_levelTimer.reset();
         this.m_currentGameLevel = this.buildGameLevel(param1,this.m_gameWorld);
      }
      
      private function buildDroppers(param1:GameLevel, param2:XMLList) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Dropper = null;
         var _loc5_:SpawnGroup = null;
         for each(_loc3_ in param2.dropper)
         {
            _loc4_ = new Dropper(new DropperParams({
               "id":_loc3_.@id,
               "lifeTime":_loc3_.@lifeTime,
               "dropRate":_loc3_.@dropRate,
               "dropChance":_loc3_.@dropChance,
               "timeBeforeDrop":_loc3_.@timeBeforeDrop
            }));
            _loc5_ = new SpawnGroup(_loc4_.id);
            this.buildSpawners(_loc5_,_loc3_.spawner);
            _loc4_.setSpawnGroup(_loc5_);
            param1.addDropper(_loc4_.id,_loc4_);
         }
      }
      
      public function getGameLevelXML(param1:String) : XML
      {
         if(this.m_gameLevelsXML[param1] == null)
         {
            throw new Error("<GameLevelManager::addGameLevelXML> Game Level " + param1 + " does not exist.");
         }
         return this.m_gameLevelsXML[param1];
      }
   }
}

