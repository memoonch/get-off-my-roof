package com.getoffmyroof.engine
{
   import SWFStats.Log;
   import com.flashdynamix.utils.SWFProfiler;
   import com.getoffmyroof.ai.steering.path.PathTypes;
   import com.getoffmyroof.assets.Animations;
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.audio.AudioFiles;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.entity.EntityTypes;
   import com.getoffmyroof.inventory.Inventory;
   import com.getoffmyroof.inventory.Item;
   import com.getoffmyroof.inventory.ItemParams;
   import com.getoffmyroof.levels.GameLevelManager;
   import com.getoffmyroof.rewards.achievements.AchievementLoader;
   import com.getoffmyroof.save.IValueObject;
   import com.getoffmyroof.save.LocalSaveLoad;
   import com.getoffmyroof.save.SaveLoadManager;
   import com.getoffmyroof.screens.AchievementsScreen;
   import com.getoffmyroof.screens.CreditsScreen;
   import com.getoffmyroof.screens.GameScreen;
   import com.getoffmyroof.screens.IntroScreen;
   import com.getoffmyroof.screens.ItemShopScreen;
   import com.getoffmyroof.screens.LevelFailedScreen;
   import com.getoffmyroof.screens.LevelPassedScreen;
   import com.getoffmyroof.screens.LevelSelectScreen;
   import com.getoffmyroof.screens.MainScreen;
   import com.getoffmyroof.screens.OptionsScreen;
   import com.getoffmyroof.screens.OutroScreen;
   import com.getoffmyroof.screens.PauseScreen;
   import com.getoffmyroof.screens.PlayerSetupScreen;
   import com.getoffmyroof.screens.SponsorScreen;
   import com.getoffmyroof.screens.TutorialScreen;
   import com.getoffmyroof.weapons.ExplosionTypes;
   import com.getoffmyroof.weapons.MeleeWeaponTypes;
   import com.getoffmyroof.weapons.ProjectileTypes;
   import com.getoffmyroof.weapons.ProjectileWeaponTypes;
   import com.urbansquall.ginger.tools.AnimationPlayerFactory;
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.ai.steering.path.PathFactory;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.display.DisplayTypes;
   import com.whatthefawk.rewards.achievements.AchievementManager;
   import com.whatthefawk.screens.Root;
   import com.whatthefawk.screens.ScreenManager;
   import com.whatthefawk.utils.TickRegulator;
   import com.whatthefawk.weapons.explosion.ExplosionFactory;
   import com.whatthefawk.weapons.melee.MeleeWeaponFactory;
   import com.whatthefawk.weapons.projectile.ProjectileWeaponFactory;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.system.Capabilities;
   import flash.ui.ContextMenu;
   import fog.as3.FogDevAPI;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol154")]
   public class GameEngine extends Root
   {
      
      private var m_achievementTickRegulator:TickRegulator;
      
      private var m_audioManager:AudioManager;
      
      private var m_screenManager:ScreenManager;
      
      private var m_achievementManager:AchievementManager;
      
      private var m_saveLoadManager:SaveLoadManager;
      
      private var m_globalInventory:Inventory;
      
      private var m_gameLevelManager:GameLevelManager;
      
      private var m_playerController:PlayerController;
      
      private var m_gameComponents:GameComponents;
      
      private var m_defaultScreen:String = "MainScreen";
      
      public function GameEngine(param1:Stage = null)
      {
         super(param1);
         this.m_gameComponents = new GameComponents(this);
         this.m_audioManager = this.m_gameComponents.getAudioManager();
         this.m_screenManager = this.m_gameComponents.getScreenManager();
         this.m_achievementManager = this.m_gameComponents.getComponent("AchievementManager");
         this.m_gameLevelManager = this.m_gameComponents.getComponent("GameLevelManager");
         this.m_globalInventory = this.m_gameComponents.getComponent("GlobalInventory");
         this.m_saveLoadManager = this.m_gameComponents.getComponent("SaveLoadManager");
         this.m_playerController = this.m_gameComponents.getComponent("PlayerController");
         this.m_achievementTickRegulator = new TickRegulator(1000);
         this.m_achievementTickRegulator.addEventListener(TickRegulator.TICK,this.onAchievementTick,false,0,true);
         this.registerAudio();
         this.registerScreens();
         this.registerLevels();
         this.registerAchievements();
         this.registerGameObjects();
         this.registerGameItems();
         this.registerSaveLoad();
         this.registerPlayer();
         this.loadGameData();
         this.logSystemCapabilities();
         this.m_screenManager.setScreen(this.m_defaultScreen);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      public function registerSaveLoad() : void
      {
         this.m_saveLoadManager.addSaveLoad(new LocalSaveLoad("getoffmyroof_v1/gameData_v1"));
      }
      
      public function registerAudio() : void
      {
         var _loc1_:AudioFiles = new AudioFiles();
         _loc1_.register(this.m_audioManager);
      }
      
      private function onAchievementTick(param1:Event) : void
      {
         this.m_achievementManager.checkAchievements();
      }
      
      public function loadGameData() : void
      {
         var _loc1_:IValueObject = this.m_saveLoadManager.load("local");
         this.m_playerController.loadValueObject(_loc1_);
      }
      
      public function registerGameObjects() : void
      {
         var _loc1_:GameFactory = this.m_gameComponents.getComponent("GameFactory");
         var _loc2_:PathFactory = this.m_gameComponents.getComponent("PathFactory");
         var _loc3_:AnimationPlayerFactory = this.m_gameComponents.getComponent("AnimationPlayerFactory");
         var _loc4_:MeleeWeaponFactory = this.m_gameComponents.getComponent("MeleeWeaponFactory");
         var _loc5_:ProjectileWeaponFactory = this.m_gameComponents.getComponent("ProjectileWeaponFactory");
         var _loc6_:ExplosionFactory = this.m_gameComponents.getComponent("ExplosionFactory");
         DisplayTypes.register(_loc1_);
         PathTypes.register(_loc2_);
         Animations.register(_loc3_);
         EntityTypes.register(_loc1_,_loc2_,_loc3_);
         ProjectileTypes.register(_loc5_,_loc3_);
         ProjectileWeaponTypes.register(_loc5_);
         MeleeWeaponTypes.register(_loc4_,_loc3_);
         ExplosionTypes.register(_loc6_,_loc3_);
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(width + height > 0)
         {
            this.m_achievementTickRegulator.update(param1);
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:ContextMenu = null;
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         Root.stage.stageFocusRect = false;
         if(GameEngineSettings.ENABLE_CONTEXT_MENU)
         {
            _loc2_ = new ContextMenu();
            _loc2_.hideBuiltInItems();
            contextMenu = _loc2_;
         }
         if(GameEngineSettings.ENABLE_PROFILER)
         {
            SWFProfiler.init(stage,this);
         }
      }
      
      public function registerGameItems() : void
      {
         var _loc2_:XML = null;
         var _loc3_:Item = null;
         var _loc1_:XML = XML(new Assets.ITEMS_XML());
         for each(_loc2_ in _loc1_.item)
         {
            _loc3_ = new Item(new ItemParams({
               "id":_loc2_.id,
               "name":_loc2_.name,
               "type":_loc2_.type,
               "info":_loc2_.info,
               "icon":_loc2_.icon,
               "value":_loc2_.value,
               "reach":_loc2_.reach,
               "damage":_loc2_.damage,
               "explosionDamage":_loc2_.explosionDamage,
               "direction":_loc2_.direction
            }));
            this.m_globalInventory.addItem(_loc3_);
         }
      }
      
      public function registerPlayer() : void
      {
         var _loc1_:Inventory = this.m_playerController.inventory;
      }
      
      private function logSystemCapabilities() : void
      {
         Log.CustomMetric(Capabilities.os,"Operating System");
         Log.CustomMetric(Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY,"Screen Resolution");
         Log.CustomMetric(Capabilities.version,"Flash Player Version");
         Log.CustomMetric(Capabilities.language,"Language");
      }
      
      public function registerAchievements() : void
      {
         var _loc1_:AchievementLoader = new AchievementLoader(this.m_achievementManager);
         _loc1_.load();
      }
      
      public function registerLevels() : void
      {
         this.m_gameLevelManager.addSkyXML("sky1",XML(new Assets.SKY_1_XML()));
         this.m_gameLevelManager.addHouseXML("house1",XML(new Assets.HOUSE_1_XML()));
         this.m_gameLevelManager.addGameLevelXML("demolevel",XML(new Assets.DEMO_LEVEL()));
         this.m_gameLevelManager.addGameLevelXML("stresstestlevel",XML(new Assets.STRESS_TEST_LEVEL()));
         this.m_gameLevelManager.addGameLevelXML("level001",XML(new Assets.GAME_LEVEL_1()));
         this.m_gameLevelManager.addGameLevelXML("level002",XML(new Assets.GAME_LEVEL_2()));
         this.m_gameLevelManager.addGameLevelXML("level003",XML(new Assets.GAME_LEVEL_3()));
         this.m_gameLevelManager.addGameLevelXML("level004",XML(new Assets.GAME_LEVEL_4()));
         this.m_gameLevelManager.addGameLevelXML("level005",XML(new Assets.GAME_LEVEL_5()));
         this.m_gameLevelManager.addGameLevelXML("level006",XML(new Assets.GAME_LEVEL_6()));
         this.m_gameLevelManager.addGameLevelXML("level007",XML(new Assets.GAME_LEVEL_7()));
         this.m_gameLevelManager.addGameLevelXML("level008",XML(new Assets.GAME_LEVEL_8()));
         this.m_gameLevelManager.addGameLevelXML("level009",XML(new Assets.GAME_LEVEL_9()));
         this.m_gameLevelManager.addGameLevelXML("level010",XML(new Assets.GAME_LEVEL_10()));
         this.m_gameLevelManager.addGameLevelXML("level011",XML(new Assets.GAME_LEVEL_11()));
         this.m_gameLevelManager.addGameLevelXML("level012",XML(new Assets.GAME_LEVEL_12()));
         this.m_gameLevelManager.addGameLevelXML("level013",XML(new Assets.GAME_LEVEL_13()));
         this.m_gameLevelManager.addGameLevelXML("level014",XML(new Assets.GAME_LEVEL_14()));
         this.m_gameLevelManager.addGameLevelXML("level015",XML(new Assets.GAME_LEVEL_15()));
         this.m_gameLevelManager.addGameLevelXML("level016",XML(new Assets.GAME_LEVEL_16()));
         this.m_gameLevelManager.addGameLevelXML("level017",XML(new Assets.GAME_LEVEL_17()));
         this.m_gameLevelManager.addGameLevelXML("level018",XML(new Assets.GAME_LEVEL_18()));
         this.m_gameLevelManager.addGameLevelXML("level019",XML(new Assets.GAME_LEVEL_19()));
         this.m_gameLevelManager.addGameLevelXML("level020",XML(new Assets.GAME_LEVEL_20()));
         this.m_gameLevelManager.addGameLevelXML("level021",XML(new Assets.GAME_LEVEL_21()));
         this.m_gameLevelManager.addGameLevelXML("level022",XML(new Assets.GAME_LEVEL_22()));
         this.m_gameLevelManager.addGameLevelXML("level023",XML(new Assets.GAME_LEVEL_23()));
         this.m_gameLevelManager.addGameLevelXML("level024",XML(new Assets.GAME_LEVEL_24()));
         this.m_gameLevelManager.addGameLevelXML("level025",XML(new Assets.GAME_LEVEL_25()));
      }
      
      public function initFogDevAPI(param1:FogDevAPI) : void
      {
         this.m_gameComponents.registerComponent("FogAPI",param1);
      }
      
      public function registerScreens() : void
      {
         this.m_screenManager.registerScreen("SponsorScreen",SponsorScreen);
         this.m_screenManager.registerScreen("IntroScreen",IntroScreen);
         this.m_screenManager.registerScreen("OutroScreen",OutroScreen);
         this.m_screenManager.registerScreen("MainScreen",MainScreen);
         this.m_screenManager.registerScreen("GameScreen",GameScreen);
         this.m_screenManager.registerScreen("PauseScreen",PauseScreen);
         this.m_screenManager.registerScreen("OptionsScreen",OptionsScreen);
         this.m_screenManager.registerScreen("CreditsScreen",CreditsScreen);
         this.m_screenManager.registerScreen("PlayerSetupScreen",PlayerSetupScreen);
         this.m_screenManager.registerScreen("AchievementsScreen",AchievementsScreen);
         this.m_screenManager.registerScreen("ItemShopScreen",ItemShopScreen);
         this.m_screenManager.registerScreen("LevelSelectScreen",LevelSelectScreen);
         this.m_screenManager.registerScreen("LevelPassedScreen",LevelPassedScreen);
         this.m_screenManager.registerScreen("LevelFailedScreen",LevelFailedScreen);
         this.m_screenManager.registerScreen("TutorialScreen",TutorialScreen);
      }
   }
}

