package com.getoffmyroof.screens
{
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.engine.GameEngineSettings;
   import com.getoffmyroof.levels.GameLevelManager;
   import com.getoffmyroof.rewards.LevelRewards;
   import com.getoffmyroof.rewards.PlayerRewards;
   import com.getoffmyroof.ui.GameLevelButton;
   import com.getoffmyroof.ui.GameLevelButtonParams;
   import com.greensock.TweenMax;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   import com.whatthefawk.ui.Scrollbar;
   import com.whatthefawk.utils.Input;
   import com.whatthefawk.utils.KeyCode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol526")]
   public class LevelSelectScreen extends AScreen
   {
      
      public var btn_main_menu:btn_main_menu_class;
      
      public var scroll_content:MovieClip;
      
      private var m_audioManager:AudioManager;
      
      public var scroll_mask:MovieClip;
      
      private var m_screenManager:ScreenManager;
      
      private var m_debugLevels:Boolean = false;
      
      private var m_buttonCols:int = 5;
      
      private var m_buttonSpacing:int = 10;
      
      public var scrollbar:Scrollbar;
      
      private var m_levelButtonParams:Array = [{
         "id":"level001",
         "title":"Day 1",
         "iconFrame":1
      },{
         "id":"level002",
         "title":"Day 2",
         "iconFrame":2
      },{
         "id":"level003",
         "title":"Day 3",
         "iconFrame":3
      },{
         "id":"level004",
         "title":"Day 4",
         "iconFrame":4
      },{
         "id":"level005",
         "title":"Day 5",
         "iconFrame":5
      },{
         "id":"level006",
         "title":"Day 6",
         "iconFrame":6
      },{
         "id":"level007",
         "title":"Day 7",
         "iconFrame":7
      },{
         "id":"level008",
         "title":"Day 8",
         "iconFrame":8
      },{
         "id":"level009",
         "title":"Day 9",
         "iconFrame":9
      },{
         "id":"level010",
         "title":"Day 10",
         "iconFrame":10
      },{
         "id":"level011",
         "title":"Day 11",
         "iconFrame":11
      },{
         "id":"level012",
         "title":"Day 12",
         "iconFrame":12
      },{
         "id":"level013",
         "title":"Day 13",
         "iconFrame":13
      },{
         "id":"level014",
         "title":"Day 14",
         "iconFrame":14
      },{
         "id":"level015",
         "title":"Day 15",
         "iconFrame":15
      },{
         "id":"level016",
         "title":"Day 16",
         "iconFrame":16
      },{
         "id":"level017",
         "title":"Day 17",
         "iconFrame":17
      },{
         "id":"level018",
         "title":"Day 18",
         "iconFrame":18
      },{
         "id":"level019",
         "title":"Day 19",
         "iconFrame":19
      },{
         "id":"level020",
         "title":"Day 20",
         "iconFrame":20
      },{
         "id":"level021",
         "title":"Day 21",
         "iconFrame":21
      },{
         "id":"level022",
         "title":"Day 22",
         "iconFrame":22
      },{
         "id":"level023",
         "title":"Day 23",
         "iconFrame":23
      },{
         "id":"level024",
         "title":"Day 24",
         "iconFrame":24
      },{
         "id":"level025",
         "title":"Day 25",
         "iconFrame":25
      }];
      
      private var m_gameLevelManager:GameLevelManager;
      
      private var m_playerController:PlayerController;
      
      private var m_levelButtons:Array;
      
      public var scroll_area:MovieClip;
      
      public function LevelSelectScreen(param1:IScreenItem = null)
      {
         super(param1);
         this.m_audioManager = GameComponents.instance.getAudioManager();
         this.m_screenManager = GameComponents.instance.getScreenManager();
         this.m_gameLevelManager = GameComponents.instance.getComponent("GameLevelManager");
         this.m_playerController = GameComponents.instance.getComponent("PlayerController");
         if(!this.m_audioManager.isPlaying("MenuMusic"))
         {
            this.m_audioManager.play("MenuMusic",100,1,0,"MenuMusic");
         }
         this.initButtons();
         this.initLevelButtons(this.m_levelButtonParams);
      }
      
      private function onLevelButtonClick(param1:Event) : void
      {
         var _loc2_:GameLevelButton = GameLevelButton(param1.currentTarget);
         if(_loc2_.isLocked && !_loc2_.debugLevel)
         {
            return;
         }
         this.loadGameLevel(_loc2_.levelID);
      }
      
      private function initLevelButtons(param1:Array) : void
      {
         var _loc8_:Object = null;
         var _loc9_:LevelRewards = null;
         var _loc10_:GameLevelButton = null;
         var _loc11_:GameLevelButtonParams = null;
         this.m_levelButtons = [];
         var _loc2_:Point = new Point();
         var _loc3_:Sprite = new Sprite();
         var _loc4_:PlayerRewards = this.m_playerController.rewards;
         var _loc5_:Boolean = true;
         var _loc6_:Number = 0.05;
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            _loc8_ = param1[_loc7_];
            _loc9_ = _loc4_.getLevelRewards(_loc8_.id);
            _loc10_ = new Assets.LEVEL_BUTTON();
            _loc11_ = new GameLevelButtonParams({
               "id":_loc8_.id,
               "title":_loc8_.title,
               "levelID":_loc8_.id,
               "iconFrame":_loc8_.iconFrame,
               "isLocked":!_loc5_,
               "medal":(_loc9_ ? _loc9_.medal : LevelRewards.NO_MEDAL),
               "debugLevel":this.m_debugLevels
            });
            _loc10_.init(_loc11_);
            _loc10_.x = _loc2_.x;
            _loc10_.y = _loc2_.y;
            _loc10_.addEventListener(MouseEvent.CLICK,this.onLevelButtonClick,false,0,true);
            TweenMax.from(_loc10_,0.3,{
               "delay":_loc6_ * _loc7_,
               "alpha":0
            });
            this.m_levelButtons.push(_loc10_);
            _loc3_.addChild(_loc10_);
            _loc2_.x += _loc10_.width + this.m_buttonSpacing;
            if((_loc7_ + 1) % this.m_buttonCols == 0)
            {
               _loc2_.x = 0;
               _loc2_.y += _loc10_.height + this.m_buttonSpacing;
            }
            _loc5_ = _loc9_ != null ? _loc9_.complete : false;
            _loc7_++;
         }
         this.scroll_content.addChild(_loc3_);
         _loc3_.x = this.scroll_mask.width / 2 - _loc3_.width / 2;
         _loc3_.y += 10;
         Scrollbar(this.scrollbar).init(this.scroll_content,this.scroll_mask,this.scroll_area);
      }
      
      private function initButtons() : void
      {
         this.btn_main_menu.addEventListener(MouseEvent.CLICK,this.onMainMenuClick,false,0,true);
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         this.handleInput();
      }
      
      private function handleInput() : void
      {
         var _loc1_:Input = Input.instance;
         if(!GameEngineSettings.DEBUG_MODE)
         {
            return;
         }
         if(_loc1_.isKeyDown(KeyCode.CONTROL) && _loc1_.isKeyPressed(KeyCode.ONE))
         {
            this.loadGameLevel("demolevel");
         }
         else if(_loc1_.isKeyDown(KeyCode.CONTROL) && _loc1_.isKeyPressed(KeyCode.TWO))
         {
            this.loadGameLevel("stresstestlevel");
         }
         else if(_loc1_.isKeyDown(KeyCode.CONTROL) && _loc1_.isKeyPressed(KeyCode.THREE))
         {
            this.loadGameLevel("emptylevel");
         }
      }
      
      private function onMainMenuClick(param1:Event) : void
      {
         this.m_screenManager.setScreen("MainScreen");
      }
      
      private function loadGameLevel(param1:String) : void
      {
         this.m_gameLevelManager.selectGameLevel(param1);
         this.m_screenManager.setScreen("GameScreen");
      }
      
      override public function dispose() : void
      {
         var _loc1_:GameLevelButton = null;
         this.m_audioManager = null;
         this.m_screenManager = null;
         this.m_gameLevelManager = null;
         this.m_playerController = null;
         this.btn_main_menu.removeEventListener(MouseEvent.CLICK,this.onMainMenuClick);
         for each(_loc1_ in this.m_levelButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onLevelButtonClick);
         }
         this.m_levelButtons = null;
         this.m_levelButtonParams = null;
         super.dispose();
      }
   }
}

