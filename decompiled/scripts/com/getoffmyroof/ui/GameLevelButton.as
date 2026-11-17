package com.getoffmyroof.ui
{
   import com.getoffmyroof.rewards.LevelRewards;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   
   public class GameLevelButton extends GameButton
   {
      
      public var mc_icon:MovieClip;
      
      private var m_debugLevel:Boolean;
      
      public var silver_medal:MovieClip;
      
      private var m_title:String;
      
      public var txt_title:TextField;
      
      private var m_levelID:String;
      
      public var star_medal:MovieClip;
      
      public var bronze_medal:MovieClip;
      
      public var gold_medal:MovieClip;
      
      private var m_iconFrame:int;
      
      private var m_medal:int;
      
      private var m_isLocked:Boolean;
      
      private var m_id:String;
      
      public function GameLevelButton()
      {
         super();
      }
      
      public function init(param1:GameLevelButtonParams) : void
      {
         this.m_id = param1.id;
         this.m_title = param1.title;
         this.m_levelID = param1.levelID;
         this.m_medal = param1.medal;
         this.m_iconFrame = param1.iconFrame;
         this.m_isLocked = param1.isLocked;
         this.m_debugLevel = param1.debugLevel;
         this.setIcon();
         this.setLock();
         this.setMedal();
         this.setTitle();
      }
      
      private function setTitle() : void
      {
         this.txt_title.htmlText = "<b>" + this.m_title + "</b>";
      }
      
      public function get id() : String
      {
         return this.m_id;
      }
      
      public function get title() : String
      {
         return this.m_title;
      }
      
      public function get isLocked() : Boolean
      {
         return this.m_isLocked;
      }
      
      public function get levelID() : String
      {
         return this.m_levelID;
      }
      
      public function get debugLevel() : Boolean
      {
         return this.m_debugLevel;
      }
      
      private function setLock() : void
      {
         var _loc1_:ColorTransform = null;
         if(this.m_isLocked && !this.m_debugLevel)
         {
            isEnabled = false;
            buttonMode = false;
            gotoAndStop("locked");
            _loc1_ = new ColorTransform();
            _loc1_.color = 0;
            this.mc_icon.transform.colorTransform = _loc1_;
         }
      }
      
      private function setMedal() : void
      {
         if(this.m_medal == LevelRewards.GOLD_STAR_MEDAL)
         {
            this.star_medal.alpha = 1;
         }
         if(this.m_medal == LevelRewards.GOLD_MEDAL)
         {
            this.gold_medal.alpha = 1;
         }
         if(this.m_medal == LevelRewards.SILVER_MEDAL)
         {
            this.silver_medal.alpha = 1;
         }
         if(this.m_medal == LevelRewards.BRONZE_MEDAL)
         {
            this.bronze_medal.alpha = 1;
         }
      }
      
      public function get medal() : int
      {
         return this.m_medal;
      }
      
      private function setIcon() : void
      {
         if(this.m_iconFrame != 0)
         {
            this.mc_icon.gotoAndStop(this.m_iconFrame);
         }
         else
         {
            this.mc_icon.stop();
            this.mc_icon.visible = false;
         }
      }
   }
}

